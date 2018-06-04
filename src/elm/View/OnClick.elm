module View.OnClick exposing (onPreventDefaultClick)

{-| Stupid workaround
<https://github.com/elm-lang/navigation/issues/13>
-}

import Json.Decode exposing (..)
import Html exposing (..)
import Components.Model exposing (..)
import View.MouseEvents exposing (defaultOptions)
import VirtualDom exposing (onWithOptions)


onPreventDefaultClick : Msg -> Attribute Msg
onPreventDefaultClick message =
    onWithOptions "click"
        { defaultOptions | preventDefault = True }
        (preventDefault2
            |> Json.Decode.andThen (maybePreventDefault message)
        )


preventDefault2 : Decoder Bool
preventDefault2 =
    Json.Decode.map2
        (invertedOr)
        (Json.Decode.field "ctrlKey" Json.Decode.bool)
        (Json.Decode.field "metaKey" Json.Decode.bool)


maybePreventDefault : msg -> Bool -> Decoder msg
maybePreventDefault msg preventDefault =
    case preventDefault of
        True ->
            Json.Decode.succeed msg

        False ->
            Json.Decode.fail "Normal link"


invertedOr : Bool -> Bool -> Bool
invertedOr x y =
    not (x || y)
