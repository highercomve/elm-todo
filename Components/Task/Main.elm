module Components.Task.Main exposing (..)
import Html exposing (li, text, div, input, button)
import Html.Events exposing (..)
import Json.Decode as Json
import Html.Attributes exposing (class, type', style, checked)
import Components.Task.Styles as AppStyles

import String

type Actions = NoOp
  | Toggle
  | Delete

type alias Model =
  { description : String
  , id : Int
  , completed : Bool
  }

init =
  { description = ""
  , id = 0
  , completed = False
  }

update action model =
  case action of
    NoOp ->
      Just model

    Toggle ->
      Just
        { model
        | completed = not model.completed
        }

    Delete ->
      Nothing

toggleOnClick =
  Toggle

deleteOnClick =
  Delete

setStyle completed =
  if completed == True then "ready" else "not-ready"

checkButton completed =
  input
    [ type' "checkbox"
    , checked completed
    , style AppStyles.check
    , onClick toggleOnClick
    ]
    []

taskDescription description =
  div
    [ style AppStyles.description ]
    [ text description ]

deleteButton =
  button
    [ onClick deleteOnClick
    , style AppStyles.delete
    ]
    [ text "x" ]

view task =
  li
    [ class (setStyle task.completed) ]
    [ div
        [ class "todo-task"
        , style AppStyles.general
        ]
        [ checkButton task.completed
        , taskDescription task.description
        , deleteButton
        ]
    ]
