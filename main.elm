import Html exposing (..)
import Html.Attributes as Attr
import Html.App as App
import Components.Form.Main as TodoForm
import Components.List.Main as TodoList
import Components.FilterList.Main as TodoFilter
import Helpers.Main as Helpers
import Helpers.Styles as AppStyles

main =
  App.beginnerProgram
    { model = init
    , update = update
    , view = view
    }

type Actions 
  = NoOp
  | FormActions TodoForm.Actions
  | ListActions TodoList.Actions
  | FilterActions TodoFilter.Actions

type alias Model = 
  { tasks: TodoList.Model
  , newTask: TodoForm.Model
  , visibility: TodoFilter.VisibilityOptions
  }

init : Model
init = 
  { tasks = TodoList.init
  , newTask = TodoForm.init
  , visibility = TodoFilter.init
  }

visibleTasks : Model -> TodoList.Model
visibleTasks model =
  case model.visibility of 
    TodoFilter.All ->
      model.tasks
    
    TodoFilter.Incompleted ->
      List.filter (\task -> not task.completed) model.tasks

    TodoFilter.Completed -> 
      List.filter (\task -> task.completed) model.tasks

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
      { model 
      | tasks = TodoList.update msg model.tasks
      }

    FilterActions msg -> 
      { model 
      | visibility = TodoFilter.update msg model.visibility
      }

view model =
  div 
    [ Attr.class "todo-app" 
    , Attr.style AppStyles.app
    ] 
    [ App.map FormActions (TodoForm.view model.newTask)
    , App.map ListActions (TodoList.view (visibleTasks model))
    , App.map FilterActions (TodoFilter.view model.visibility model.tasks)
    ]


