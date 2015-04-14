;; Copyright (c) Alan Dipert and Micha Niskin. All rights reserved.
;; The use and distribution terms for this software are covered by the
;; Eclipse Public License 1.0 (http://opensource.org/licenses/eclipse-1.0.php)
;; which can be found in the file epl-v10.html at the root of this distribution.
;; By using this software in any fashion, you are agreeing to be bound by
;; the terms of this license.
;; You must not remove this notice, or any other, from this software.

(ns datasphere-castra.core
  (:require
    [ring.adapter.jetty               :refer [run-jetty]]
    [ring.middleware.resource         :refer [wrap-resource]]
    [ring.middleware.session          :refer [wrap-session]]
    [ring.middleware.session.cookie   :refer [cookie-store]]
    [ring.middleware.file             :refer [wrap-file]]
    [ring.middleware.file-info        :refer [wrap-file-info]]
    [tailrecursion.castra.handler     :refer [castra]]))

(def app
  (-> (castra 'datasphere-castra.api)
      (wrap-session)
      (wrap-file "resources/public")
      (wrap-file-info)))
