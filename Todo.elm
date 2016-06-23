port module Todo exposing (..)

import Html exposing (..)
import Html.Attributes as Attr
import Html.App as App
import Components.Form.Main as TodoForm
import Components.List.Main as TodoList
import Components.FilterList.Main as TodoFilter
import Components.Task.Main as TodoTask exposing (Model) 
import Shared.Styles as AppStyles

main =
  App.programWithFlags
    { init = init
    , update = (\msg model -> withSetStorage (update msg model))
    , view = view
    , subscriptions = \_ -> Sub.none
    }

port setStorage : Model -> Cmd msg

withSetStorage (model, cmds) =
  (model, Cmd.batch [setStorage model, cmds] )

type Actions 
  = NoOp
  | FormActions TodoForm.Actions
  | ListActions TodoList.Actions
  | FilterActions TodoFilter.Actions

type alias Model = 
  { tasks: TodoList.Model
  , newTask: TodoForm.Model
  , visibility: TodoFilter.Model
  }

emptyModel =
  { tasks = TodoList.init
  , newTask = TodoForm.init
  , visibility = TodoFilter.init
  }


init savedModel =
  Maybe.withDefault emptyModel savedModel ! []

newTaskList tasks newTask =
  case newTask of
    Nothing -> 
      tasks
    Just new -> 
      tasks ++ [new]

update : Actions -> Model -> (Model, Cmd a)
update action model = 
  case action of
    NoOp -> 
      model ! []
   
    FormActions msg -> 
      let 
        (newTaskForm, task) = TodoForm.update msg model.newTask   
      in
        { model
        | newTask = newTaskForm
        , tasks = newTaskList model.tasks task 
        } ! [] 
    
    ListActions msg -> 
      { model 
      | tasks = TodoList.update msg model.tasks
      } ! []

    FilterActions msg -> 
      { model 
      | visibility = TodoFilter.update msg model.visibility
      } ! []


view model =
  div 
    [ Attr.class "todo-app" 
    , Attr.style AppStyles.app
    ] 
    [ App.map FormActions (TodoForm.view model.newTask)
    , App.map ListActions (TodoList.view (TodoFilter.visibleTasks model.visibility model.tasks))
    , App.map FilterActions (TodoFilter.view model.visibility model.tasks)
    ]


