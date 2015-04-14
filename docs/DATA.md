# Data Model

## Text

 * Data

   * edn:

"hello\nhello\nhello"

   * ttl:

        _:this dt:datum  "hello\nhello\nhello"^^xsd:string .


   * nq underlying:

        _:this   ds:datum _:value                             _:g .
        _:value  ds:value "hello\nhello\nhello"^^xsd:string"  _:g .


## List

 * Data

   * edn:

("hello" "hello" "hello")

or should it be ["hello" "hello" "hello"] ?

   * ttl compact:

        _:this   ds:datum  "hello" .
                 ds:datum  "hello" .
                 ds:datum  "hello" .

   * nq underlying:

        _:this   ds:datum  _:value1  _:g .
        _:value1 ds:idx    0         _:g .
        _:value1 ds:value  "hello"   _:g .

        _:this   ds:datum  _:value2  _:g .
        _:value2 ds:idx    1         _:g .
        _:value2 ds:value  "hello"   _:g .

        _:this   ds:datum  _:value3  _:g .
        _:value3 ds:idx    2         _:g .
        _:value3 ds:value  "hello"   _:g .

Notes about the schema

        _:this     is the current document or data section in the document.
        _:g        is the context for the document.
        ds:idx     is an implicit index. If the ul becomes an ol then the index will be explicit (ds:key)

## Rows


|---|---------|---|
| * | "hello" |   |
| * | "hello" |   |
| * | "hello" |   |
|---|---------|---|



{:1 ["hello"], :2 ["hello"], :3 ["hello"]}

  * Adding a couple of values in the new column.


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



