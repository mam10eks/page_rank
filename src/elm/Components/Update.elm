module Components.Update exposing (..)

import Components.Model exposing (..)
import Components.NativeModule exposing (svgMetrics)
import Array
import Set


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    let
        ret =
            { model | svgInformations = svgMetrics () }
    in
        case msg of
            CreateNode clientMousePositionInSvg ->
                ( { ret
                    | nodes = Array.push (createRelativeNode clientMousePositionInSvg ret.svgInformations) ret.nodes
                    , linkPreview = False
                    , focussedNode = Nothing
                    , linkPreviewEndNode = Nothing
                  }
                , Cmd.none
                )

            LinkPreviewPointerMoved clientMousePositionInSvg ->
                ( { ret
                    | linkPreviewEndPosition = Just (createRelativeNode clientMousePositionInSvg model.svgInformations)
                  }
                , Cmd.none
                )

            LinkPreviewTargetChanged (Just targetId) ->
                ( { ret
                    | linkPreviewEndNode = Just targetId
                  }
                , Cmd.none
                )

            LinkPreviewTargetChanged Nothing ->
                ( { ret
                    | linkPreviewEndNode = Nothing
                  }
                , Cmd.none
                )

            InterruptLinkPreview ->
                ( { ret
                    | focussedNode = Nothing
                    , linkPreview = False
                    , linkPreviewEndPosition = Nothing
                    , linkPreviewEndNode = Nothing
                  }
                , Cmd.none
                )

            CreateLinkFromTo sourceId targetId ->
                ( { ret
                    | focussedNode = Nothing
                    , linkPreview = False
                    , linkPreviewEndPosition = Nothing
                    , linkPreviewEndNode = Nothing
                    , linksBetweenNodes = Set.insert ( sourceId, targetId ) ret.linksBetweenNodes
                  }
                , Cmd.none
                )

            Resize ->
                ( ret, Cmd.none )

            Clear ->
                ( { ret
                    | nodes = Array.empty
                    , linkPreview = False
                    , linksBetweenNodes = Set.empty
                    , focussedNode = Nothing
                    , linkPreviewEndNode = Nothing
                    , linkPreviewEndPosition = Nothing
                  }
                , Cmd.none
                )

            FocusOnNode id ->
                ( { ret
                    | linkPreview = True
                    , focussedNode = Just id
                    , linkPreviewEndNode = Just id
                  }
                , Cmd.none
                )

            NavigateToPage page ->
                ( { ret
                    | currentPage = page
                  }
                , Cmd.none
                )

            ActivateMode newMode ->
                ( { ret
                    | inputMode = newMode
                  }
                , Cmd.none
                )


createRelativeNode : ClientSvgPosition -> SvgInformations -> RelativePosition
createRelativeNode clientSvgPosition svgInformation =
    { relativeX = toFloat (clientSvgPosition.x - svgInformation.left) / toFloat svgInformation.width
    , relativeY = toFloat (clientSvgPosition.y - svgInformation.top) / toFloat svgInformation.height
    }
