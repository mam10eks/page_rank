module MathTest exposing (..)

import Expect as Expect
import Test as Test
import View.Math

c : ( Int, Int ) -> Int -> View.Math.Circle
c (a, b) r = View.Math.Circle r ( p a b )

p : Int -> Int -> View.Math.Point
p a b = View.Math.Point a b

i : View.Math.Point -> View.Math.Circle -> View.Math.Point
i a b = View.Math.intersectionLineFromPointToCircleCentreAndCircle a b

testAxis : Test.Test
testAxis =
    Test.describe "Test point is vertical or horizontal of the centre"
    [ Test.test "point is on the left" <|
          \_ -> Expect.equal ( p 85 0 ) (i ( p 0 0 ) ( c ( 100, 0 ) 15 ) )

    , Test.test "point is on the right" <|
          \_ -> Expect.equal ( p 115 0 ) (i ( p 200 0 ) ( c ( 100, 0 ) 15 ) )

    , Test.test "point is above the centre" <|
          \_ -> Expect.equal ( p 100 65 ) (i ( p 100 100 ) ( c ( 100, 50 ) 15 ) )

    , Test.test "point is below the centre" <|
          \_ -> Expect.equal ( p 100 35 ) (i ( p 100 0 ) ( c ( 100, 50 ) 15 ) )
    ]