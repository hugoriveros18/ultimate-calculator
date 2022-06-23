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
    height: 65px;
    width: 65px;
    font-size: 30px;
    border-radius: 12px;
    border: none;
}
.color-dark {
    color: #df8386;
    background-color: #272b33;
}
.color-dark:active {
    background-color: #434953;
}
.color-light {
    color: #eb6565;
    background-color: #f3f3f3;
}
.color-light:active {
    background-color: #e7e7e7;
}
</style>