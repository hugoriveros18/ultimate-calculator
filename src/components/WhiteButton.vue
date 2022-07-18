<template>
    <button type="button" :class="{'color-dark':props.colorMode,'color-light':!props.colorMode}"></button>
</template>

<script setup>
import { defineProps } from "vue";

const props = defineProps({
    colorMode: Boolean
})

</script>

<style scoped>
button {
    display: flex;
    justify-content: center;
    align-items: center;
    width: 18vw;
    height: 9vh;
    font-size: 4vh;
    border-radius: 12px;
    border: none;
}
button:hover {
    cursor: pointer;
}
.color-dark {
    color: #e3e5e9;
    background-color: #272b33;
}
.color-dark:active {
    background-color: #434953;
}
.color-light {
    color: #2f333c;
    background-color: #f3f3f3;
}
.color-light:active {
    background-color: #e7e7e7;
}

@media screen and (min-width: 768px) {
    button {
        font-size: 5.5vh;
    }
}
@media screen and (min-width: 1024px) {
    button {
        width: 10vw;
    }
}
</style>