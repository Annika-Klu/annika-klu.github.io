<script setup>
defineProps({
  grayscale: {
    type: Boolean,
    default: false
  }
})
</script>

<template>
  <section :class="{grayscale: grayscale}">
    <slot />
  </section>
</template>

<style scoped>
/* Image by Martin Péchy on pexels.com */
/* https://images.pexels.com/photos/304664/pexels-photo-304664.jpeg */

section {
  height: 100%;
  width: 100%;
  padding: 1.5rem;
  background: url("https://iili.io/HZzsS7p.jpg"), rgba(153, 250, 230,.7);
  background-blend-mode: overlay;
  background-position: center;
  background-size: cover;
  background-repeat: no-repeat;
  display: grid;
  place-content: center;
  overflow: hidden;
}

@media only screen and (min-width: 1000px) {
  section {
    padding: 2rem 4rem;
  }
}

.grayscale {
  background-blend-mode: normal;
}
</style>
