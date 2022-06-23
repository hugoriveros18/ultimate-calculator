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
    font-size: 20px;
    border-radius: 12px;
    border: none;
}
.color-dark {
    color: #4ad9c5;
    background-color: #272b33;
}
.color-dark:active {
    background-color: #434953;
}

.color-light {
    color: #4ad9c5;
    background-color: #f3f3f3;
}
.color-light:active {
    background-color: #e7e7e7;
}
</style>
