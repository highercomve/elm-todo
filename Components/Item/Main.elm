module Components.Item.Main where

import Html exposing (li, text)

view address task =
  li [] [ text task.description]

