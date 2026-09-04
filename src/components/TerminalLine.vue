<script setup>
defineProps({
  prefix: {
    type: String,
    default: "$"
  }
})
</script>

<template>
  <div class="terminal">
    {{ prefix }} <slot />
  </div>
</template>

<style scoped>
.terminal {
  font-family: "JetBrains Mono", monospace;
  font-size: 0.9rem;
  color: rgba(244, 247, 251, 0.5);
}
</style>
