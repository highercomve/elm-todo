module Components.List.Main exposing (Model, Actions, init, view, update)
import Components.Task.Main as Task
import Html exposing (ul)
import Html.App as App
import String

type Actions = NoOp

type alias Model = List Task.Model

init : Model
init = []

update action model = 
  case action of
    NoOp -> 
      model

view model =
  ul [] (List.map Task.view model)


