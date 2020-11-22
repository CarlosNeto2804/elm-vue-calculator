port module Main exposing (..)

main = Platform.worker
    {
    init = init
    , update = update
    , subscriptions = subscriptions
    }

type alias Model = { myTextVal : String }

init : () -> (Model, Cmd MyMsg)
init _ = (Model "", Cmd.none)

type MyMsg = InMsg String

update : MyMsg -> Model -> (Model, Cmd MyMsg)
update msg model = 
    case msg of
        InMsg str -> (Model str, textOutput str)

port textInput : (String -> msg) -> Sub msg
port textInputHello : (String -> msg) -> Sub msg
port textOutput : String -> Cmd msg

decodeValue : String -> MyMsg
decodeValue str = InMsg str

subscriptions : Model -> Sub MyMsg
subscriptions model = 
    Sub.batch [
        textInput decodeValue,
        textInputHello decodeValue
    ]