module Components.FilterList.Main exposing (..)
import Components.FilterList.Styles as Styles
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import String

type Actions 
  = NoOp
  | ChangeFilter VisibilityOptions

type VisibilityOptions = All
  | Incompleted
  | Completed

type alias Model = VisibilityOptions

update action model = 
  case action of
    NoOp ->
      model

    ChangeFilter filter ->
      filter

init =
  All

filterToString filter =
  case filter of 
    All ->
      "All"

    Incompleted ->
      "Pending"

    Completed ->
      "Done"

filterLink filter actualFilter =
  a 
    [ onClick (ChangeFilter filter)
    , style (Styles.link (filter == actualFilter))
    ]
    [ text (filterToString filter) ]

taskCounter filter tasks = 
  case filter of
    All -> 
      List.length tasks

    Completed -> 
      List.filter (\task -> task.completed) tasks 
      |> List.length

    Incompleted -> 
      List.filter (\task -> not task.completed) tasks
      |> List.length

counterMessages tasks =
  let 
    pending = taskCounter Incompleted tasks
    task_ = if pending > 1 then "tasks " else "task"
  in
    div 
      [ style Styles.counters ]
      [ span []
          [ text (toString (taskCounter Incompleted tasks))
          , text (" pending " ++ task_)
          ]
      , span []
          [ text ", of "
          , text (toString (taskCounter All tasks))
          ]
      ]

view model tasks =
  div 
    [ style Styles.float ]
    [ div [style Styles.container]
        [ counterMessages tasks 
          , ul 
              [ class "filter-links" 
              , style Styles.links
              ]
              [ li 
                  [ class "filter-link" 
                  , style Styles.linkContainer
                  ] 
                  [ filterLink All model ]
              , li 
                  [ class "filter-link" 
                  , style Styles.linkContainer
                  ] 
                  [ filterLink Incompleted  model ]
              , li 
                  [ class "filter-link" 
                  , style Styles.linkContainer
                  ] 
                  [ filterLink Completed model ]
              ]
        ]
    ]
        
