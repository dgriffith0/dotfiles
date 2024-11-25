(ns edit-file
  (:require
   [babashka.process :refer [shell process]]
   [clojure.string :as str]
   common))

(defn find-files
  []
  (-> @(process ["find" common/home
                         "-type" "f"]
                        {:err :inherit
                         :out :string})
      :out))

(defn -main []
  (let [choice (common/fzf (find-files))]
    (when-not (str/blank? choice)
      (shell "nvim" "choice")
      )))
