<template>
    <button type="button">
        <span class="material-icons" :class="{'color-dark':props.colorMode,'color-light':props.colorMode2}">{{ props.Mode }}</span>
    </button>
</template>

<script setup>
import { defineProps } from "vue";

const props = defineProps({
    Mode: String,
    colorMode: Boolean,
    colorMode2: Boolean
})

</script>

<style scoped>
button {
    display: flex;
    justify-content: center;
    align-items: center;
    height: 40px;
    width: 50px;
    border: none;
    padding: 0;
}
button:hover {
    cursor: pointer;
}
.color-dark {
    color: #e2e3e5;
}
.color-light {
    color: #43464e
}
</style>