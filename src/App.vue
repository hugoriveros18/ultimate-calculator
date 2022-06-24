<template>
  <div class="header" :class="{'header-dark-mode': darkMode, 'header-light-mode': !darkMode}">
    <div class="modes-container">
      <ModeButtonVue class="mode-button-left" :colorMode2="lightMode" :Mode="iconLight" @click="darkModeOff" :class="{'dark-button-on': darkMode, 'light-button-on': !darkMode}"/>
      <ModeButtonVue class="mode-button-right" :colorMode="darkMode" :Mode="iconDark" @click="darkModeOn" :class="{'dark-button-on': darkMode, 'light-button-on': !darkMode}"/>
    </div>
  </div>
  <div class="calculation" :class="{'calculation-dark-mode': darkMode, 'calculation-light-mode': !darkMode}">
    <div class="main-operation-container">
      <div class="pointer" :class="{'pointer-visible':pointer,'pointer-not-visible':!pointer}">{{ pointerValue }}</div>
      <div class="main-operation" :class="{'main-operation-letter-dark': darkMode, 'main-operation-letter-light': !darkMode}">{{ screenOperation }}</div>
    </div>
    <div class="result-operation-container">
      <div class="result-operation" :class="{'result-operation-letter-dark': darkMode, 'result-operation-letter-light': !darkMode}"> {{ screenResult }}</div>
    </div>
  </div>
  <div :class="{'general-buttons-dark': darkMode, 'general-buttons-light': !darkMode}">
    <div class="buttons-container" :class="{'buttons-background-dark': darkMode, 'buttons-background-light': !darkMode}">
      <GreenButton v-text="ayc" @click="removeItems" :colorMode="darkMode"/>
      <GreenButton v-text="plusMinus" @click="plusMinusFunction" :colorMode="darkMode"/>
      <GreenButton v-text="percentage" @click="addValue" :value="percentage" :colorMode="darkMode"/>
      <OrangeButtonVue v-text="division" @click="addValue" :value="division" :colorMode="darkMode"/>
      <WhiteButtonVue v-text="seven" @click="addValue" :value="seven" :colorMode="darkMode"/>
      <WhiteButtonVue v-text="eight" @click="addValue" :value="eight" :colorMode="darkMode"/>
      <WhiteButtonVue v-text="nine" @click="addValue" :value="nine" :colorMode="darkMode"/>
      <OrangeButtonVue v-text="multiplication"  @click="addValue" :value="multiplication" :colorMode="darkMode"/>
      <WhiteButtonVue v-text="four" @click="addValue" :value="four" :colorMode="darkMode"/>
      <WhiteButtonVue v-text="five" @click="addValue" :value="five" :colorMode="darkMode"/>
      <WhiteButtonVue v-text="six" @click="addValue" :value="six" :colorMode="darkMode"/>
      <OrangeButtonVue v-text="minus" @click="addValue" :value="minus" :colorMode="darkMode"/>
      <WhiteButtonVue v-text="one" @click="addValue" :value="one" :colorMode="darkMode"/>
      <WhiteButtonVue v-text="two" @click="addValue" :value="two" :colorMode="darkMode"/>
      <WhiteButtonVue v-text="three" @click="addValue" :value="three" :colorMode="darkMode"/>
      <OrangeButtonVue v-text="plus" @click="addValue" :value="plus" :colorMode="darkMode"/>
      <WhiteButtonVue v-text="removeLast" @click="removeLastItem" :colorMode="darkMode"/>
      <WhiteButtonVue v-text="zero" @click="addValue" :value="zero" :colorMode="darkMode"/>
      <WhiteButtonVue v-text="point" @click="addValue" :value="point" :colorMode="darkMode"/>
      <OrangeButtonVue v-text="equal" @click="resultEqual" :colorMode="darkMode"/>
    </div>
  </div>
</template>

<script setup>
import GreenButton from './components/GreenButton.vue'
import OrangeButtonVue from './components/OrangeButton.vue'
import WhiteButtonVue from './components/WhiteButton.vue'
import ModeButtonVue from './components/ModeButton.vue'
import { ref, watch } from "vue"

//MAIN BUTTONS CALCULATOR
const ayc = "A/C";
const plusMinus = "+/-";
const percentage = "%";
const division = String.fromCharCode(247);
const multiplication = "x";
const minus = "-";
const plus = "+";
const equal = "=";
const one = "1";
const two = "2";
const three = "3";
const four = "4";
const five = "5";
const six = "6";
const seven = "7";
const eight = "8";
const nine = "9";
const zero = "0";
const point = ".";
const removeLast = "del";
const iconLight = "light_mode";
const iconDark = "dark_mode";
let pointer = ref(true);
let pointerValue = ref("|")

setInterval(() => {pointer.value=!pointer.value},500)

const operatorsList = {
  plus: plus,
  minus: minus,
  multiplication: multiplication,
  division: division
};
const operatorListMultDiv = {
  multiplication: multiplication,
  division: division
};
let darkMode = ref(true);
let lightMode = ref(false);
const Big = require('big.js')

let internalOperation = ref([]);
let screenOperation = ref("");
let screenResult = ref("");

watch(internalOperation.value, (val) => {
  let counter = 0;
  let numbers = [];
  let finalNumbers = [];
  let operators = [];
  let screenChecker = true;
  if (val[0] == minus) {
    finalNumbers.push("0");
    operators.push("-");
    counter = 1;
    screenChecker = false;
  }
  while (counter < val.length) {
    if (Object.values(operatorsList).includes(val[counter])) {
      if (operators.length > 0 && Object.values(operatorsList).includes(val[counter-1])) {
        numbers.push(val[counter]);        
      } else {
        operators.push(val[counter]);
        finalNumbers.push(numbers.join(""));
        numbers = []
      }
    } else {
      numbers.push(val[counter]);
    }
    counter++
  }
  screenResult.value = ""
  screenOperation.value = val.join("")

  //In case that there is already an operator and the last value in "internalOperation" is not an operator(means that is a number)
  if (operators.length > 0 && !Object.values(operatorsList).includes(val[val.length-1])) {
    let numCounter = 1;
    let opCounter = 0;
    let newNumber = numbers.join("");
    let result = 0;
    if (finalNumbers[0].includes(percentage)) {
      result = parseFloat(finalNumbers[0].slice(0,-1)) / 100
    } else {
      result = parseFloat(finalNumbers[0])
    }
    if (finalNumbers.length == 1){
      switch(operators[opCounter]){
        case plus:
          if (newNumber.includes(percentage) && !newNumber.includes(minus)) {
            result = Big(result).plus(result * (parseFloat(newNumber.slice(0,-1)) / 100)).toNumber();
          } else {
            result = Big(result).plus(parseFloat(newNumber)).toNumber();
          }
          break;
        case minus:
          if (newNumber.includes(percentage) && !newNumber.includes(minus)) {
            result = Big(result).minus(result * (parseFloat(newNumber.slice(0,-1)) / 100)).toNumber();
          } else {
            result = Big(result).minus(parseFloat(newNumber)).toNumber();
          }
          break;
        case multiplication:
          if (newNumber.includes(percentage) && !newNumber.includes(minus)) {
            result = Big(result).times(parseFloat(newNumber.slice(0,-1)) / 100).toNumber();
          } else if (newNumber.includes(percentage) && newNumber.includes(minus)) {
            result = Big(result).times((parseFloat(newNumber.slice(1)) / 100)*(-1)).toNumber();
          } else {
            result = Big(result).times(parseFloat(newNumber)).toNumber();
          }
          break;
        case division:
          if (newNumber.includes(percentage) && !newNumber.includes(minus)) {
            result = Big(result).div(parseFloat(newNumber.slice(0,-1)) / 100).toNumber();
          } else if (newNumber.includes(percentage) && newNumber.includes(minus)) {
            result = Big(result).div((parseFloat(newNumber.slice(1)) / 100)*(-1)).toNumber();
          } else {
            result = Big(result).div(parseFloat(newNumber)).toNumber();
          }
          break;
      }
      if (!Object.values(operatorsList).includes(internalOperation.value[0])) {
        if (isNaN(result)) {
          screenResult.value = "Error";          
        } else {
          screenResult.value = result;
        }
      }
      } else {
        while (numCounter < finalNumbers.length){
        switch(operators[opCounter]){
          case plus:
            if (finalNumbers[numCounter].includes(percentage) && !newNumber.includes(minus)) {
              result = Big(result).plus(result * (parseFloat(finalNumbers[numCounter].slice(0,-1)) / 100)).toNumber();
            } else {
              result = Big(result).plus(parseFloat(finalNumbers[numCounter])).toNumber();
            }
            break;
          case minus:
            if (finalNumbers[numCounter].includes(percentage) && !newNumber.includes(minus)) {
              result = Big(result).minus(result * (parseFloat(finalNumbers[numCounter].slice(0,-1)) / 100)).toNumber();
            } else {
              result = Big(result).minus(parseFloat(finalNumbers[numCounter])).toNumber();
            }
            break;
          case multiplication:
            if (finalNumbers[numCounter].includes(percentage) && !newNumber.includes(minus)) {
              result = Big(result).times(parseFloat(finalNumbers[numCounter].slice(0,-1)) / 100).toNumber();
            } else {
              result = Big(result).times(parseFloat(finalNumbers[numCounter])).toNumber();
            }
            break;
          case division:
            if (finalNumbers[numCounter].includes(percentage) && !newNumber.includes(minus)) {
              result = Big(result).div(parseFloat(finalNumbers[numCounter].slice(0,-1)) / 100).toNumber();
            } else {
              result = Big(result).div(parseFloat(finalNumbers[numCounter]));
            }
            break;
        }
        numCounter++
        opCounter++
        }
        switch(operators[operators.length-1]) {
          case plus:
            if (newNumber.includes(percentage) && !newNumber.includes(minus)) {
              result = Big(result).plus(result * (parseFloat(newNumber.slice(0,-1)) / 100)).toNumber();
              if (isNaN(result)) {
                screenResult.value = "Error";          
              } else {
                screenResult.value = result;
              }
            } else {
              result = Big(result).plus(parseFloat(newNumber)).toNumber();
              if (isNaN(result)) {
                screenResult.value = "Error";          
              } else {
                screenResult.value = result;
              }
            }
            break;
          case minus:
            if (newNumber.includes(percentage) && !newNumber.includes(minus)) {
              result = Big(result).minus(result * (parseFloat(newNumber.slice(0,-1)) / 100)).toNumber();
              if (isNaN(result)) {
                screenResult.value = "Error";          
              } else {
                screenResult.value = result;
              }
            } else {
              result = Big(result).minus(parseFloat(newNumber)).toNumber();
              if (isNaN(result)) {
                screenResult.value = "Error";          
              } else {
                screenResult.value = result;
              }
            }
            break;
          case multiplication:
            if (newNumber.includes(percentage) && !newNumber.includes(minus)) {
              result = Big(result).times(parseFloat(newNumber.slice(0,-1)) / 100).toNumber();
              if (isNaN(result)) {
                screenResult.value = "Error";          
              } else {
                screenResult.value = result;
              }
            } else {
              result = Big(result).times(parseFloat(newNumber)).toNumber();
              if (isNaN(result)) {
                screenResult.value = "Error";          
              } else {
                screenResult.value = result;
              }
            }
            break;
          case division:
            if (newNumber.includes(percentage) && !newNumber.includes(minus)) {
              result = Big(result).div(parseFloat(newNumber.slice(0,-1)) / 100).toNumber();
              if (isNaN(result)) {
                screenResult.value = "Error";          
              } else {
                screenResult.value = result;
              }
            } else {
              result = Big(result).div(parseFloat(newNumber)).toNumber();
              if (isNaN(result)) {
                screenResult.value = "Error";          
              } else {
                screenResult.value = result;
              }
            }
            break;
        }
      }
  }

//In case that there is more than one operator and the last value in "internalOperation" is an operator
if (operators.length > 1 && Object.values(operatorsList).includes(val[val.length-1])){
  let numCounter = 1;
  let opCounter = 0;
  let newNumber = numbers.join("");
  let result = 0;
    if (finalNumbers[0].includes(percentage)) {
      result = parseFloat(finalNumbers[0].slice(0,-1)) / 100
    } else {
      result = parseFloat(finalNumbers[0])
    }
  if (finalNumbers.length == 1){
    switch(operators[opCounter]){
      case plus:
        if (newNumber.includes(percentage)) {
          result = Big(result).plus(result * (parseFloat(newNumber.slice(0,-1)) / 100)).toNumber();
        } else {
          result = Big(result).plus(parseFloat(newNumber)).toNumber();
        }
        break;
      case minus:
        if (newNumber.includes(percentage)) {
          result = Big(result).minus(result * (parseFloat(newNumber.slice(0,-1)) / 100)).toNumber();
        } else {
          result = Big(result).minus(parseFloat(newNumber)).toNumber();
        }
        break;
      case multiplication:
        if (newNumber.includes(percentage)) {
          result = Big(result).times(parseFloat(newNumber.slice(0,-1)) / 100).toNumber();
        } else {
          result = Big(result).times(parseFloat(newNumber)).toNumber();
        }
        break;
      case division:
        if (newNumber.includes(percentage)) {
          result = Big(result).div(parseFloat(newNumber.slice(0,-1)) / 100).toNumber();
        } else {
          result = Big(result).div(parseFloat(newNumber)).toNumber();
        }
        break;
    }
    screenResult.value = result;
    } else {
    while (numCounter < finalNumbers.length){
    switch(operators[opCounter]){
      case plus:
        if (finalNumbers[numCounter].includes(percentage)) {
          result = Big(result).plus(result * (parseFloat(finalNumbers[numCounter].slice(0,-1)) / 100)).toNumber();
        } else {
          result = Big(result).plus(parseFloat(finalNumbers[numCounter])).toNumber();
        }
        break;
      case minus:
        if (finalNumbers[numCounter].includes(percentage)) {
          result = Big(result).minus(result * (parseFloat(finalNumbers[numCounter].slice(0,-1)) / 100)).toNumber();
        } else {
          result = Big(result).minus(parseFloat(finalNumbers[numCounter])).toNumber();
        }
        break;
      case multiplication:
        if (finalNumbers[numCounter].includes(percentage)) {
          result = Big(result).times(parseFloat(finalNumbers[numCounter].slice(0,-1)) / 100).toNumber();
        } else {
          result = Big(result).times(parseFloat(finalNumbers[numCounter])).toNumber();
        }
        break;
      case division:
        if (finalNumbers[numCounter].includes(percentage)) {
          result = Big(result).div(parseFloat(finalNumbers[numCounter].slice(0,-1)) / 100).toNumber();
        } else {
          result = Big(result).div(parseFloat(finalNumbers[numCounter])).toNumber();
        }
        break;
    }
    numCounter++
    opCounter++
    }
    if (finalNumbers.length == 2 && operators.length == 2 && screenChecker == false) {
      //pass
    } else {
      screenResult.value = result;
    }
  }
}
});

const darkModeOff = () => {
  darkMode.value = false;
  lightMode.value = true;

}
const darkModeOn = () => {
  darkMode.value = true;
  lightMode.value = false;
}

const addValue = (e) => {
  if (Object.values(operatorsList).includes(e.target.value)) {
    if (internalOperation.value.length == 0) {
      if (e.target.value == minus) {
        internalOperation.value.push(e.target.value);
      } else {
        //pass
      }
    } else {
      if (Object.values(operatorsList).includes(internalOperation.value[internalOperation.value.length-1])) {
        if (e.target.value == minus && Object.values(operatorListMultDiv).includes(internalOperation.value[internalOperation.value.length-1])) {
        internalOperation.value.push(e.target.value);
        } else if (e.target.value == minus && internalOperation.value[internalOperation.value.length-1] == plus){
          internalOperation.value[internalOperation.value.length-1] = e.target.value;
        } else if(e.target.value !== minus  && e.target.value !== internalOperation.value[internalOperation.value.length-1]) {
          internalOperation.value[internalOperation.value.length-1] = e.target.value;
        }
      } else {
        internalOperation.value.push(e.target.value);
      }
    }
    } else {
    if (e.target.value == percentage) {
      if (internalOperation.value.length > 0 && internalOperation.value[internalOperation.value.length-1] !== percentage && !Object.values(operatorsList).includes(internalOperation.value[internalOperation.value.length-1])) {
        internalOperation.value.push(e.target.value);  
      }
    } else {
      internalOperation.value.push(e.target.value);
    }
  }
}

const removeLastItem = () => {
  internalOperation.value.pop()
}

const removeItems = () => {
  screenOperation.value = "";
  screenResult.value = "";
  internalOperation.value.length = 0;
}

const resultEqual = () => {
  if (screenResult.value == "") {
    //pass
  } else {
    internalOperation.value.length = 0;
    console.log(typeof(screenResult.value))
    for(let i = 0; i < screenResult.value.toString().length; i++) {
      internalOperation.value.push(screenResult.value.toString()[i])
    }
    screenResult.value = "";
  }
    
}
const plusMinusFunction = () => {
  let counter = 0;
  for (let i = 0; i < internalOperation.value.length; i++) {
    if (Object.values(operatorsList).includes(internalOperation.value[i])) {
      counter += 1
      break;
    }
  }
  if (counter == 0) {
    internalOperation.value.unshift("-");
  }
  if (counter == 1 && internalOperation.value[0] == minus) {
    internalOperation.value.shift();
  }
}

</script>

<style>

body {
  box-sizing: border-box;
  margin: 0;
  padding: 0;
  font-size: 62.5%;
}
.header {
  height: 15vh;
  display: flex;
  justify-content: center;
  align-items: center;
}
.header-dark-mode {
  background-color: #22252d;
}
.header-light-mode {
  background-color: #fff;
}
.modes-container {
  display: flex;
  width: auto;
  height: auto;
}
.mode-button-left {
  border-top-left-radius: 12px;
  border-bottom-left-radius: 12px;
}
.mode-button-right {
  border-top-right-radius: 12px;
  border-bottom-right-radius: 12px;
}
.dark-button-on {
  background-color: #31353f;
  color: #555860;
}
.light-button-on {
  background-color: #f9f9f9;
  color: #e3e3e3
}
.calculation {
  width: 100%;
  height: 25vh;
  display: flex;
  flex-direction: column;
  justify-content: center;
  align-items: center;
}
.calculation-dark-mode {
  background-color: #22252d;
}
.calculation-light-mode {
  background-color: #ffffff;
}
.main-operation-container {
  height: 45%;
  width: 85%;
  display: flex;
  flex-direction: row-reverse;
  align-items: center;
  overflow-x: auto;
  white-space: nowrap;
  overscroll-behavior-inline: contain;
}
.main-operation-container::-webkit-scrollbar {
  display: none;
}
.main-operation {
  display: flex;
  justify-content: flex-end;
  font-size: 3rem;
}
.main-operation-letter-dark {
  color: #ffffff;
}
.main-operation-letter-light {
  color: #2e323b;
}
.pointer {
  display: flex;
  justify-content: flex-end;
  width: 8px;
  font-size: 3.5rem;
  color: rgb(119, 119, 216);
}
.pointer-not-visible {
  opacity: 0;
}
.result-operation-container {
  height: 40%;
  width: 85%;
  display: flex;
  flex-direction: column;
  padding: 5px;
  white-space: nowrap;
}
.result-operation {
  height: 45%;
  display: flex;
  justify-content: flex-end;
  align-items: center;
  font-size: 1.8rem;
}
.result-operation-letter-dark {
  color: #9d9ea2;
}
.result-operation-letter-light {
  color: #4d525f;
}
.general-buttons-dark {
  background-color: #22252d;
}
.general-buttons-light {
  background-color: #ffffff;
}
.buttons-container {
  box-sizing: border-box;
  padding: 25px 15px 40px 15px;
  width: 100%;
  height: 60vh;
  display: grid;
  justify-items: center;
  grid-template-columns: repeat(4, 1fr);
  gap: 5px;
  border-top-left-radius: 30px;
  border-top-right-radius: 30px;  
}
.buttons-background-dark {
  background-color: #31353f;
}
.buttons-background-light {
  background-color: #f9f9f9;
}
.main-button:active {
  background-color: #474a52;
}
</style>
