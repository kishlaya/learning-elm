module RandomQuote exposing (main)

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events as Events
import Bootstrap.Grid as Grid
import Bootstrap.Grid.Row as Row
import Bootstrap.Grid.Col as Col
import Bootstrap.CDN as CDN
import Bootstrap.Button as Button
import Bootstrap.Card as Card
import Bootstrap.Card.Block as Block
import Http
import Json.Decode as Decode

type alias Model = { quote: String }

type Msg = Generate | NewQuote (Result Http.Error String)

init : (Model, Cmd Msg)
init = (Model "", getRandomQuote)

update : Msg -> Model -> (Model, Cmd Msg)
update msg model =
  case msg of
    Generate -> (model, getRandomQuote)
    NewQuote (Err _) -> ({ model | quote = "" }, Cmd.none)
    NewQuote (Ok quote) -> ({ model | quote = quote }, Cmd.none)

getRandomQuote : Cmd Msg
getRandomQuote =
  let
    url = "http://inspirobot.me/api?generate=true"
    request = Http.request
      { method = "GET"
      , headers = []
      , url = url
      , body = Http.emptyBody
      , expect = Http.expectString
      , timeout = Nothing
      , withCredentials = False
      }
  in
    Http.send NewQuote request

view : Model -> Html Msg
view model =
  Grid.container []
    [ CDN.stylesheet
    , Card.config [ Card.outlineSecondary ]
      |> Card.headerH1 [] [text "Random Quote Generator"]
      |> Card.footer [] [text "Generate \"inspirational\" quotes using inspirobot API"]
      |> Card.block []
          [ Block.custom
              <| Grid.simpleRow
                  [ Grid.col [ Col.md8 ] [img [src model.quote] []]
                  , Grid.col [] [Button.button [Button.secondary, Button.onClick Generate] [text "Another one!"]]]
          ]
      |> Card.view
    ]

main = Html.program {
          init = init,
          view = view,
          update = update,
          subscriptions = \_ -> Sub.none
        }
