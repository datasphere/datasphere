# Modularity / Libraries

## Overall

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


## Developer Experience

There should be a Try Metasphere with code, debugger,...

Maybe it should appear like node, i.e. for the most of the first layer it should feel like its a new javascript framework, but then the submerged side of the iceberg is haskell.

What about different frameworks:
  * Node - npm install -g metasphere-dev ? Should there be metasphere-processing / metasphere-store
  * Meteor - 
  * WebComponents 
  * Angular
  * Elm
  * Purescript
  * Express
  * Backbone

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
     + 

Atom-shell with node in the backend opens avenues for using native-modules and things like dat.

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
