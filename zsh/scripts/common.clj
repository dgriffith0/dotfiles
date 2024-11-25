(ns common 
  (:require
   [babashka.fs :as fs]
   [babashka.process :as process]
   [clojure.string :as str]))

(def home (str (fs/home)))

(defn fzf
  [s]
  (-> @(process/process ["fzf"] {:in s
                         :err :inherit
                         :out :string})
      :out
      str/trim-newline))

