(set-env!
  :project        'datasphere
  :version        "0.1.0-SNAPSHOT"
  :dependencies   '[[adzerk/boot-cljs-repl     "0.1.10-SNAPSHOT" :scope "test"]
                    [adzerk/boot-reload        "0.2.6" :scope "test"]
                    [pandeiro/boot-http        "0.6.3-SNAPSHOT" :scope "test"]
                    [adzerk/boot-cljs          "0.0-2814-4" :scope "test"]
                    [cljsjs/boot-cljsjs        "0.4.7" :scope "test"]
                    [lein-light-nrepl          "0.1.0-LOCAL" :scope "test"]
                    [tailrecursion/boot-hoplon "0.1.0-SNAPSHOT" :scope "test"]
                    [tailrecursion/hoplon      "6.0.0-SNAPSHOT"]
                    [tailrecursion/castra      "2.2.2"]
                    [markdown-clj              "0.9.62"]]

  :target-path    "resources/public"
  :source-paths   #{"src/hl" "src/cljs" "src/clj"}
  :asset-paths    #{"assets"})

(require
  '[adzerk.boot-cljs :refer [cljs]]
  '[adzerk.boot-cljs-repl :refer [cljs-repl start-repl]]
  '[adzerk.boot-reload :refer [reload]]
  '[pandeiro.boot-http :refer [serve]]
  '[cljsjs.boot-cljsjs :refer [from-cljsjs]]
  '[lighttable.nrepl.handler :refer [lighttable-ops]]
  '[tailrecursion.boot-hoplon :refer [hoplon prerender html2cljs]])

(deftask light-repl
   "Start an Emacs Cider REPL."
   []
   (repl :middleware (map resolve lighttable-ops)
         :server true)
   (wait))

(deftask dev
  "Build datasphere for development."
  []
  (comp
    (serve :handler 'datasphere-castra.core/app :resource-root "resources/public" :reload true)
    (watch)
    (hoplon :pretty-print true)
    (reload)
    (speak)
    #_(cljs-repl)
    (cljs :optimizations :none :source-map)))

(deftask production
  "Build datasphere for production."
  []
  (comp
    (hoplon :pretty-print true)
    (cljs :optimizations :advanced :source-map)
    (prerender)))
