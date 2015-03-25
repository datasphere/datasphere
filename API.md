# API Design


Projections is the key value proposition.

## Use cases

1. Start free text list.

Does this mean create a "freetext" data document?

2. 

Type of applications and consequence in data structures:
 * Notepad
 * Todo list.
 * Contact directory
 * Calendar / Reminders
 * Spreadsheet
 * Tables (with facets, graphical facets)
 * Timelines
 * **Graph** This is were some other representions flow from making graphs more usable:

## Terminology

This is primarly for developers but I think the terminology should lead to improved clarity on the user side as well. i.e. smart usable defaults.

### Data points.

Drupal nodes and node types?
RDF nodes (blank nodes). Subject Object Predicate
Nodes and edges. 
points and vertices.

Important design question: should there be (an) intermediate concept(s) between a data point (i.e. an RDF triple essentially) and the open graph of the related data points (i.e. the set of results from interesting queries)? Such possible intermediary representations are:
 - Documents (Can we avoid Neo4j vs Triple?)
 - Tables (as in RDBMS tables? or Excel Tables?)

I guess definitely yes. Moving/Transitioning/Transforming between these intermediary structures is exactly what MetaSphere should excel at. That means that ETL or Data Conversion body of knowledge should be foundational.

### Data structures

  * Projection is an Editable View of a data set.
  * Is there such a thing as a Data Structure? All data structures are in fact graph, but they can start with simple projections. As such they behave like simpler structures and neither the users nor the developers need to worry about the underlying graph structure except when they decide to use more sophisticated projections which reveal more of the graph nature of their data.
  * This means that for all instance and purposes, Projections behave like simpler data structures.

Projections should be Interfaces (in OO parlance) or Type Classes in FP. What are the Type Classes that surface from FP / DB modules?
    * In Persistent, they use Template Haskell to expand a DSL which describes the database schema. It generates data types (GADTs) with semantics on how to query data in the IO monad.

The thing is that we're talking about MetaProgramming at a level that is higher than this toolkit. We might be generating Haskell programs dynamically here. Are we going to bump into this and struggle or do we need to move to LISP? So Template Haskell does seem to be the way to go. But there are several caveats/potential obstacles:
 - I'm not sure that I can do TH on top of Persistent which also uses TH. Unless the splicing thing works in a way that allows me to do this.
 - TH doesn't work on Haste (but that could be fixable https://github.com/valderman/haste-compiler/issues/66)
 - TH does work on GHCJS. 

 


### Projections

Freetext -> Sentences -> Lexical analysis -> NLP smart stuff -> ...
Freetext -> Sentences -> List -> Table -> ...
List -> Table -> Network
List -> Table -> Plot

Maybe there's some data projection tweening? Maybe when some higher level structural detail haven't been filled yet?

There is a state machine between data projections? 

# Others

Wolfram Language
Grano
Nice d3 stuff
Personal Brain
MIT Simile

# APIs

## Frontend <-> Processing

**Open** / Create a **new** **data store**
Give me **this projection** on **this data set**
Give me the **list of projections** available for **this data set**
**Focus** on **this part (query DSL?)** of **this data set** 
**Store** this **updated data projection**.



Data.Init
Data.Add


## Projections

The idea behind a projection is some type of immmutable casting. It shouldn't modify the existing data structure. It should create a new representation of the data structure that remains completely bi-directionally synced with the original data. 

There can be multiple representations of the same projection. Some representation can be read-only other can be read/write.

Project.toTable()

Underlying probably not expeosed.

Store.Create
Store.CreateDimension