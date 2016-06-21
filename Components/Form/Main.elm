module Components.Form.Main exposing (Model, Actions, init, update, view)
import Components.Task.Main as Task
import Components.Form.Styles as Styles
import Html exposing (..)
import Html.Events exposing (..)
import Html.Attributes exposing (..)
import String
import Json.Decode as Json

-- Model
type alias Model =
  { task : Task.Model
  , hasError: Bool
  , error: String
  , nextId: Int
  , saveTask: Bool
  }

init: Model
init =
  { hasError = False
  , error = ""
  , nextId = 1
  , task = Task.init
  , saveTask = False
  }

-- Actions
type Actions = NoOp
  | SetNewTaskDescription String
  | SetError String
  | AddTask

setTaskId : Task.Model -> Int -> Task.Model
setTaskId task nextId =
  { task
  | id = nextId
  }

changeDescription : Task.Model -> String -> Task.Model
changeDescription task str =
  { task
  | description = str
  }

update action model =
  case action of
    NoOp ->
      model

    SetNewTaskDescription str ->
      { model
      | task = changeDescription model.task str
      }

    SetError str ->
      { model
      | hasError = True
      , error = str
      , saveTask = False
      }

    AddTask ->
      { model
      | task = setTaskId model.task model.nextId
      , hasError = False
      , saveTask = True
      , nextId = model.nextId + 1
      }


view model =
  div [ style Styles.general ]
    [ header
        [ class "todo-header"
        , style Styles.header
        ]
        [ div
            [ class "todo-form"
            , style Styles.form
            ]
            [ input
                [ id "new-todo"
                , style Styles.input
                , placeholder "What needs to be done?"
                , autofocus True
                , value model.task.description
                , name "newTodo"
                , on "input" (Json.map SetNewTaskDescription targetValue)
                , onEnter model
                ]
                []
            , div
                [ class "form-errors"]
                (showError model)
            ]
        ]
    ]

showError model =
  if model.hasError then
    [ p [] [ text model.error ] ]
  else
    []

onEnter model =
  let
    tagger code =
      if code == 13 then submitOrError model
      else NoOp
  in
    on "keyup" (Json.map tagger keyCode)

submitOrError model =
  if model.task.description == "" then
    SetError "You must write something"
  else
    AddTask
