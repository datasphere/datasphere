module RDF.Graph where

import List (..)

{- 
  This is meant to try and mitigate for the lack of ability (I think) to use a constructor expression in the
  type definition as in:

    type alias Graph a = Context a :& Graph a

  I can't see the difference with a ```List Context a``` type. So this should allow the following notation
  to construct graphs:

    newGraph = [('subject'       , [], [('predicate'     , 'object'    )], [])
               ,('object'        , [], [],                               , [])
               ,('predicate'     , [], [('otherPredicate','otherObject')], [])
               ,('otherPredicate', [], [],                               , [])
               ,('otherObject'   , [], [],                               , [])
               ]

    newGraph = [('otherObject'   , [('otherPredicate','predicate')], [], [])
               ,('otherPredicate', []                              , [], [])
               ,('predicate'     , []                              , [], [('subject','object')])
               ,('object'        , []                              , [], [])
               ,('subject'       , []                              , [], [])
               ]
-}
type alias Graph a = List (Context a)

{-
  (node, pred, succ, rels) where:
    node is the node itself
    pred is the list of predecessors
    succ is the list of successors
    rels is the list of pair of nodes related by this node when it is an edge.
-}
type Context a = Empty | Statement (a, List (Predecessors a), List (Successors a), List (Relateds a))
type Predecessors a = NoPred | Pred (a,a)
type Successors a = NoSucc | Succ (a,a)
type Relateds a = NoRels | Rels (a,a)

empty : Graph a
empty = [Empty]

{- decompose a graph -}
match : a -> Graph a -> (Context a, Graph a)
match x gr = (Empty, gr) -- TODO: Find ```a``` in the List 

{- nodes of a graph -}
mkGraph : List (a,a,a) -> Graph a
mkGraph xs =
  case xs of
    [] -> [Empty]
    (s,p,o)::xs -> Statement (s, [NoPred], [Succ (p,o)],[NoRels]) 
                  :: Statement (p, [NoPred], [NoSucc], [NoRels]) 
                  :: Statement (o, [NoPred], [NoSucc], [NoRels]) 
                  :: mkGraph xs

{- nodes of a graph -}
nodes : Graph a -> List a
nodes gr =
  case gr of
    Statement (n,_,_,_)::xs -> n :: nodes xs

{- extend a graph -}
extend : Context a -> Graph a -> Graph a
extend c g = c :: g

{-- fold graph --}
foldGraph : b -> ( Context a -> b -> b) -> Graph a -> b
foldGraph e f g = case nodes g of
  [] -> e
  n::_ -> let (ctx,g1) = match n g
         in f ctx (foldGraph e f g1)  