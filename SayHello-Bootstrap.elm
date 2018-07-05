import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events as Events
import Bootstrap.CDN as CDN
import Bootstrap.Grid as Grid
import Bootstrap.Card as Card
import Bootstrap.Card.Block as Block
import Bootstrap.Form as Form
import Bootstrap.Form.Input as Input

type alias Model = { name: String }

type Msg = ChangeName String

emptyModel : Model
emptyModel = Model "Anonymous"

init : (Model, Cmd Msg)
init = (emptyModel, Cmd.none)

update : Msg -> Model -> (Model, Cmd Msg)
update msg model =
  case msg of
    ChangeName name -> if name == "" then
                          (emptyModel, Cmd.none)
                        else
                          ({ model | name = name }, Cmd.none)

view : Model -> Html Msg
view model =
  Grid.container []
    [ CDN.stylesheet
    , Card.config [ Card.outlineSecondary ]
        |> Card.headerH1 [] [ text <| "Hello, " ++ model.name ]
        |> Card.footer [] [ text "Simple sayhello program in Elm" ]
        |> Card.block []
            [ Block.custom
              <| Form.formInline []
                [ Form.label [] [text "Enter your name here - "]
                , Input.text
                  [ Input.placeholder emptyModel.name
                  , Input.onInput ChangeName
                  ]
                ]
            ]
        |> Card.view
    ]

main : Program Never Model Msg
main = Html.program
        { init = init
        , update = update
        , view = view
        , subscriptions = \_ -> Sub.none
        }
