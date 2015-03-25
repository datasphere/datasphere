# Metasphere

# Functional specs

## Pathways

Set to List to Set
  * Unordered Items 
  * Ordered Items (smart default - like created date)

List to Tree to Graph

List to Table to Tree

## Model


## Perspectives

Structure and Representations
  * Perspective (Structure s, Representation r)

Possible Perspectives
  * (Set, Spatial)
  * (Set, Tabular)
  * (Set, Sequential)

### Structures

  * Set
      - Add item
      - Remove item
      - Update item
  * Table
      - Update item properties
  * Tree
      - Update parent
      - Indent (alias for Update previous item)
  * Graph
      - Update node
      - Update edge

### Representations

Spatial
  * Spatial.ForceDirected
  * Spatial.Sets

Tabular
  * Tabular.Unordered
  * Tabular.Columns
  * Tabular.Pivot

Linear
  * Linear.Equidistant
  * Linear.Proportional

## Notes

Think about Metasphere in terms of Haskell software architecture.

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

