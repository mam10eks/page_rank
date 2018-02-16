module Components.Update exposing (..)

import Components.Model exposing ( .. )
import Components.NativeModule exposing (svgMetrics)

import Array
import Set


type Msg =
    CreateNode ClientSvgPosition
    | LinkPreviewPointerMoved ClientSvgPosition
    | InterruptLinkPreview
    | CreateLinkFromTo Int Int
    | Resize
    | Clear
    | FocusOnNode Int


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    let
        ret = {model | svgInformations = svgMetrics()}
    in case msg of
        CreateNode clientMousePositionInSvg
            -> ( { ret 
                 | nodes = Array.push (createRelativeNode clientMousePositionInSvg ret.svgInformations) ret.nodes
                 , linkPreview = False
                 , focussedNode = Nothing
                 }
            , Cmd.none
            )
        LinkPreviewPointerMoved clientMousePositionInSvg
            -> ( {ret 
                 | linkPreviewEndPosition = Just ( createRelativeNode clientMousePositionInSvg model.svgInformations )
                 }
               , Cmd.none
               )
        InterruptLinkPreview
            -> ( {ret
                 | focussedNode = Nothing
                 , linkPreview = False
                 , linkPreviewEndPosition = Nothing
                 } 
               , Cmd.none
               )
        CreateLinkFromTo sourceId targetId
            -> ( {ret 
                 | focussedNode = Nothing
                 , linkPreview = False
                 , linkPreviewEndPosition = Nothing 
                 , linksBetweenNodes = Set.insert (sourceId, targetId) ret.linksBetweenNodes
                 }
               , Cmd.none
               )
        Resize
            -> ( ret , Cmd.none )
        Clear
            -> ( { ret 
                 | nodes = Array.empty
                 , linkPreview = False
                 , linksBetweenNodes = Set.empty
                 , focussedNode = Nothing
                 , linkPreviewEndPosition = Nothing 
                 }
               , Cmd.none
               )
        FocusOnNode id
            -> ( { ret 
                 | linkPreview = True
                 , focussedNode = Just id
                 }
               , Cmd.none
               )


createRelativeNode : ClientSvgPosition -> SvgInformations -> RelativePosition
createRelativeNode clientSvgPosition svgInformation =
    { relativeX = toFloat (clientSvgPosition.x - svgInformation.left)/ toFloat svgInformation.width
    , relativeY = toFloat (clientSvgPosition.y - svgInformation.top)/ toFloat svgInformation.height
    }