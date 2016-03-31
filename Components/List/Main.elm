module Components.List.Main where

import Html exposing (ul)
import Components.Item.Main as TodoItem

view address tasks =
  ul []
    (List.map (TodoItem.view address) tasks)


