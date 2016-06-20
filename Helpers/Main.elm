module Helpers.Main exposing (..)

resetTask task = 
  { task |
    description = ""
  }
  
newTasks model newTaskForm = 
  if newTaskForm.saveTask == True then 
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

