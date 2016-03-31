module Components.Actions where

import String

type Action
  = NoOp
  | SetNewTaskDescription String
  | AddTask

type VisibilityOption
  = All
  | Incompleted
  | Completed

type alias Task =
  { description: String
  , completed: Bool
  , id: Int
  }

type alias TodoModel =
  { tasks: List Task
  , visibility: VisibilityOption
  , newTaskField: String
  , nextId: Int
  }

newTask: Int -> String -> Task
newTask id description =
  { description = description
  , completed = False
  , id = id
  }

emptyModel : TodoModel
emptyModel =
  { tasks = [newTask 0 "Probando ELM"]
  , visibility = All
  , nextId = 1
  , newTaskField = ""
  }

update action model =
  case action of
    NoOp -> model

    SetNewTaskDescription str ->
      { model | newTaskField = str }

    AddTask ->
      { model |
        nextId = if String.isEmpty model.newTaskField then model.nextId + 1 else model.nextId
      , newTaskField = ""
      , tasks = if String.isEmpty model.newTaskField
                  then model.tasks
                  else model.tasks ++ [newTask model.nextId model.newTaskField]
      }


