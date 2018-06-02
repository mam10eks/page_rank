module Main exposing (..)

import Window
import Array
import Set
import View.View exposing (view)
import Components.Update exposing (..)
import Components.Model exposing (..)
import Components.Routing exposing (..)
import RouteUrl exposing (RouteUrlProgram)


init : ( Model, Cmd msg )
init =
    ( Model
        Array.empty
        Set.empty
        (SvgInformations 0 0 0 0)
        False
        Nothing
        Nothing
        Nothing
        MainPage
    , Cmd.none
    )


main : RouteUrlProgram Never Model Components.Model.Msg
main =
    RouteUrl.program
        { delta2url = deltaToUrl
        , location2messages = urlToMessages
        , init = init
        , view = view
        , update = update
        , subscriptions = subscriptions
        }


subscriptions : Model -> Sub Msg
subscriptions model =
    Window.resizes (\_ -> Resize)
