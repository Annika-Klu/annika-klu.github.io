<script setup>
import { useRoute, RouterLink } from "vue-router";
import { ref } from "vue";

const route = useRoute();
const hideHeader = ref(false);
window.onscroll = () => hideHeader.value = window.scrollY > 10;
</script>

<template>
    <header>
    <nav :class="{ scrolled: hideHeader }">
      <a href="https://github.com/annika-klu" target="blank" class="line top" :class="{ dark: route.path !== '/' }">
        <img src="https://github.com/favicon.ico" class="github-logo" alt="github icon" />
      </a>
      <RouterLink v-if="route.path !== '/'" class="line top dark" to="/">home</RouterLink>
      <RouterLink v-else class="line top" to="/about">about</RouterLink>
      <!-- <RouterLink class="line top" to="/contact">contact</RouterLink> -->
    </nav>
  </header>
</template>

<style scoped>
header {
  width: 100%;
  height: 4rem;
  top: 0;
  position: fixed;
  z-index: 9999;
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

.github-logo {
  height: 1rem;
  opacity: .6;
  padding-top: .2rem;
}

@media only screen and (min-width: 800px) {
  nav {
    font-size: 1.2rem;
    margin: 2rem 4rem;
  }

  .github-logo {
    height: 1.2rem;
  }
}

.github-logo:hover {
  opacity: 1;
}

nav.scrolled {
  visibility: hidden;
}

header:hover nav {
  visibility: visible;
}
</style>