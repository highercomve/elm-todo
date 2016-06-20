module Components.FilterList.Styles exposing (..)

float =
  [ ("position", "fixed")
  , ("bottom", "0")
  , ("left", "0")
  , ("width", "100%")
  , ("background-color", "white")
  , ("box-shadow", "0 0px 1px 0 rgba(0,0,0,0.3)")
  ]

container = 
  [ ("display", "flex")
  , ("flex-wrap", "no-wrap")
  , ("justify-content", "space-between")
  , ("margin", "0 auto")
  , ("max-width", "500px")
  , ("align-items", "baseline")
  ]

counters =
  [ ("flex", "0 1 33%")
  ]

links =
  [ ("list-style", "none")
  , ("flex", "0 1 67%")
  , ("margin", "0")
  , ("padding", "0")
  , ("display", "flex")
  , ("flex-wrap", "no-wrap")
  , ("justify-content", "space-between")
  ]

linkContainer = 
  [ ("flex", "1 0 auto")
  , ("text-align", "center")
  ]

link active =
  [ ("background-color", if active == True then "#3498db" else "#1abc9c")
  , ("display", "block")
  , ("color", "white")
  , ("padding", "0.8em 1em")
  ] 


