module Components.List.Main exposing (Model, Actions, init, view, update)
import Components.Task.Main as Task
import Components.List.Styles as Styles
import Html exposing (ul)
import Html.Attributes as Attr
import Html.App as App
import Helpers.Styles as Styles
import String

type Actions = NoOp
  | ModifyTask Int Task.Actions

type alias Model = List Task.Model

init : Model
init = []

updateHelper targetId msg task =
  if task.id == targetId then
    Task.update msg task
  else
    Just task

update action model =
  case action of
    NoOp ->
      model

    ModifyTask id action ->
      model
        |> List.filterMap (updateHelper id action)

mapTodos task =
  App.map (ModifyTask task.id) (Task.view task)

view model =
  ul
    [ Attr.class "todo-list"
    , Attr.style Styles.general
    ]
    (List.map mapTodos model)
