module Components.FilterList.Main exposing (..)
import Components.FilterList.Styles as Styles
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import String
import Dict

type Actions 
  = NoOp
  | ChangeFilter String

visibilityOptions =
  { incompleted =  "Incompleted"
  , all = "All"
  , completed = "Completed"
  }

type alias Model = String

update action model = 
  case action of
    NoOp ->
      model

    ChangeFilter filter ->
      filter

init =
  visibilityOptions.all
   
filterLink filter actualFilter =
  a 
    [ onClick (ChangeFilter filter)
    , style (Styles.link (filter == actualFilter))
    ]
    [ text filter ]

visibleTasks filter tasks = 
    case filter of
      "Completed" -> 
        List.filter (\task -> task.completed) tasks 

      "Incompleted" -> 
        List.filter (\task -> not task.completed) tasks

      _ -> 
        tasks

taskCounter filter tasks = 
  visibleTasks filter tasks |> List.length

counterMessages tasks =
  let 
    pending = taskCounter visibilityOptions.incompleted tasks
    all = taskCounter visibilityOptions.all tasks
    task_ = if pending > 1 then "tasks " else "task"
  in
    div 
      [ style Styles.counters ]
      [ span []
          [ text (toString pending)
          , text (" pending " ++ task_)
          ]
      , span []
          [ text ", of "
          , text (toString all)
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
                  [ filterLink visibilityOptions.all model ]
              , li 
                  [ class "filter-link" 
                  , style Styles.linkContainer
                  ] 
                  [ filterLink visibilityOptions.incompleted  model ]
              , li 
                  [ class "filter-link" 
                  , style Styles.linkContainer
                  ] 
                  [ filterLink visibilityOptions.completed model ]
              ]
        ]
    ]
        
