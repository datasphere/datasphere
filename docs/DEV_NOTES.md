# Development Notes

* A blank chestnut template with ```lein new chestnut datasphere -- --http-kit --om-tools --speclj```
* Updating dependencies.
* Progressively add code from https://github.com/kovasb/session
* goog.History is used as a type of polyfill for browser history management (including using iFrames).
* **session** seem to declare the async channels in the system object. **omchaya** declares an api channel and a controls channel and very nicely separates them as a pure declarative controller (api.cljs and controls.cljs) and an imperative post processing controller (post_api.cljs and post_controls.cljs).
  * The controls.cljs for instance listens to the controls-ch channel and only assoc-in the state data.

  ```
    (defmethod control-event :audio-player-muted
      [target message args state]
      (assoc-in state [:audio :muted] true))
  ```

* Updated LightTable, lein-light-nrepl, figwheel, figwhell-sidecar, cljsbuild (https://github.com/bhauman/lein-figwheel/issues/119) to deal with fs version issue and LightTable eval (still not solved https://github.com/LightTable/LightTable/issues/1845#issuecomment-91566003)

* What's the minimum I need to deal with the bullet points example?
