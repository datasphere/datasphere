(ns datasphere-castra.api
  (:require [tailrecursion.castra :refer [defrpc]]))

(def counter (atom 0))

(defrpc get-state []
  {:rpc/query [{:random (rand-int 100)
                :counter @counter}]}
  (swap! counter inc))