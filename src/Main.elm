module Main where
{-| TodoMVC implemented in Elm, using plain HTML and CSS for rendering.

This application is broken up into four distinct parts:

  1. Model  - a full definition of the application's state
  2. Update - a way to step the application state forward
  3. View   - a way to visualize our application state with HTML
  4. Inputs - the signals necessary to manage events

This clean division of concerns is a core part of Elm. You can read more about
this in the Pong tutorial: http://elm-lang.org/blog/Pong.elm

This program is not particularly large, so definitely see the following
document for notes on structuring more complex GUIs with Elm:
http://elm-lang.org/learn/Architecture.elm
-}

import Html (..)
import Html.Attributes (..)
import Html.Events (..)
import Html.Lazy (lazy, lazy2)
import Json.Decode as Json
import List
import Maybe
import Signal
import String
import Window

import RDF (..)
import RDF.Graph (..)
import Metasphere (..)

---- MODEL ----

-- The full application state of our todo app.
type alias Model = 
    { docs       : List (Doc Item)
    , field      : String
    , uid        : Int
    , visibility : String
    }

emptyModel : Model
emptyModel =
    { docs = [emptyDoc newItem]
    , visibility = "All"
    , field = ""
    , uid = 0
    }

emptyDoc : Item -> Doc 
emptyDoc item =
  { data = Ground ([Empty])
  , dimensions = []
  , projections = [[item]]
  , perspectives = []
  }

type alias Item =
    { description : String
    , completed   : Bool
    , editing     : Bool
    , id          : Int
    }

newItem : String -> Int -> Item
newItem desc id =
    { description = desc
    , completed = False 
    , editing = False
    , id = id
    }


---- UPDATE ----

-- A description of the kinds of actions that can be performed on the model of
-- our application. See the following post for more info on this pattern and
-- some alternatives: http://elm-lang.org/learn/Architecture.elm
type Action
    = NoOp
    | UpdateField String
    | EditingItem Int Bool
    | UpdateItem Int String
    | Add
    | Delete Int
    | DeleteComplete
    | Check Int Bool
    | CheckAll Bool
    | ChangeVisibility String

-- How we update our Model on a given Action?
update : Action -> Model -> Model
update action model =
    case action of
      NoOp -> model

      Add ->
          { model |
              uid <- model.uid + 1,
              field <- "",
              items <-
                  if String.isEmpty model.field
                    then model.items
                    else Statement (newItem model.field model.uid,[],[],[]) :: model.items 
          }
{--
      UpdateField str ->
          { model | field <- str }

      EditingItem id isEditing ->
          let updateItem t = if t.id == id then { t | editing <- isEditing } else t
          in
              { model | items <- List.map updateItem model.items }

      UpdateItem id task ->
          let updateItem t = if t.id == id then { t | description <- task } else t
          in
              { model | items <- List.map updateItem model.items }

      Delete id ->
          { model | items <- List.filter (\t -> t.id /= id) model.items }

      DeleteComplete ->
          { model | items <- List.filter (not << .completed) model.items }

      Check id isCompleted ->
          let updateItem t = if t.id == id then { t | completed <- isCompleted } else t
          in
              { model | items <- List.map updateItem model.items }

      CheckAll isCompleted ->
          let updateItem t = { t | completed <- isCompleted }
          in
              { model | items <- List.map updateItem model.items }

--}
      ChangeVisibility visibility ->
          { model | visibility <- visibility }


---- VIEW ----

view : Model -> Html
view model =
    div
      [ class "todomvc-wrapper"
      , style [ ("visibility", "hidden") ]
      ]
      [ section
          [ id "todoapp" ]
          [ lazy itemEntry model.field
          , lazy2 itemList model.visibility model.items
--          , lazy2 controls model.visibility model.items
          ]
      , infoFooter
      ]

onEnter : Signal.Message -> Attribute
onEnter message =
    on "keydown"
      (Json.customDecoder keyCode is13)
      (always message)

is13 : Int -> Result String ()
is13 code =
  if code == 13 then Ok () else Err "not the right key code"

itemEntry : String -> Html
itemEntry task =
    header 
      [ id "header" ]
      [ h1 [] [ text "metasphere" ]
      , input
          [ id "new-todo"
          , placeholder "What needs to be done?"
          , autofocus True
          , value task
          , name "newTodo"
          , on "input" targetValue (Signal.send updates << UpdateField)
          , onEnter (Signal.send updates Add)
          ]
          []
      ]

itemList : String -> Graph Item -> Html
itemList visibility items =
    let isVisible todo =
            case visibility of
              "Completed" -> todo.completed
              "Active" -> not todo.completed
              "All" -> True

--        allCompleted = List.all .completed items

        cssVisibility = if List.isEmpty items then "hidden" else "visible"
    in
    section
      [ id "main"
      , style [ ("visibility", cssVisibility) ]
      ]
      [ input
          [ id "toggle-all"
          , type' "checkbox"
          , name "toggle"
--          , checked allCompleted
--          , onClick (Signal.send updates (CheckAll (not allCompleted)))
          ]
          []
      , label
          [ for "toggle-all" ]
          [ text "Mark all as complete" ]
      , ul
          [ id "todo-list" ]
          [ text "list" ]
--          (List.map todoItem (List.filter isVisible items))
      ]

todoItem : Item -> Html
todoItem todo =
    let className = (if todo.completed then "completed " else "") ++
                    (if todo.editing   then "editing"    else "")
    in

    li
      [ class className ]
      [ div
          [ class "view" ]
          [ input
              [ class "toggle"
              , type' "checkbox"
              , checked todo.completed
              , onClick (Signal.send updates (Check todo.id (not todo.completed)))
              ]
              []
          , label
              [ onDoubleClick (Signal.send updates (EditingItem todo.id True)) ]
              [ text todo.description ]
          , button
              [ class "destroy"
              , onClick (Signal.send updates (Delete todo.id))
              ]
              []
          ]
      , input
          [ class "edit"
          , value todo.description
          , name "title"
          , id ("todo-" ++ toString todo.id)
          , on "input" targetValue (Signal.send updates << UpdateItem todo.id)
          , onBlur (Signal.send updates (EditingItem todo.id False))
          , onEnter (Signal.send updates (EditingItem todo.id False))
          ]
          []
      ]

{--
controls : String -> Graph Item -> Html
controls visibility items =
    let itemsCompleted = List.length (List.filter .completed items)
        itemsLeft = List.length items - itemsCompleted
        item_ = if itemsLeft == 1 then " item" else " items"
    in
    footer
      [ id "footer"
      , hidden (List.isEmpty items)
      ]
      [ span
          [ id "todo-count" ]
          [ strong [] [ text (toString itemsLeft) ]
          , text (item_ ++ " left")
          ]
      , ul
          [ id "filters" ]
          [ visibilitySwap "#/" "All" visibility
          , text " "
          , visibilitySwap "#/active" "Active" visibility
          , text " "
          , visibilitySwap "#/completed" "Completed" visibility
          ]
      , button
          [ class "clear-completed"
          , id "clear-completed"
          , hidden (itemsCompleted == 0)
          , onClick (Signal.send updates DeleteComplete)
          ]
          [ text ("Clear completed (" ++ toString itemsCompleted ++ ")") ]
      ]

--}

visibilitySwap : String -> String -> String -> Html
visibilitySwap uri visibility actualVisibility =
    let className = if visibility == actualVisibility then "selected" else "" in
    li
      [ onClick (Signal.send updates (ChangeVisibility visibility)) ]
      [ a [ class className, href uri ] [ text visibility ] ]

infoFooter : Html
infoFooter =
    footer [ id "info" ]
      [ p [] [ text "Framework for multi-dimensional representations of data" ]
      , p [] [ text "Written by "
             , a [ href "https://github.com/jmatsushita" ] [ text "Jun Matsushita" ]
             ]
      , p [] [ text "Part of "
             , a [ href "https://iilab.org" ] [ text "iilab" ]
             ]
      ]


---- INPUTS ----

-- wire the entire application together
main : Signal Html
main = Signal.map view model

-- manage the model of our application over time
model : Signal Model
model = Signal.foldp update initialModel (Signal.subscribe updates)

initialModel : Model
initialModel = emptyModel
--  Maybe.withDefault emptyModel getStorage

-- updates from user input
updates : Signal.Channel Action
updates = Signal.channel NoOp

port focus : Signal String
port focus =
    let needsFocus act =
            case act of
              EditingItem id bool -> bool
              _ -> False

        toSelector (EditingItem id _) = ("#todo-" ++ toString id)
    in
        Signal.subscribe updates
          |> Signal.keepIf needsFocus (EditingItem 0 True)
          |> Signal.map toSelector


{-- interactions with localStorage to save the model
port getStorage : Maybe Model

port setStorage : Signal Model
port setStorage = model
--}