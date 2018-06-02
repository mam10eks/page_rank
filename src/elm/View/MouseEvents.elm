module View.MouseEvents exposing (graphDesignerMouseEvents, circleMouseEvents, defaultOptions)

import Components.Model exposing (..)
import Json.Decode as Json exposing (..)
import VirtualDom


graphDesignerMouseEvents : Model -> List (VirtualDom.Property Msg)
graphDesignerMouseEvents model =
    let
        createNewNodeOnClick =
            case model.linkPreview of
                True ->
                    [ mouseEvent "mouseup" (\i -> InterruptLinkPreview) ]

                False ->
                    [ mouseEvent "click" CreateNode ]

        updateLinkPreviewOnMove =
            case model.linkPreview of
                True ->
                    [ mouseEvent "mousemove" LinkPreviewPointerMoved ]

                False ->
                    []
    in
        createNewNodeOnClick ++ updateLinkPreviewOnMove


circleMouseEvents : Model -> Int -> List (VirtualDom.Property Msg)
circleMouseEvents model id =
    let
        putFocusOnNodeEvent =
            case model.linkPreview of
                False ->
                    [ mouseEvent "mousedown" (\i -> (FocusOnNode id)) ]

                True ->
                    []

        insertNewLinkEvent =
            case ( model.linkPreview, model.focussedNode ) of
                ( True, Just sourceId ) ->
                    [ mouseEvent "mouseup" (\i -> (CreateLinkFromTo sourceId id)) ]

                other ->
                    []

        putFocusOnLinkTargetEvent =
            case model.linkPreview of
                True ->
                    [ mouseEvent "mouseover" (\i -> (LinkPreviewTargetChanged (Just id)))
                    , mouseEvent "mouseout" (\i -> (LinkPreviewTargetChanged Nothing))
                    ]

                False ->
                    []
    in
        putFocusOnNodeEvent ++ insertNewLinkEvent ++ putFocusOnLinkTargetEvent


defaultOptions : VirtualDom.Options
defaultOptions =
    { preventDefault = True, stopPropagation = True }


mousePositionDecoder : Decoder ClientSvgPosition
mousePositionDecoder =
    Json.map2 ClientSvgPosition
        (field "clientX" Json.int)
        (field "clientY" Json.int)


mouseEvent : String -> (ClientSvgPosition -> value) -> VirtualDom.Property value
mouseEvent event messager =
    VirtualDom.onWithOptions event defaultOptions (Json.map messager mousePositionDecoder)
