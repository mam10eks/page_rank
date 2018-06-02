module Components.Model exposing (..)

import Array
import Set exposing (Set)


type Msg
    = CreateNode ClientSvgPosition
    | LinkPreviewPointerMoved ClientSvgPosition
    | LinkPreviewTargetChanged (Maybe Int)
    | InterruptLinkPreview
    | CreateLinkFromTo Int Int
    | Resize
    | Clear
    | FocusOnNode Int
    | NavigateToPage Page


type Page
    = MainPage
    | Tutorial
    | NextAchievements
    | Settings
    | About


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
    { relativeX : Float
    , relativeY : Float
    }


type alias Model =
    { nodes : Array.Array RelativePosition
    , linksBetweenNodes : Set ( Int, Int )
    , svgInformations : SvgInformations
    , linkPreview : Bool
    , focussedNode : Maybe Int
    , linkPreviewEndPosition : Maybe RelativePosition
    , linkPreviewEndNode : Maybe Int
    , currentPage : Page
    }
