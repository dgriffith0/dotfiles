(ns tmux-sessionizer
  (:require
   [babashka.fs :as fs]
   [babashka.process :refer [process shell]]
   [clojure.string :as str]
   common))

(defn get-session-name
  "Returns a tmux friendly session or exits if no option
  was selected at the fuzzy finder prompt."
  [dir]
  (if (str/blank? dir)
    (System/exit 0)
    (str/replace (fs/file-name dir) #"\." "_")))

(defn find-project-files
  []
  (-> @(process ["find" common/home
                 (str common/home "/dev/")
                 (str common/home "/.config/")
                 "-maxdepth" "1"
                 "-mindepth" "1"
                 "-type" "d"]
                {:err :inherit
                 :out :string})
      :out))

(defn inside-tmux?
  "Check if the tmux env var is set and 
  the tmux process is running"
  []
  (let [result (process {:err :inherit}
                        "pgrep" "tmux")]
    (and (System/getenv "TMUX")
         (= (:exit @result) 0))))

(defn tmux-session-exists?
  "Error Code 1 indicates it doesnt exist
   Error Code 0 indicates it exists"
  [session-name]
  (let [result (process {:continue true} "tmux" "has-session" "-t" session-name)]
    (= 0 (:exit @result))))

(defn start-tmux-session
  "If we are outside of Tmux, the attached state can both create and enter the new session
  but inside tmux, detached is preferred so that it can be switched too preventing nested sessions."
  [session-name start-directory & {:keys [detached] :or {detached false}}]
  (shell "tmux" "new-session" (str "-" (when detached "d") "s") session-name "-c" start-directory))

(defn attach-tmux-session
  "When not inside tmux, attach will create and enter the new session"
  [session-name]
  (shell {:continue true} "tmux" "attach" "-t" session-name))

(defn switch-to-session
  "When inside tmux, switching client will move to the requested session
  Once we've switch sessions exit."
  [session-name]
  (shell {:continue true} "tmux" "switch-client" "-t" session-name)
  (System/exit 0))

(defn get-current-session []
  (str/replace
   (-> @(process ["tmux" "display-message" "-p" "'#S'"]
                 {:err :inherit
                  :out :string})
       :out
       str/trim-newline)
   #"\'" ""))

(defn same-session? [session-name]
  (= (get-current-session) session-name))

(defn start-detached-and-switch
  "Do this when inside Tmux and creating a new session.
  'detached' prevents us from nesting sessions. Calls 
  switch and exits."
  [session-name dir]
  (start-tmux-session session-name dir {:detached true})
  (switch-to-session session-name))

(defn -main [& _args]
  (let [dir (common/fzf (find-project-files))
        session-name (get-session-name dir)
        _ (when (inside-tmux?)
            (if (tmux-session-exists? session-name)
              (if (same-session? session-name)
                (System/exit 0)
                (switch-to-session session-name))
              (start-detached-and-switch session-name dir)))
        _ (if (tmux-session-exists? session-name)
            (attach-tmux-session session-name)
            (start-tmux-session session-name dir {:detached false}))]))
