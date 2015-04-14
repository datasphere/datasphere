# Dependencies

Where are the giants whose shoulders we want to stand on?


## Architecture


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

## Tiers

  * UI
  * Cache
  * Processing
  * Store

## UI

### Language

  * UI
    * Elm
    * Polymer - was very fast to learn. https://github.com/smaye81/functional-reactive-js-seed ? Seems not very functional, but maybe it could be made into it...
    * Some functional JS approach mixed with common tools. Like
      + json-editor
      + bootstrap

### Architecture Pattern

FRP or DataFlow?
CSP
CQRS
BOT for extensivity

### Frameworks

  * Hoplon -> Dataflow
    - Does the spreadsheet metaphor constrain the type of programming?
    - Has lenses! Cool.
    - Has a direct acyclic graph structure for data dependencies.
    - Getting started seems very easy.
    - Nice and clean separation of concern
      + utility functions
      + persisted state cell (AKA: stem cell)
      + local state cells
      + formula cells (computed state)
      + state transition functions 
      + page
  * Reagent
  * Re-frame
    - Has a BOT like handler approach which mighg be great for extensibility.
  * Om


## Cache
    *
    *

## Processing

## Store


Atom-shell with node in the backend opens avenues for using native-modules and things like dat.

|--------------------|-------|-------------|----------|-----------|-----------|------|-------|----------|----------------|
|                    | Terse | Error prone | Maturity | Ecosystem | Sub-state | Perf | Adopt | Flexible | Easy to Extend |
|--------------------|-------|-------------|----------|-----------|-----------|------|-------|----------|----------------|
| Cljs/Hoplon        | ++    |             | -        |           |           |      |       |          | +              |
| Cljs/Re-frame      |       |             |          |           |           |      |       |          | +              |
| Cljs/Om/core.async | -     | -           | +        | +++       | ++        | ++   | --    | ++       | -              |
| Elm                | +     | +           | --       | --        | -         | +    | -     | --       |                |
| GHCJS              | +     | ++          |          | --        |           | -    |       | +        |                |
| JS                 | +     | ---         | +        | +++       |           | +    | ++    | +        |                |
|--------------------|-------|-------------|----------|-----------|-----------|------|-------|----------|----------------|

 - Clojure : Om (has good subcomponent solution) + core.async
 - Elm: Has FRP,

|------------|--------------|-------------|--------------|--------------------|-----------------|
|            |      E>      |   Desktop   | Architecture | Extension language | Je ne sais quoi |
|------------|--------------|-------------|--------------|--------------------|-----------------|
| atom       |              | atom-shell  |              | Coffeescript / JS  | Maxogden        |
| LightTable | Architecture | node-webkit | BOT          | CLJS / CSS / JS    | Eve             |
| brackets   |              |             |              |                    |                 |
|------------|--------------|-------------|--------------|--------------------|-----------------|


## Desktop environment

  - atom-shell -> io.js
  - webkit -> nw.js

## Reactive framework

  - React?
  - Circle
  -

