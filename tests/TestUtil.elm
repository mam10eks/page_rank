module TestUtil exposing (..)

import Components.Model exposing (..)
import Array
import Set exposing (Set)


testModel : Model
testModel =
    Model
        Array.empty
        Set.empty
        (SvgInformations 0 0 0 0)
        False
        Nothing
        Nothing
        Nothing
        MainPage
