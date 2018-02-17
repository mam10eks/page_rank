module View.View exposing (view)

import Components.Model exposing (..)
import Components.Update exposing (..)
import View.GraphDesigner exposing (graphDesigner)
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (onClick)


header : Html Msg
header =
    div [ class "header" ] [ h1 [] [ text "An Interactive PageRank Example" ] ]


sidebar : Model -> Html Msg
sidebar model =
    div [ class "sidebar" ]
        [ div [ class "description" ] [ text "Beschreibung der Möglichkeiten" ]
        , div [ class "addNode button" ] [ text "Add Node" ]
        , div [ class "addLink button" ] [ text "Add Link" ]
        , div [ class "delete button", onClick Clear ] [ text "Clear" ]
        ]


footer : Html Msg
footer =
    div [ class "footer" ]
        [ div [ class "button", style [ ( "height", "100%" ) ] ] [ text "Calculate PageRank" ]
        ]


view : Model -> Html Msg
view model =
    div [ class "container" ]
        [ header
        , graphDesigner model
        , sidebar model
        , footer
        ]
