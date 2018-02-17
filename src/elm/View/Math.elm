module View.Math exposing (..)


type alias Circle =
    { radius : Int
    , centre : Point
    }


type alias Point =
    { x : Int
    , y : Int
    }


intersectionLineFromPointToCircleCentreAndCircle : Point -> Circle -> Point
intersectionLineFromPointToCircleCentreAndCircle point circle =
    let
        x =
            toFloat (point.x - circle.centre.x)

        y =
            toFloat (point.y - circle.centre.y)

        radiusTimesInvertedLength =
            (toFloat circle.radius) / sqrt (x ^ 2 + y ^ 2)
    in
        { x = circle.centre.x + ceiling (x * radiusTimesInvertedLength)
        , y = circle.centre.y + ceiling (y * radiusTimesInvertedLength)
        }
