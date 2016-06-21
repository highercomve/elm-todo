module Components.Task.Main exposing (..)
import Html exposing (..)
import Html.Events exposing (..)
import Json.Decode as Json
import Html.Attributes exposing (..)
import Components.Task.Styles as AppStyles
import Components.Form.Styles as FormStyles

type Actions 
  = NoOp
  | Toggle
  | Delete
  | EditMessage String
  | SetEdit
  | RemoveEdit

type alias Model =
  { description : String
  , id : Int
  , completed : Bool
  , edit : Maybe Bool
  }

init: Model
init =
  { description = ""
  , id = 0
  , completed = False  
  , edit = Nothing
  }

update : Actions -> Model -> Maybe Model
update action model =
  case action of
    NoOp ->
      Just model

    Toggle ->
      Just
        { model
        | completed = not model.completed
        , edit = Nothing
        }

    Delete ->
      Nothing

    SetEdit -> 
      Just 
        { model 
        | edit = Just True
        }

    EditMessage description ->
      Just 
        { model
        | description = description
        }

    RemoveEdit ->
      Just 
        { model
        | edit = Nothing
        }

setStyle : Bool -> String
setStyle completed =
  if completed == True then "ready" else "not-ready"

checkButton : Bool -> Html Actions
checkButton completed =
  input
    [ type' "checkbox"
    , checked completed
    , style AppStyles.check
    , onClick Toggle
    ]
    []

taskDescription : String -> Html Actions
taskDescription description =
  div
    [ style AppStyles.description 
    , onDoubleClick SetEdit 
    ]
    [ text description ]

deleteButton : Html Actions
deleteButton =
  button
    [ onClick Delete
    , style AppStyles.delete
    ]
    [ text "x" ]


tagger code =
  if code == 13 then RemoveEdit else NoOp


needByEdit : Maybe Bool -> Bool
needByEdit edit =
  case edit of
    Nothing ->
      False

    Just bool ->
      bool
 
view: Model -> Html Actions
view task =
  let 
    toShow = 
      if (needByEdit task.edit |> not) then 
        div
          [ class "todo-task"
          , style AppStyles.general
          ]
          [ checkButton task.completed
          , taskDescription task.description
          , deleteButton
          ]
      else
        div
          [ style FormStyles.form ]
          [ input
                [ id "new-todo"
                , style FormStyles.input
                , placeholder "What needs to be done?"
                , autofocus True
                , value task.description
                , name "newTodo"
                , required True
                , on "input" (Json.map EditMessage targetValue)
                , on "keyup" (Json.map tagger keyCode)
                ]
                []
            ]
  in
    li
      [ class (setStyle task.completed) ]
      [ toShow ]



