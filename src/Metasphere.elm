module Metasphere where

import RDF (..)

type alias Doc = { data: Data
                   , dimensions: List Dimension
                   , projections: List Projection Node
                   , perspectives: List Perspective
                   }

{- Data is the data points, primarily stored as an RDFGraph -}
type alias Data = { graph: RDFGraph
                  }

{- Dimensions is the progressive representation of a Schema, of meta-data 
   it should be recalculable from/stored in the graph but should make it more convenient to access.
   Another apporach might be to make Data an RDFGraph and have functions/methods to access dimensions
   including caching them. All looks very OO... Should be fairly easy to refactor. -}
type Dimension = Numbers Int | Columns (List String)

{- Projections are the different ways/structures in which the data can be thought of/accessed. 

  MetaSet: An unordered bag of items
  MetaList: An ordered list of items
  MetaTree: A hierarchy of items
  MetaGraph: A graph/network of items

  -}
type Projection a = Set a | List a --| MetaTree datum | MetaGraph datum

{- Nodes are the type of datum that will be managed -}
type alias Node = { value: String } | Keyed { Value | key: String } --| Columned Value | Composite Value

{--type alias Value = 
type alias Keyed a = 
type alias Columned a = { a | values: List Valued, keys: List Keyed }
type alias Composite a = a--}

--type MetaSet datum = Set datum
--type MetaList datum = List datum
--type MetaTree datum = Tree datum
--type MetaGraph datum = Tree datum

{- Perspectives is the configuration of each perspective currently opened on the data. -}
type alias Perspective = { representation: Representation
--                         , controls: Controls
                         , focus: List Datum
                         }

{- Representations are the types of visualisations that are available through a Perspective  -}
type Representation = Spatial | Tabular | Sequential

{- controls is the configuration of controls in the representation 
   to add things like facet filters, touch behaviors -}
--type Controls = 