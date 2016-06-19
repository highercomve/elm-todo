module Components.Task.Main exposing (..)
import Html exposing (li, text)
import String

type alias Model = 
  { description : String
  , id : Int
  , completed : Bool
  }

init =
  { description = ""
  , id = 0
  , completed = False
  }

view task =
  li [] [ text task.description]

