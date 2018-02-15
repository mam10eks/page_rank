module Components.View exposing (view)

import Html exposing (..)
import Html.Attributes exposing (..)
import Svg as Svg


header = div [ class "header" ] [ h1 [] [ text "An Interactive PageRank Example" ] ]


graphDesigner = div [ class "graph-designer" ] [ Svg.svg [] [] ]


sidebar = div [ class "sidebar" ] [
        div [ class "description" ] [ text "Todo: Beschreibung der aktuellen Aktion die möglich ist..." ]
        , div [ class "addNode button" ] [ text "Add Node" ]
        , div [ class "addLink button" ] [ text "Add Link" ]
        , div [ class "delete button" ] [ text "Clear" ]
    ]


footer = div [ class "footer" ] [
        div [ class "button", style [ ("height", "100%") ] ] [ text "Calculate PageRank" ]
    ]


view model =
    div [ class "container" ][
        header
        , graphDesigner
        , sidebar
        , footer
    ]

