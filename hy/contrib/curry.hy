(import inspect functools)


(defn curry [func]
  (let [[sig (if-python2
               (.getargspec inspect func)
               (.signature inspect func))]

        [count (if-python2
                 (len sig.args)
                 (len sig.parameters))]]

    (fn [&rest args]
      (if (< (len args) count)
        (apply functools.partial (+ [(curry func)] (list args)))
        (apply func args)))))


(defmacro fnc [args &rest body]
  `(do (import hy.contrib.curry)
       (with-decorator hy.contrib.curry.curry (fn [~@args] ~@body))))


(defmacro defnc [name args &rest body]
  `(def ~name (fnc [~@args] ~@body)))
