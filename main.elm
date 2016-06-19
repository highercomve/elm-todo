import Html exposing (..)
import Html.Events as Events
import Html.Attributes as Attr
import Html.App as App
import Components.Form.Main as TodoForm
import Components.List.Main as TodoList

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

init: Model
init = 
  { tasks = TodoList.init
  , newTask = TodoForm.init
  , visibility = All
  }

newTasks model newTaskForm = 
  if newTaskForm.saveTask == True then 
    let 
      resetTask = (\task -> {
          task |
          description = ""
      })
    in
      { model |
        tasks = model.tasks ++ [newTaskForm.task]
      , newTask = 
        { newTaskForm | 
          saveTask = False
        , task = resetTask(newTaskForm.task)         
        }
      }
  else
    { model |
      newTask = newTaskForm 
    }

update action model = 
  case action of
    NoOp -> 
      model
   
    FormActions msg -> 
      let 
        newTaskForm = TodoForm.update msg model.newTask   
        newModel = newTasks model newTaskForm
      in
        newModel
    
    ListActions msg -> 
      { 
        model |
        tasks = TodoList.update msg model.tasks
      }

view model =
  div [] 
    [ App.map FormActions (TodoForm.view model.newTask)
    , App.map ListActions (TodoList.view model.tasks)
    ]


