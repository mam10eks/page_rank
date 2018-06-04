module I18N exposing (Message(..), i18n)

import Components.Model exposing (..)
import Html exposing (text, Html)


type alias EngGer =
    { english : String
    , german : String
    }


type Message
    = ModeDescription InputMode
    | Header
    | ClearButton
    | LinkModeButton
    | NodeModeButton
    | CalculatePageRankButton
    | Menu
    | MenuTitle Page


i18n : Language -> Message -> Html Msg
i18n language message =
    let
        translatedMessage =
            case message of
                ModeDescription NodeMode ->
                    EngGer "ToDo: Add description of the node-mode" "ToDo: Beschreibung des Node-Mode"

                ModeDescription LinkMode ->
                    EngGer "ToDo: Implement and describe the link mode (mainly for mobile phones)" "ToDo: Beschreibung des Link-Mode und Implementierung dessen"
                
                Header ->
                    EngGer "An Interactive PageRank Example" "Interaktives PageRank Beispiel"

                ClearButton ->
                    EngGer "Clear" "Zurücksetzen"
                
                LinkModeButton ->
                    EngGer "Add Link" "Kanten-Modus"
                
                NodeModeButton ->
                    EngGer "Add Node" "Knoten-Modus"

                CalculatePageRankButton ->
                    EngGer "Calculate PageRank" "Berechne PageRank"

                Menu ->
                    EngGer "Menu" "Menü"

                MenuTitle Tutorial ->
                    EngGer "Tutorial" "Einführung"
                
                MenuTitle NextAchievements ->
                    EngGer "Next Achievement" "Nächste Herausforderungen"

                MenuTitle Settings ->
                    EngGer "Settings" "Einstellungen"
                
                MenuTitle About ->
                    EngGer "About" "Über"
                
                MenuTitle MainPage ->
                    EngGer "Home" "Home"
    in
        case language of
            English ->
                text (.english translatedMessage)

            German ->
                text (.german translatedMessage)
