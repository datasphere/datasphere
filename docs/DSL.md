# Datasphere Domain Specific Language

The Markdown of data documents.

```dd
doc Sparkasse Investigation
text We're investigating the Sparkasse empire and who is...
section
  text We want to do this because...

section example
  text here's an example of what we would like you to help us with.
  image pdf-doc.png
  text This is a PDF like the one we have available in our data base.

section crowdsourced
  text Here's the data we received so far.
  data :type table :sort updated
    file :url http://example.org/example_bootstrapping.json
    crowd :account correctiv@crowdcrafting.org :key !@#@#FK#$
    source :type sparql :name dbpedia :url
    source :type ldp :name transformap
    source :type ldf :name plp

section participate
  text
  crowd participate
```

## Others

Mermaid -
Vega - https://github.com/trifacta/vega
