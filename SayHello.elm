module SayHello exposing (main)

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)

type alias Model = { name: String }

type Msg = NameChange String

init : (Model, Cmd Msg)
init = (Model "", Cmd.none)

update : Msg -> Model -> (Model, Cmd Msg)
update msg model =
  case msg of
    NameChange newName -> ({ model | name = newName } , Cmd.none)

view : Model -> Html Msg
view model = div []
              [
                input
                [type_ "text"
                , placeholder "Enter your name, please"
                , autofocus True
                , onInput NameChange] [],
                p [] [text <| "Hello, " ++ model.name]
              ]

main = Html.program {
          init = init,
          view = view,
          update = update,
          subscriptions = \_ -> Sub.none
        }
