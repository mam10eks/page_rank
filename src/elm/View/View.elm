module View.View exposing (view)

import Components.Model exposing (..)
import Components.Routing exposing (pageToHref)
import View.GraphDesigner exposing (graphDesigner)
import View.OnClick exposing (onPreventDefaultClick)
import View.Assets exposing (pageRankAssetImage)
import Html.Events exposing (onClick)
import Html exposing (..)
import I18N exposing (..)
import Html.Attributes exposing (..)


header : Model -> Html Msg
header model =
    div [ class "header" ] [ h1 [] [ i18n model.language Header ] ]


menu : Model -> Html Msg
menu model =
    div [ class "menu" ]
        [ i18n model.language Menu
        , div [ class "menu-content" ]
            [ menuElement model Tutorial
            , menuElement model NextAchievements
            , menuElement model Settings
            , menuElement model About
            ]
        ]


menuElement : Model -> Page -> Html Msg
menuElement model page =
    a [ class "menu-content-element", onPreventDefaultClick (NavigateToPage page), href (pageToHref page), id ("menu-link-" ++ (toString page)) ]
        [ pageRankAssetImage, i18n model.language (MenuTitle page) ]


sidebar : Model -> Html Msg
sidebar model =
    let (nodeClassSuffix, linkClassSuffix) = 
        case model.inputMode of
            NodeMode -> ("activeButton", "")
            LinkMode -> ("", "activeButton")
    in
        div [ class "sidebar" ]
            [ div [ class "description" ] [ i18n model.language (ModeDescription model.inputMode) ]
            , div [ class ("addNode button " ++ nodeClassSuffix), onClick (ActivateMode NodeMode)] [ i18n model.language NodeModeButton ]
            , div [ class ("addLink button " ++ linkClassSuffix), onClick (ActivateMode LinkMode)] [ i18n model.language LinkModeButton ]
            , div [ class "delete button", onClick Clear ] [ i18n model.language ClearButton ]
            ]


footer : Model -> Html Msg
footer model =
    div [ class "footer" ]
        [ div [ class "button", style [ ( "height", "100%" ) ] ] [ i18n model.language CalculatePageRankButton ]
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
            ([ menu model
             , header model
             , graphDesigner model
             , sidebar model
             , footer model
             ]
                ++ (modal)
            )
