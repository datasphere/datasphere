module RDF where

{--

  How much of RDF data structure and manipulation do I need for the front-end? If the underlying data format 
  at the frontend is a graph, then does it need to be expressible in RDF? If it is only a graph (not RDF) 
  then it should be serializable as a graph (i.e. [Nodes] and [Edges] as in d3?)

    Graph visualisation
    RDF generation: Do I need a server roundtrip?

--}

import List
import Set
import RDF.Graph (..)

type Resource = IRI String | Literal String | BNode BNodeId

type BNodeId = Int

type RDFGraph = Ground (Graph Resource) | Exists (BNodeId -> RDFGraph)