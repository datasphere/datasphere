# OpenDataFrame

A framework for developers to help develop applications that allow to visualise and interact with data in sophisticated ways more rapidly and in a more robust manner.

Used [hi-elm](https://github.com/joefiorini/hi-elm) for scaffolding (needs XCode Command Line tools).

## Install

  * [Install elm](http://elm-lang.org/Install.elm)
  * [Install Node.js](http://nodejs.org/)
  * Install bower with ```npm install -g bower```
  * Run
      * ```bower install```
      * ```make watch```
  * Access the demo at http://localhost:8000

# Implementation Notes

  * Should probably use elm-d3 or re-use something similar to do visualisations
  * There needs to be a concept of Operational Transforms to faciliate simultaneous editing (and as a way to provide History)
  * On the node editing front, ideally we would use a similar approach to JSON-Schema + Alpaca/[Json-Editor](https://github.com/jdorn/json-editor). This might mean finding a way to describe schema - or rather EditingRepresentation -  of the RDF in RDF itself.
 
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


