# DataSphere

We believe that producing and manipulating representations of your thoughts brings clarity of thought, and that clarity of thought helps learning, teaching, communicating, deciding and being happy.

Datasphere is a software ecosystem to help visualise and interact with data in sophisticated and immediate ways.

 - Data Document Editor - for organising and managing data.
 - DataMarkDown - A Markdown for Data, a DSL for describing data and data interaction.
 - Framework - for developers to help develop applications

## Features

 - The evolution of refine.
 - A database you just copy-paste into.
 - Something where you can just add plugins to:
   - Do project management
   - Have graph analytics (learn graph analytics)
   - Make visualisations (mermaid)
   - Add metadata (and recurse)
 - Switch perspective with "almost" alt-tab.
 - Is distraction free first/second.
 - Can be introspected all-the-way

## Technologies

This is currently a moving target. See the [dependencies document](docs/DEPENDENCIES.md) for current thinking about technology components.

## Docs

  * [Roadmap](docs/ROADMAP.md)
  * Design
    * [User Experience](docs/UX.md) - What it looks like to use software built with DataSphere.
    * [Developer Experience](docs/DX.md) - What it looks like to develop software with DataSphere.
    * [Contributor Experience](docs/CX.md) - What it looks like to contribute to developping the DataSphere ecosystem.
    * [Architecture](docs/ARCHITECTURE.md) - Notes about the research and choices regarding software architecture.
    * [Dependencies](docs/DEPENDENCIES.md) - Notes about dependencies with existing technologies.
    * [Layers](docs/LAYERS.md) - Plugins
    * [Data](docs/DATA.md) - Application data modeling.
    * [API](docs/API.md) - API documentation.
    * [DSL](docs/DSL.md) - DataMarkDown specification
  * DataSphere Development
    * [Development Notes](docs/DEV_NOTES.md)


## Development

Open a terminal and type `lein repl` to start a Clojure REPL
(interactive prompt).

In the REPL, type

```clojure
(run)
```

Open Lighttable, Connect to a "Browser (External)" client. Copy paste the script tag and replace the tag in resources/index.html
