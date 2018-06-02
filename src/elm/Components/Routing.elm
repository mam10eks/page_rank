module Components.Routing exposing (..)

import RouteUrl exposing (UrlChange)
import RouteUrl.Builder exposing (builder, toUrlChange, newEntry, appendToPath)
import Components.Model exposing (..)
import Navigation exposing (Location)


deltaToUrl : Model -> Model -> Maybe UrlChange
deltaToUrl oldModel newModel =
    if oldModel.currentPage == newModel.currentPage then
        Maybe.Nothing
    else
        Just
            (builder
                |> newEntry
                |> appendToPath [ pageToHref newModel.currentPage ]
                |> toUrlChange
            )


urlToMessages : Location -> List Msg
urlToMessages location =
    case location.pathname of
        "/achievements" ->
            [ NavigateToPage NextAchievements ]

        "/settings" ->
            [ NavigateToPage Settings ]

        "/about" ->
            [ NavigateToPage About ]

        "/tutorial" ->
            [ NavigateToPage Tutorial ]

        other ->
            [ NavigateToPage MainPage ]


pageToHref : Page -> String
pageToHref page =
    case page of
        MainPage ->
            ""

        NextAchievements ->
            "achievements"

        Settings ->
            "settings"

        About ->
            "about"

        Tutorial ->
            "tutorial"
