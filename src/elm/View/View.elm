module View.View exposing (view)

import Components.Model exposing (..)
import Components.Routing exposing (pageToHref)
import View.GraphDesigner exposing (graphDesigner)
import View.OnClick exposing (onPreventDefaultClick)
import View.Assets exposing (pageRankAssetImage)
import Html.Events exposing (onClick)
import Html exposing (..)
import Html.Attributes exposing (..)


header : Model -> Html Msg
header model =
    div [ class "header" ] [ h1 [] [ text ("An Interactive PageRank Example") ] ]


menu : Html Msg
menu =
    div [ class "menu" ]
        [ text "Menu"
        , div [ class "menu-content" ]
            [ menuElement "Tutorial" Tutorial
            , menuElement "Next Achievement" NextAchievements
            , menuElement "Settings" Settings
            , menuElement "About" About
            ]
        ]


menuElement : String -> Page -> Html Msg
menuElement menuName page =
    a [ class "menu-content-element", onPreventDefaultClick (NavigateToPage page), href ("" ++ (pageToHref page)), id ("menu-link-" ++ menuName) ]
        [ pageRankAssetImage, text menuName ]


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


modalWindow : Model -> List (Html Msg)
modalWindow model =
    case model.currentPage of
        MainPage ->
            []

        other ->
            [ div [ class "modal" ] [ div [ class "modal-content" ] [ h1 [] [ text ("TBA: " ++ (pageToHref model.currentPage)) ] ] ] ]


view : Model -> Html Msg
view model =
    let
        modal =
            modalWindow model

        hideModalEvents =
            if List.isEmpty modal then
                []
            else
                [ onClick (NavigateToPage MainPage) ]
    in
        div ([ class "container" ] ++ hideModalEvents)
            ([ menu
             , header model
             , graphDesigner model
             , sidebar model
             , footer
             ]
                ++ (modal)
            )
