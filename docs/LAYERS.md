# Data Layers


Datasphere's modularity is done through layers

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
    * Which data? Let's take the Correctiv example. The identification of key data points inside a database of PDFs. cf [DSL.md](./DSL.md)


## Formatters

Formatters have scope. They can declare their scope, meaning the type of nodes they can represent. i.e. Markdown -> text / Mermaid -> diagrams /...

   * themes can package formatters.

## Connectors

