module Main exposing (..)

import Window
import Array
import Set
import Html exposing ( program )
import View.View exposing ( view )
import Components.Update exposing ( .. )
import Components.Model exposing ( .. )


init : ( Model, Cmd msg )
init = ( Model Array.empty Set.empty (SvgInformations 0 0 0 0) False Nothing Nothing, Cmd.none )


main : Program Never Model Components.Update.Msg
main = program  { init = init
                , view = view
                , update = update
                , subscriptions = subscriptions
                }


subscriptions : Model -> Sub Msg
subscriptions model =
    Window.resizes (\_ -> Resize)