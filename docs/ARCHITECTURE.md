# Modularity / Libraries

## Overall

  * State: Single state with cursors (zippers/lenses)
  * Communication: Async Queues (Channels / Tags)
  * Correctness by design: for extensibilty.

  * Data-driven: The document in the user's interface is the data. The structure (schema) is data-driven (as in Entity Component System).
  * Value oriented:

Architectural goals of the project (from Light Table):

 * (Runtime modifiability) not fundamental but that's a huge plus to have.
 * High contextuality
 * Infinitely customizable

BOT composes behaviors while ECS composes state... I think we need both. At least we need to compose behaviors for making the UI extensible, but we probably need to make extensions being able to manipulate user state as a composable thing. But we might not need to do the user bit with ECS, (unless there's performance and simplicity advantages to this, so I should look more into it) and we should at least have immutable values, and have explicit transforms, i.e. transformations as values too. Then we can also introspect on user data transform and extend that.

Maybe that means that Context needs to be added to the mix, as in triples need to be quads, or BOT needs to be BOTD?

## Inspiration

  * https://github.com/kovasb/session
  * https://github.com/LightTable/LightTable
  * https://github.com/sgrove/omchaya#omchaya-design

![](https://github.com/sgrove/omchaya/raw/master/docs/resources/omchaya_flow.png)

## BOT

BOT is a better fit for an **evented** architecture than ECS where you don't have as many variations on the state of similar things, variation, instead, comes from how items react to events. What does this mean?
  - How does ECS have many variations on the state of similar things? Probably that your similar things are things like game objects (like platforms or ennemies) and that they have a lot of variations because they're instantiated many times with slightly different parameters (i.e. lots of variations of state).
  - What does it mean to have variation coming from how items react to event? Probably that in that case, you don't have as many variations of the same objects (you have only a few tabs, one console, one folder workspace and so on) but they each have complex ways in which they behave.

This might not apply to datasphere because in our case, the content of the document displayed in the editor might use several wildly different editor-plugins and have widly different state. It's also likely that they will share state. So maybe instead of ```ClojureScript maps to represent objects instead of the groupings of many maps that was used in CES.```. We might want to see what happens if we keep grouping many maps (which I think means keeping the notion of "interface" or "protocol" as a first-class citizen particularly for plugins to work with, but also to define).

```ClojureScript
(object* :notifier
         :triggers [:notifo.click :notifo.timeout]
         :behaviors [:remove-on-timeout :on-click-rem!]
         :init (fn [this]
                 [:ul#notifos
                   (map-bound (partial notifo this) notifos)]))
```

To create this notifier object we use ```(object/create :notifier)```, which simply sticks a copy of that map into a big data structure containing all our objects. I think that's fine.

An object has a behavior collection. Looks like tag would do it in terms of expressivity, but I'm worried to see how Lighttable seems a bit sluggish... It does seem very elegant though, so maybe I should still consider it. Maybe using the pattern in another language... Maybe replacing the rendering with om. (http://blog.atom.io/2014/07/02/moving-atom-to-react.html)

Tags as Async Channels is the way to go.

### ECS

Components are the modular bit (i.e. like interfaces). They are assembled into "complete" objects. The specifications for assembling objects are data driven. (does this *need* a homoiconic language? Probably doesn't and might go against FrelP approach)

Seems like the OOP encapsulation approach implies a hierarchical model of inheritance which gets tricky with needs for multiple inheritance and the artificial abstractions that get created, along with the difficulty to track the logic when the inheritance tree is implicit.

ECS flattens this. Components are small and are "sort of values in an entity predicate value" triple. But they encapsulate behavior logic. They also hold state.

The assignment of Components to Entities define the schema. Let's try for datasphere:
```ClojureScript

   (component text [t]
     :t t)

   (component list l
     :l l) ;; Actual language list?

   (component graph g
     :g g) ;;

   (component table);;....

```

I don't know though because these feel like accidental state in FRelP. I'm not adding all of these to the state, they are perspectives on the state so I don't think it works. The essential state is really just an RDF Statement or a Datom, basically a quad or something. That's the essential data and everything else is derived, isn't it? So then an entity is just a list of statements/facts.

DataSphere plugins might be components.

## CSP

Maybe Triggers of BOT should be CSP queues.

## Components

They are pipes/components somewhere maybe either:

 * between the user and the essential state (either as an input transformer or an output transformer),
   * formatters: output formatters?/transformers examples...
     * source mode (for hacking, focus on structure or logic, text mode, shorcuts, explicit, allow modification of implicits)
       * markdown like syntax.
       * textile like syntax
       * lisp like/clojure like/...
       * csv like
       * json like
     * edit mode (for editing, focus on content and workflow, should allow to do almost all of the source mode but sometimes options will be behind several navigation levels, still shortcuts, more visual cues rather than textual cues)
     * present mode (for publication, focus on content and interactivity)
   * modifiers: input modifiers? maybe its not formatter dependent?
     * generic modifiers
       * data type detection (when copy pasting, when using an external link, when repeating structure,...)
     * source modifiers
       * input-emacs
       * input-vi...
     * edit modifiers
       * shorcuts
       *
   * data editing widgets (these should be extensible too).

Tricky question about whether there should be some interop of output/input and possibly components that include both... i.e. can a table editing component be reused with different source-mode formatters or edit-mode formatters? I guess it should be also possible to extend a table component with specialised transformers to extend it. Probably the table component should be in core with a stable API and there should be possible alternatives in contrib.

 * As a generator of derived state (maybe the same thing as an output transformer? but for storage rather than interface).
 * As a transformer of essential state (to manipulate the data, so components need to have a way to hook into effects - triggered by users, by schedule, by systems constraints, by user specified business logic).
 * As the persistence layer for essential state (and derived state).
 * As logic constraining state (defining structure/schema/integrity...)

So with the value driven approach, all of these need to have access to "the whole of the data" as a value. That whole can be a user's document (but with loose boundaries as soon as a document's statement is linked to other documents, a query, a graph,...). Lazy loaded content getters (like a scraper, an asynchronous "human size" process - i.e. waiting for, a crowdsourcing app). Are these content getters queries or do they have a component interface? What does it mean to install the crowdcrafting plugin into datasphere?

  * Exploratory
    * I see it in the list of plugins
    * I download the plugin and install it.
  * I am designing a crowdsourced data driven journalism piece.
    * I design my document with visualisations intertwined with narrative. Some data is sourced from official sources, and I want to compare it with data sourced from the crowd.
    * Which data? Let's take the Correctiv example. The identification of key data points inside a database of PDFs.

```
doc Sparkasse Investigation
text We're investigating the Sparkasse empire and who is...
section
  text We want to do this because...

section example
  text here's an example of what we would like you to help us with.
  image pdf-doc.png
  text This is a PDF like the one we have available in our data base.

section crowdsourced
  text Here's the data we received so far.
  data :type table :sort updated
    file :url http://example.org/example_bootstrapping.json
    crowd :account correctiv@crowdcrafting.org :key !@#@#FK#$
    source :type sparql :name dbpedia :url
    source :type ldp :name transformap
    source :type ldf :name plp

section participate
  text
  crowd participate
```

cf [DSL.md](./DSL.md)

## State

### Essential

#### User data

##### Type of nodes

  * document
  * data
  * images
  * text

Each can be made of the other. (documents can contain images that are made from data / data can contain documents which contain text and non structured data)...

If images contain data then they can (should they? have subtypes) such as diagram or graph...

:document should be the default.

#### Application data

  * loaded plugins
  * user data

##### Type of components?!?

 * formatters / output transformers
 * modifiers / input transformers
 * widgets (input/output transformers)
 *


##### Type of editor modes

  * :source (also :repl?)
  * :edit
  * :present

It should be possible to create more modes. But these are provided as opiniated defaults.

 * First load should display Hello world in edit mode.
 * Saving should ask to publish to a sane web default.
 * It should be easy to view source which should have something like ```:text Hello World```


## Components

### Formatters

Formatters have scope. They can declare their scope, meaning the type of nodes they can represent. i.e. Markdown -> text / Mermaid -> diagrams /...

   * themes can package formatters.

### Connectors



## Packages?

From the Haskell Cast with Don Stewart, (which quotes a counter-example with a huge "monolithic" code base) there might be a case in writing smaller executable programs (maybe aimed at HaLVM) that interact.


  * metasphere-frontend
      - metasphere-frontend-ghcjs
      - metasphere-frontend-purescript
      - metasphere-frontend-elm
      - metasphere-frontend-angular
      - metasphere-frontend-polymer
      -
  * metasphere-processing
      - metasphere-processing-ghcjs (for browser only)
      - metasphere-processing-haskell
      - metasphere-processing-bolt-haskell
      - metasphere-processing-peer-haskell

  * metasphere-store
      - metasphere-store-levelgraphdb
      - metasphere-store-levelgraphdb
      - metasphere-store-node
      - metasphere-store-peer

  * metasphere-web-example
      - metasphere-frontend-ghcjs

  * metasphere-desktop-example
      - metasphere-installer
          + metasphere-frontend-webkit?
          + metasphere-processing-haskell
          + metasphere-store-local


## Security

Except in the Cluster or Hosted option which might be maintained behind the firewall, the default should be end to end encryption with encrypted storage. Ideally it should be possible for users to deploy their own cluster on infrastructure they own, although this is a superficial guarantee if those machines are compromised.

Point to point communications should be encrypted with TLS.

### Current choice



#### Roadmap

Maybe starting by having the flexibility of Haskell, even if it means a penalty in downloadable GHCJS size is what is needed because of the key difficulty being in the conceptual model. It will be a steep learning curve but will probably pay off in elegance and maintanability in the end.

It does seem that I also need some quick win approach on the UI side. It would be good if every thing could be demoed in the browser as well. In terms of pragmatic business angle, I should be able to demo standalone without the web and it should be quick, or from any browser and it should be quick.
  - Standalone : atom-shell + Yesod locally + Store locally. No need for web until later.
  - Web : Light browser + Yesod backend

Is there ever a need for a heavy GHCJS browser side app? I guess the only positive aspect about this is to avoid "downloading and installing" an app and therefore be more unhosted in spirit.

What about mobile? Haskell seems to go towards compiling for iOS so it could be native apps. How difficult will it be to be unhosted on mobile?

So then the roadmap should be:
 - Scratch my own itch, make sure I use it :
    + Standalone
        - atom-shell
        - chromium ->
        - node -> GHCJS
    +



#### Technologies

|------------------|----|--------------------|---------------------|----------------------------------------|
|                  | UI |       Cache        |      Processing     |                 Store                  |
|------------------|----|--------------------|---------------------|----------------------------------------|
| Unhosted         |    | LevelDB (-GraphDB) |                     | LevelDB (-GraphDB)                     |
| Unhosted Desktop |    | LevelDB (-GraphDB) | GHCJS               | (Local) Mongo + Triple store           |
| Unhosted Server  |    | LevelDB (-GraphDB) | Yesod (self-hosted) | Mongo + Triple store                   |
| Unhosted Peer    |    | LevelDB (-GraphDB) | Yesod + Hailstorm?  | Mongo + Triple store + Kafka + GnuNet? |
| Unhosted Cluster |    | LevelDB (-GraphDB) | Yesod + Hailstorm   | Mongo + Triple store + Kafka           |
| Hosted           |    | LevelDB (-GraphDB) | Yesod (hosted)      | Mongo + Triple store                   |
| Hosted Cluster   |    | LevelDB (-GraphDB) | Yesod + Hailstorm   | Mongo + Triple store + Kafka           |
|------------------|----|--------------------|---------------------|----------------------------------------|

 - **Hosted** is mainly for demonstration. The default should be Unhosted. Is it the same as Unhosted Server? Or different because the hosting happens on "our" server? Is there a difference with regards to whether only storage happens server side or also processing? There might be in terms of security in absence of HE.
 - **Unhosted** is the default. It should allows to work offline straight off. It should be quite fast to download and might have more limited features than Unhosted desktop which would download extra software for the store and processing. The key question here is whether this should avoid GHCJS or not.
 - **Unhosted Desktop** means some additional downloads but the same browser interface. In the backend, more software should help with storage and processing.

Is there a scenario where there is light processing done on the client side without GHCJS? I don't think so, that's the user experience equivalent of downloading Google Spreadsheet to work offline.


## Remote Processing

In a large data processing cloud infrastructure it might make sense to have several hardware nodes each dedicated to particular transforms and spawning "worker nodes" which interact with each other with ??? (what's the Haskell way to do that?) or we could just interact with Storm/Kafka -> See https://github.com/hailstorm-hs/hailstorm).

## Browser

Still dilemma for what should be inside atom-shell between:
 - Elm
 - Polymer - was very fast to learn. https://github.com/smaye81/functional-reactive-js-seed ? Seems not very functional, but maybe it could be made into it...
 - Some functional JS approach mixed with common tools. Like
     + json-editor
     + bootstrap


Atom-shell with node in the backend opens avenues for using native-modules and things like dat.

|--------------------|-------|-------------|----------|-----------|-----------|------|-------|----------|
|                    | Terse | Error prone | Maturity | Ecosystem | Sub-state | Perf | Adopt | Flexible |
|--------------------|-------|-------------|----------|-----------|-----------|------|-------|----------|
| Cljs/Om/core.async | -     | -           | +        | +++       | ++        | ++   | --    | ++       |
| Elm                | +     | +           | --       | --        | -         | +    | -     | --       |
| GHCJS              | +     | ++          |          | --        |           | -    |       | +        |
| JS                 | +     | ---         | +        | +++       |           | +    | ++    | +        |
|--------------------|-------|-------------|----------|-----------|-----------|------|-------|----------|

 - Clojure : Om (has good subcomponent solution) + core.async
 - Elm: Has FRP,

|------------|--------------|-------------|--------------|--------------------|-----------------|
|            |      <3      |   Desktop   | Architecture | Extension language | Je ne sais quoi |
|------------|--------------|-------------|--------------|--------------------|-----------------|
| atom       |              | atom-shell  |              | Coffeescript / JS  | Maxogden        |
| LightTable | Architecture | node-webkit | BOT          | CLJS / CSS / JS    | Eve             |
| brackets   |              |             |              |                    |                 |
|------------|--------------|-------------|--------------|--------------------|-----------------|



### Scenario modular frontend -  + GHCJS - Blaze-React scenario

In this scenario the developer experience is to download a framework locally, then be able to distribute with different packaging options.

### Notes

Possibly interface GHCJS code with Javascript/WebComponent modules. For instance:
 * For interactive UI elements using WebComponents or Javascript components might be good.
 * For LocalStorage/LevelDB/LevelGraphDB possibly.
   - With Persistent on GHCJS (if possible) we might be able to abstract Mongo into Couch?
   - Could we compile Haskell GraphDB with GHCJS? https://github.com/nikita-volkov/graph-db

Possibly interface GHCJS with Purescript with Javascript. Why?
  * GHCJS could be used for more feature full package (sort of the "downloadable" app component).
  * Purescript is more lightweight but doesn't have all the libraries.
  * Interfacing PureScript with GHCJS might lead to more complexity, in particular with regards to doing FRP. Maybe FRP in PureScript (Bodil's Elm inspired stuff) would be more performant?
  * In that case why not GHCJS / Elm and Components? Purescript seems more expressive... :( Too bad I really like Elm.
  * If the API between the UI layer and the Framework layer are well designed then one or the other should be possible. It might be desirable. So I could ship a GHCJS framework runtime which can be interfaced with through a number of JS based UI frameworks. Possibly it could interface with Node.js on servers too. Then I can move to something more efficient than GHCJS if the runtime ends up being too large. Or I can make a runtime generator which only includes needed functions to diminish the overhead. It would be good to see what the space overhead is in practice.

Possibly Auto with GHCJS https://github.com/mstksg/auto which has Locally stateful components... This seems to hide some complexity related to using a global State (managing global vs. local state with monad morphisms). Also Auto is meant for situations where time progresses in discrete ticks --- integers, not reals. Auto is not suggested even to "simulate" continuous time with discrete sampling. You can do it...but FRP is a much, much better abstraction/system for handling this than Auto is. See the later section on FRP.

Another approach is https://github.com/meiersi/blaze-react

Haste has localstorage, and HPlayground (React)

GHCJS/Blaze-react has LocalStorage and WebSockets

|-------------------|-----|-------------------|----------------|------|----|--------------|------------|---------|
|                   |  <3 |      Remarks      |     State      | HTML | TH | LocalStorage | WebSockets | LevelDB |
|-------------------|-----|-------------------|----------------|------|----|--------------|------------|---------|
| Purescript        |     | Not so pretty FRP |                |      | No |              |            |         |
| Elm               | ++  |                   |                |      | No |              |            |         |
| Fay               |     | Only HS subset    |                |      | No |              |            |         |
| ClojureScript     | +++ |                   | DataScript     |      |    |              |            |         |
|-------------------|-----|-------------------|----------------|------|----|--------------|------------|---------|
| GHCJS             |     | Missing good FRP  |                |      |    |              |            |         |
| GHCJS/Auto        |     |                   | Local          | No   |    |              |            |         |
| GHCJS/Blaze       | +   | Ok.               | Global (Store) | VDom |    | Polling      | Yes        |         |
| GHCJS/Sodium      | -   |                   |                |      |    |              |            |         |
| Haste             |     | Client-server     |                |      | No |              |            |         |
| Haste/HPlayground |     |                   |                |      |    | Yes          | Yes        |         |
| Haste/MFlow       | --- | Isomorphic        |                |      |    | Yes          | Yes        |         |
|-------------------|-----|-------------------|----------------|------|----|--------------|------------|---------|

https://github.com/yesodweb/yesod/wiki/JavaScript-Options

## DRY / XRX / JRJ / HRH

How can I define the data types once (and in fact template them...). This [diagrams-ghcjs interactive example](http://paste.hskll.org/get/183) seem to point towards automatically generating forms based on the Haskell Data types. Persistent doesn't exactly follow this model though.

Partial record validation : https://github.com/VinylRecords/Vinyl/blob/master/tests/Intro.lhs#L205-L257

Vinyl or Record?


## Type Classes

Value level instance: the most important reason that you should adopt value-level instances is precisely because they are the type-safe approach to ad-hoc polymorphism. So my current stance is that "type classes with mathematical laws are okay". My reasoning is that laws let you reason abstractly about what the type class does without consulting the source code. So, for example, I'm okay with type classes like `Monad`, `Functor`, and `Monoid`, but not with type classes like `IsWritable` or `HasFoo`. http://www.haskellforall.com/2012/05/scrap-your-type-classes.html


## Notes

Think about Metasphere in terms of Haskell software architecture.?

From XMonad [design and implementation notes](https://www.scribd.com/fullscreen/19503176?access_key=key-1w706ru80qws3onhxtyq&allow_share=true&escape=false&view_mode=slideshow)

The pure model : a zipper of window stacks
Step 1: Model your effectful program with purely functional dataStep 2: Find a natural api for it with QuickCheckStep 3: Compile it and proﬁt

Have a Zipper for in Memory graph?
 - Means attempting a Zipper on a Graph data structure.
Can you have a Zipper attached to a DB?
Use lazy data structure for the whole dataset?

Use haste + elm? Just haste?


## Persistence

### Narrative within Metasphere.

In order to allow the representation of very diverse data structures, it's important to consider what will be the most complex or flexible data structure that needs to be supported. I think this should be the RDF Graph. As such,  simpler structures - like tables or tress - which might be what is more appropriate to some data, might possibly be described as an RDF Graph and only if needed persisted with a store which gives better performance. In that sense there might be adaptive/progressive persistence strategies based on possibly tests that are ran (instrumentation of the runtime) within the user's environment and when limits are reached, give rise to the automated deployment of new strategies (aiming at removing the overhead of graph manipulation, the ceremony that might not be needed, using well known optimisations that are possible with specific stores).

There is a big question as to how that happens with our unhosted approach, but LocalStorage, LevelDB, LevelGraphDB might provide exactly the needed flexibility on the client. Allowing to extend this, or be supported by a server/cluster backend might be great and should be allowed (i.e. LDF, and so one...).

Important not to confuse the adaptive nature of the backend persistence layer with the frontend / framework flexibility with regards to data structures.


### Notes
  * In the end, a triple store makes most sense, but
  * Maybe it's useful to have other representations that are isomorphic to graphs to help with development? A la Grano? Except by storing JSON-LD documents? Maybe having an abstract graph (with no content) a la neo4j (removing more granular "document properties"), as well as a full triple/quad store?
  * How does this play with LevelGraphDB in the front end?
  * How about Haste + LevelDB + LevelGraphDB as a standalone, extensible/reinforced by optional server side graph processing (possibly a la LDF).
  * Can I build a LDP implementation on Yesod?
  * Should there be a principle of allowing multiple co-existent persistence strategies?
    - Simplest First: LevelDB if 'tabular structure' / If upgrading to 'graph structure' then move to LevelGraph?
    - Flexible First, Optimise Later: LevelGraph, create a key/pair representation as needed as an "index" a la LDF.

  * Yesod with Persistent.
    - NoSQL MongoDB. Useful for "schema less" or "schema defined elsewhere" approach. Will I miss ways to query? Can Esqueleto JOIN Mongo backends?
    -
