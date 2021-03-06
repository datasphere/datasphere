# User Experience

Concrete "scratch my own itch" use cases:
 * Tool space database. (comparison/mapping/intention driven browsing)
 *

## Personas

 * PKMer -> aiming to organise and manage personal knowledge
 * Data Journalist
 * Data Management tool



## Prototype User Story

Objective: Deal with the shift between unstructured text <-> list structure <-> row structure


## Input unstructured list

 * Action

Type ```hello``` (enter) ```hello``` (enter) ```hello```

 * Result

```

hello
hello
hello

```

## Switch to structured list

 * Action

Select all (ctrl-a) and use (tab).

 * Results

The screen should display

 ```

  * hello
  * hello
  * hello

 ```


## Switch to rows

 * Action

With all selected use (tab) again

 * Results

The screen should display

 ```

|---|---------|---|
| * | "hello" |   |
| * | "hello" |   |
| * | "hello" |   |
|---|---------|---|


 ```


## Add column values

  * Action

Adding a couple of values in the new column (->) A

 ```

|---|---------|---|
| * | "hello" |   |
| * | "hello" |   |
| * | "hello" | A |
|---|---------|---|


 ```

 * Data

   * edn:

{:1 "hello", :2 "hello", :3 "hello"}

   * ttl:


        _:this   dt:column    "hello" .
        dt:datum dt:column "A" .
        person:person1 person:lastname "Taylor" .
        venue:venue2 venue:venuename "Columbus Crew Stadium" .
        venue:venue2 venue:venuecity "Columbus" .
        venue:venue2 venue:venuecitypop 787033 .
        category:category1 category:catgroup "Sports" .
        category:category1 category:catname "MLB" .
        category:category1 category:catdesc "Major League Baseball" .
        date:date1827 date:caldate "2008-01-01T00:00:00"^^xsd:dateTime .
        date:date1827 date:day "WE" .
        date:date1827 date:week 1 .
        event:event1 event:venueid venue:venue305 .
        event:event1 event:catid category:category8 .
        event:event1 event:dateid date:date1851 .
        event:event1 event:eventname "Gotterdammerung" .
        listing:listing56237 listing:sellerid users:users8591 .
        listing:listing56237 listing:eventid event:event1412 .
        listing:listing56237 listing:dateid date:date1930 .
        listing:listing56237 listing:numtickets 14 .
        sales:sales172452 sales:qtysold 1 .
        sales:sales172452 sales:pricepaid "1509"^^xsd:double .
        sales:sales172452 sales:commission "226.35"^^xsd:double .

   * nq underlying:

        _:this   ds:datum _:value1 _:g .
        _:value1 ds:idx   0        _:g .
        _:value1 ds:value "hello"  _:g .

        _:this   ds:datum _:value2 _:g .
        _:value2 ds:idx   1        _:g .
        _:value2 ds:value "hello"  _:g .

        _:this   ds:datum _:value3 _:g .
        _:value3 ds:idx   2        _:g .
        _:value3 ds:value "hello"  _:g .


# Principles

Data perspective shifts should try to pivot around content, i.e. content should stay as close as it was between shifs.

## In the text edition representation

Using arrows moves the cursor as if it was text.

# Questions

Should this also hold with the more evolved graphical UI? Probably



