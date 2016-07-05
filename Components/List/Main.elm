module Components.List.Main exposing (Model, Actions, init, view, update)
import Components.Task.Main as Task
import Components.List.Styles as Styles
import Html exposing (ul)
import Html.Attributes as Attr
import Html.App as App
import Shared.Styles as Styles

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
      let 
        updateMap = updateHelper id action
      in
        model
          |> List.filterMap updateMap


mapTodos task =
  Task.view task
    |> App.map (ModifyTask task.id)


view model =
  List.map mapTodos model
    |> ul
        [ Attr.class "todo-list"
        , Attr.style Styles.general
        ]
