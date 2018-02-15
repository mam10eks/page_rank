module Main exposing (..)

import Html exposing ( beginnerProgram )
import Components.Hello exposing ( hello )
import Components.View exposing ( view )


main = beginnerProgram { model = model, view = view, update = update }


-- MODEL
type alias Model = Int

model : Model
model = 0


-- UPDATE
type Msg = NoOp | Increment

update : Msg -> Model -> Model
update msg model =
  case msg of
    NoOp -> model
    Increment -> model + 1
