module Components.Form.Main where

import Html exposing (..)
import Html.Events exposing (..)
import Html.Attributes exposing (..)
import String
import Signal exposing (Signal, Address)
import Json.Decode as Json
import Components.Actions exposing (..)

view address task =
  header []
    [ text "My todo List With Elm"
    , div []
      [ input
        [ id "new-todo"
        , placeholder "What needs to be done?"
        , autofocus True
        , value task
        , name "newTodo"
        , on "input" targetValue (Signal.message address << SetNewTaskDescription)
        , onEnter address AddTask
        ]
        []
      ]
    ]

getTargetValue keyCode =
  Json.customDecoder keyCode is13

onEnter : Address a -> a -> Attribute
onEnter address value =
  on "keydown"
  (Json.customDecoder keyCode is13)
  (\_ -> Signal.message address value)


is13 : Int -> Result String ()
is13 code =
    if code == 13 then Ok () else Err "not the right key code"
