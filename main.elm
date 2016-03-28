import Html exposing (..)
import Html.Events as Events
import Html.Attributes as Attr
import StartApp.Simple as StartApp
import Components.Form.Main as TodoForm
import Components.List.Main as TodoList
import Components.Item.Main as TodoItem
import Components.Actions as Store

main =
  StartApp.start
    { model = Store.emptyModel
    , update = Store.update
    , view = view
    }

view address model =
  div [] [
    TodoForm.view address model.newTaskField
  , TodoList.view address model.tasks
  ]


