<script setup>
import { RouterLink, RouterView } from "vue-router";
</script>

<template>
  <header>
      <nav>
        <RouterLink to="/">Home</RouterLink>
        <RouterLink to="/about">About</RouterLink>
      </nav>
  </header>

  <RouterView />
</template>

<style scoped>
header nav {
  width: 100%;
  display: flex;
  justify-content: flex-end;
  gap: 2rem;
}
</style>
