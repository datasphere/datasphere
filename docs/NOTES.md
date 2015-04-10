# Notes

Assumptions
 - Functional: Because.
 - DRY. Because
 - Javascript: To use a single language in the browser and server.
 - Not JS transpilers: Because of libraries, and we know JS better.
 - Coffeescript: because it is more terse, and is better for functional programming given the better lambda syntax.

Big options
 * Meteor + pointfree-fantasyland?
 * Cycle + Hoodie ?
 * + Coffeescript.

Architecture

 * Sinks: Interface

Backend
 * hoodie plugins could use pointfree-fantasyland
 * 

Frontend
 * Cycle framework seems https://github.com/staltz/cycle more elegant than mercury, but obviously less active and supported than react. 
 * 

Questions
 * how to plugin dat ?
 * how to plugin d3 or cytoscape or sigma?

# Thoughts

## Components and MVI

If components are packaged more or less like in Polymer, then from a framework standpoint the view is essentially a file that includes components, which receive a state/model and emit events.

## Binding 

Binding should be maybe convention over configuration. i.e. same file name for view and model means that the view automatically receives the model state on init, automatically updates when model changes for auto-bound variables.

Then in the view folder you could have a js file which exposes the events?

/ app 
  / models
    / entry.js
  / views
    / components
      / entry
        / entry.html
        / entry.js // exposes events?
    / controller
    / index.html  // home

Then event names would be available in the controller?



## Language/Script

Language questions
 - Reading direction.
   - Traditional Functional from right to left but that's hard to read.
   - Dot notation requires an object. 
   - Couldn't you do ```myfun = _.blah().followedbyBlah().andthenBlah() ``` then you could do ```myfun(obj)``` or ```obj.myfun``` which would be like ```obj.blah().followedbyBlah().andthenBlah()``` and like ```andthenBlah(followedbyBlah(blah(obj)))``` ? But could you curry or partially apply then? Would you then "right curry?" to keep the reading direction? 

Templates
 - Needs to be manageable in files. a la JSX
 - Needs to have variable bindings. a la mustache
 - 

Traditionally
```
tripleAddMult = function(a,b,c) {
    return (a + b) * c;
}

tripleAdd2Mult = tripledAddMult(2)
// tripleAdd2Mult(3,4) = 20

tripleAdd2and3Mult = tripleAddMult(2,3);
// tripleAdd2and3Mult(4) = 20

```

Reversed
```
tripleAddMult = function(a,b,c) {
    return (a + b) * c;
}

tripleAdd_Mult4 = _.tripledAddMult(4)
// tripleAdd2Mult(2,3) = 20

tripleAdd_and3Mult4 = _.tripleAddMult(3,4)
// tripleAdd_and3Mult4(2) = 20
```
