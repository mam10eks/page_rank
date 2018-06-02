module View.Assets exposing (pageRankAssetImage)

import Html exposing (..)
import Html.Attributes exposing (..)
import Components.Model exposing (..)


type Asset
    = Asset String


pageRankAssetImage =
    assetImage (Asset "../static/img/pagerank.png")


assetImage : Asset -> Html Msg
assetImage (Asset str) =
    img [ src str ] []
