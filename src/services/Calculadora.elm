port module Calculadora exposing(..)

type Resultado = Result Float

init : () -> (Model, Cmd Resultado)
init _ = ({a=0.00, b=0.00},Cmd.none)

type alias Model = { a:Float, b:Float }
port resultado : Float -> Cmd res


update : Resultado -> Model -> (Model, Cmd Resultado)
update res model= 
    case res of
        Result resp -> ({a= model.a , b = model.b}, resultado resp)


port somar : (Model -> msg) -> Sub msg
realizarSoma : Model-> Resultado
realizarSoma model = Result (model.a+model.b)


port subtrair : (Model -> msg) -> Sub msg
realizarSubtracao : Model-> Resultado
realizarSubtracao model = Result (model.a-model.b)


port dividir : (Model -> msg) -> Sub msg
realizarDivisao : Model-> Resultado
realizarDivisao model = Result (model.a/model.b)


port multiplicar : (Model -> msg) -> Sub msg
realizarMultiplicacao : Model-> Resultado
realizarMultiplicacao model = Result (model.a*model.b)

subscriptions : Model -> Sub Resultado
subscriptions model = 
  Sub.batch [
    somar realizarSoma,
    dividir realizarDivisao,
    subtrair realizarSubtracao,
    multiplicar realizarMultiplicacao  
  ]

main = Platform.worker
    {
      init = init
    , update = update
    , subscriptions = subscriptions
    }