(import inspect functools)


(defn curry [func]
  (let [[sig (.signature inspect func)]
        [count (len sig.parameters)]]
    (fn [&rest args]
      (if (< (len args) count)
        (apply functools.partial (+ [(curry func)] (list args)))
        (apply func args)))))


(defmacro fnc [args &rest body]
  `(do (import hy.contrib.curry)
       (with-decorator hy.contrib.curry.curry (fn [~@args] ~@body))))


(defmacro defnc [name args &rest body]
  `(def ~name (fnc [~@args] ~@body)))
