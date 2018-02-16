module View.GraphDesigner exposing ( graphDesigner )

import Components.Model exposing ( .. )
import Components.Update exposing ( .. )

import View.MouseEvents
import View.Math

import Html exposing ( .. )
import Html.Attributes exposing ( .. )
import Svg as Svg
import Svg.Attributes as SvgAttributes
import Array
import Set
import Tuple


graphDesigner : Model -> Html Msg
graphDesigner model =
    let 
        previewLinkSource = get model.focussedNode model.nodes
    in 
        div ( [ class "graph-designer" ] ++ View.MouseEvents.graphDesignerMouseEvents model )
        [ Svg.svg [] (  [marker]
                     ++ ( linkBetweenRelativePositions model 14 previewLinkSource model.linkPreviewEndPosition )
                     ++ ( List.concatMap ( linkBetweenNodes model ) ( Set.toList model.linksBetweenNodes ) )
                     ++ ( List.indexedMap (transformNodeToSvgCircle model) (Array.toList model.nodes) )
                     )
        ]

linkBetweenNodes : Model -> ( Int, Int ) -> List (Svg.Svg Msg)
linkBetweenNodes model (a, b) =
    let
        source = Array.get a model.nodes
        target = Array.get b model.nodes
    in
        linkBetweenRelativePositions model 28 source target


marker : Svg.Svg Msg
marker =
    Svg.marker  [ SvgAttributes.id "triangle"
                , SvgAttributes.viewBox "0 0 10 10"
                , SvgAttributes.refX "0"
                , SvgAttributes.refY "5"
                , SvgAttributes.markerUnits "strokeWidth"
                , SvgAttributes.markerWidth "8"
                , SvgAttributes.markerHeight "6"
                , SvgAttributes.orient "auto"
                ] [ Svg.path [SvgAttributes.d "M 0 0 L 10 5 L 0 10 z"] [] ]


transformNodeToSvgCircle : Model -> Int -> RelativePosition -> Svg.Svg Msg
transformNodeToSvgCircle model id node =
    let focusAnimation = if id  == Maybe.withDefault -1 model.focussedNode
        then [svgCircleFocusAnimation]
        else []
    in
    Svg.circle  ([ SvgAttributes.r "15"
                , SvgAttributes.cx (toString (ceiling (node.relativeX * toFloat model.svgInformations.width)))
                , SvgAttributes.cy (toString (ceiling (node.relativeY * toFloat model.svgInformations.height)))
                ] ++ View.MouseEvents.circleMouseEvents model id ) 
                focusAnimation


linkBetweenRelativePositions : Model -> Int -> Maybe RelativePosition -> Maybe RelativePosition -> List (Svg.Svg Msg)
linkBetweenRelativePositions model r start target =
    case (start, target) of
    (Just a, Just b) ->
        let
            start = ( ceiling (a.relativeX * toFloat model.svgInformations.width)
                    , ceiling (a.relativeY * toFloat model.svgInformations.height)
                    )
            target = ( ceiling (b.relativeX * toFloat model.svgInformations.width)
                     , ceiling (b.relativeY * toFloat model.svgInformations.height)
                     )
            targetOnCircle = View.Math.intersectionLineFromPointToCircleCentreAndCircle
                ( View.Math.Point ( Tuple.first start) ( Tuple.second start ) )
                ( View.Math.Circle r ( View.Math.Point ( Tuple.first target ) ( Tuple.second target ) ) )
        in
            if start == target then
                [ selfCurve start ]
            else
                [ line start ( targetOnCircle.x, targetOnCircle.y ) ]
    other -> []


line: (Int, Int) -> (Int, Int) -> Svg.Svg Msg
line start target = 
    Svg.line [ SvgAttributes.x1 (toString (Tuple.first start))
             , SvgAttributes.y1 (toString (Tuple.second start))
             , SvgAttributes.x2 (toString (Tuple.first target))
             , SvgAttributes.y2 (toString (Tuple.second target))
             , SvgAttributes.markerEnd "url(#triangle)"
             ] []


selfCurve : ( Int, Int ) -> Svg.Svg Msg
selfCurve ( x, y ) =
    let
        length = 50
        bla1 = ceiling ( ( toFloat length ) * 28.0 / sqrt ( 2.0* (length^2) ) )
        bla2 = ceiling ( ( toFloat length ) * 15.0 / sqrt ( 2.0* (length^2) ) )
    in
    Svg.path [ SvgAttributes.d ( String.concat [ "M"
                                               , toString (x-bla2)
                                               , " "
                                               , toString (y-bla2)
                                               , " C "
                                               , toString (x- length)
                                               , " "
                                               , toString (y-length)
                                               , ", "
                                               , toString (x+length)
                                               , " "
                                               , toString (y-length)
                                               , ", "
                                               , toString (x+ bla1)
                                               , " " 
                                               , toString (y- bla1)
                                               ] )
             , SvgAttributes.markerEnd "url(#triangle)"
             , SvgAttributes.style "fill: none;"
             ] []


svgCircleFocusAnimation : Svg.Svg Msg
svgCircleFocusAnimation =
    Svg.animate [ SvgAttributes.values "#349B89;#1f5d52;#349B89;#349B89"
                , SvgAttributes.dur "0.6s"
                , SvgAttributes.repeatCount "indefinite"
                , SvgAttributes.attributeName "fill"
                ] []


get : Maybe Int -> Array.Array a -> Maybe a
get id array =
    case id of
        Just index -> (Array.get index array)
        Nothing -> Nothing