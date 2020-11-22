<template>
  <div id="app">
    <img src="./assets/logo.png" />
    <h1>{{ mensagem }}</h1>
    <div>
      <input type="number" v-model="n1" placeholder="Numero 1" />
    </div>

    <div>
      <input type="number" v-model="n2" placeholder="Numero 2" />
    </div>

    <h2>O resultado é = {{ resultado }}</h2>

    <div>
      <button @click="textInput()">Saudacao</button>
      <button @click="calcular('somar')">Somar</button>
      <button @click="calcular('subtrair')">Subtrair</button>
      <button @click="calcular('dividir')">Dividir</button>
      <button @click="calcular('multiplicar')">Multiplicar</button>
    </div>
  </div>
</template>

<script>
import * as ElmServiceBuilder from "./elm/elm-service-builder";
const MessageService = ElmServiceBuilder(require("./services/Main.elm"));
const CalculatorService = ElmServiceBuilder(
  require("./services/Calculadora.elm")
);

export default {
  name: "app",
  data: () => ({
    mensagem: "",
    resultado: 0,
    n1: 0,
    n2: 0,
  }),
  mounted() {
    MessageService.ports.textOutput.subscribe((data) => {
      this.mensagem = data;
    });
    CalculatorService.ports.resultado.subscribe((data) => {
      this.resultado = data;
    });
  },
  methods: {
    textInput() {
      MessageService.ports.textInputHello.send("Olá Carlos Neto 2");
    },
    calcular(calc) {
      CalculatorService.ports[calc].send({
        a: parseFloat(this.n1),
        b: parseFloat(this.n2),
      });
    },
  },
};
</script>

<style>
#app {
  font-family: "Avenir", Helvetica, Arial, sans-serif;
  -webkit-font-smoothing: antialiased;
  -moz-osx-font-smoothing: grayscale;
  text-align: center;
  color: #2c3e50;
  margin-top: 60px;
}
</style>
