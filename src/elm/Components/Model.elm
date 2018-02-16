module Components.Model exposing (..)

import Array
import Set exposing ( Set )

type alias ClientSvgPosition =
    { x : Int
    , y : Int
    }

type alias SvgInformations =
    { width : Int
    , height : Int
    , top : Int
    , left : Int
    }


type alias RelativePosition =
    { relativeX: Float
    , relativeY: Float
    }

type alias Model =
    { nodes : Array.Array (RelativePosition)
    , linksBetweenNodes : Set (Int , Int) 
    , svgInformations : SvgInformations
    , linkPreview : Bool
    , focussedNode : Maybe Int
    , linkPreviewEndPosition : Maybe RelativePosition
    }