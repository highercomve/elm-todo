import Html exposing (..)
import Html.Events as Events
import Html.Attributes as Attr
import Html.App as App
import Components.Form.Main as TodoForm
import Components.List.Main as TodoList
import Helpers.Main as Helpers
import Helpers.Styles as AppStyles

main =
  App.beginnerProgram
    { model = init
    , update = update
    , view = view
    }

type VisibilityOption = All
  | Incompleted
  | Completed

type Actions = NoOp
  | FormActions TodoForm.Actions
  | ListActions TodoList.Actions

type alias Model = 
  { tasks: TodoList.Model
  , newTask: TodoForm.Model
  , visibility: VisibilityOption
  }

init : Model
init = 
  { tasks = TodoList.init
  , newTask = TodoForm.init
  , visibility = All
  }

update action model = 
  case action of
    NoOp -> 
      model
   
    FormActions msg -> 
      let 
        newTaskForm = TodoForm.update msg model.newTask   
        newModel = Helpers.newTasks model newTaskForm
      in
        newModel
    
    ListActions msg -> 
      { 
        model |
        tasks = TodoList.update msg model.tasks
      }

css path =
  node "link" [ Attr.rel "stylesheet", Attr.href path ] []

view model =
  div 
    [ Attr.class "todo-app" 
    , Attr.style AppStyles.app
    ] 
    [ App.map FormActions (TodoForm.view model.newTask)
    , App.map ListActions (TodoList.view model.tasks)
    ]


