module RoutingTest exposing (..)

import Expect as Expect
import Test as Test
import TestUtil exposing (..)
import Components.Routing exposing (..)
import Components.Model exposing (..)
import RouteUrl exposing (..)
import Navigation exposing (Location)
import RouteUrl.Builder exposing (builder, toUrlChange, newEntry, appendToPath)


url : String -> Maybe UrlChange
url path =
    Just (builder |> newEntry |> appendToPath [ path ] |> toUrlChange)


pathLocation : String -> Location
pathLocation path =
    Location "" "" "" "" "" "" path "" "" "" ""

testDeltaToUrl : Test.Test
testDeltaToUrl =
    Test.describe "Test the url changes triggered by deltaToUrl"
        [ Test.test "If the model before and after is showing the MainPage" <|
            \_ -> Expect.equal Maybe.Nothing (deltaToUrl testModel testModel)
        , Test.test "If the model before and after is showing the next achievements" <|
            \_ -> Expect.equal Maybe.Nothing (deltaToUrl { testModel | currentPage = NextAchievements } { testModel | currentPage = NextAchievements })
        , Test.test "If the model before and after is showing the settings" <|
            \_ -> Expect.equal Maybe.Nothing (deltaToUrl { testModel | currentPage = Settings } { testModel | currentPage = Settings })
        , Test.test "If the model before and after is showing the next about page" <|
            \_ -> Expect.equal Maybe.Nothing (deltaToUrl { testModel | currentPage = About } { testModel | currentPage = About })
        , Test.test "If the model before and after is showing the next tutorial page" <|
            \_ -> Expect.equal Maybe.Nothing (deltaToUrl { testModel | currentPage = Tutorial } { testModel | currentPage = Tutorial })
        , Test.test "If the model before is showing the main page and after is showing the next achievements" <|
            \_ -> Expect.equal (url "achievements") (deltaToUrl testModel { testModel | currentPage = NextAchievements })
        , Test.test "If the model before is showing the main page and after is showing the settings" <|
            \_ -> Expect.equal (url "settings") (deltaToUrl testModel { testModel | currentPage = Settings })
        , Test.test "If the model before is showing the main page and after is showing the about" <|
            \_ -> Expect.equal (url "about") (deltaToUrl testModel { testModel | currentPage = About })
        , Test.test "If the model before is showing the main page and after is showing the tutorial" <|
            \_ -> Expect.equal (url "tutorial") (deltaToUrl testModel { testModel | currentPage = Tutorial })
        , Test.test "If the model before is showing the about page and after is showing the main page" <|
            \_ -> Expect.equal (url "") (deltaToUrl { testModel | currentPage = About } testModel)
        , Test.test "If the model before is showing the settings page and after is showing the main page" <|
            \_ -> Expect.equal (url "") (deltaToUrl { testModel | currentPage = Settings } testModel)
        , Test.test "If the model before is showing the achievements page and after is showing the main page" <|
            \_ -> Expect.equal (url "") (deltaToUrl { testModel | currentPage = NextAchievements } testModel)
        , Test.test "If the model before is showing the tutorial page and after is showing the main page" <|
            \_ -> Expect.equal (url "") (deltaToUrl { testModel | currentPage = Tutorial } testModel)
        ]


testUrlToMessages : Test.Test
testUrlToMessages =
    Test.describe "Test that correct messages are retrieved for url locations"
        [ Test.test "Empty path should show main page" <|
            \_ -> Expect.equal [ NavigateToPage MainPage ] (urlToMessages (pathLocation ""))
        , Test.test "Empty Slash as path should show main page" <|
            \_ -> Expect.equal [ NavigateToPage MainPage ] (urlToMessages (pathLocation "/"))
        , Test.test "Unknown path should show main page" <|
            \_ -> Expect.equal [ NavigateToPage MainPage ] (urlToMessages (pathLocation "asdsace"))
        , Test.test "Unknown glibberish path should show main page" <|
            \_ -> Expect.equal [ NavigateToPage MainPage ] (urlToMessages (pathLocation "/asdsace/sadsa/sadsa/"))
        , Test.test "/achievements path should show achievements page" <|
            \_ -> Expect.equal [ NavigateToPage NextAchievements ] (urlToMessages (pathLocation "/achievements"))
        , Test.test "/settings path should show settings page" <|
            \_ -> Expect.equal [ NavigateToPage Settings ] (urlToMessages (pathLocation "/settings"))
        , Test.test "/about path should show about page" <|
            \_ -> Expect.equal [ NavigateToPage About ] (urlToMessages (pathLocation "/about"))
        , Test.test "/tutorial path should show tutorial page" <|
            \_ -> Expect.equal [ NavigateToPage Tutorial ] (urlToMessages (pathLocation "/tutorial"))
        ]
