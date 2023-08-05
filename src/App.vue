<script setup>
import { RouterView } from "vue-router";
import BaseHeader from "./components/BaseHeader.vue";
</script>

<template>
  <BaseHeader />
  <RouterView />
</template>

<style scoped>
header {
  width: 100%;
  height: 4rem;
  top: 0;
  position: fixed;
  background: transparent;
}

nav {
  margin: 2rem;
  display: flex;
  align-items: center;
  color: var(--grey);
  justify-content: flex-end;
  gap: 1.5rem;
}

@media only screen and (min-width: 1000px) {
  nav {
    margin: 2rem 4rem;
  }
}

.github-logo {
  height: 1rem;
  opacity: .6;
}

.github-logo:hover {
  opacity: 1;
}

nav.scrolled {
  visibility: hidden;
}

header:hover nav {
  visibility: visible
}
</style>
