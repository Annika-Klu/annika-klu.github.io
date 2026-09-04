<script setup>
defineProps({
  links: {
    type: Array,
    required: true
  }
})
</script>

<template>
  <div class="links">
    <a v-for="link in links" :key="link.href" :href="link.href" target="_blank">
      {{ link.label }}
    </a>
  </div>
</template>

<style scoped>
.links {
  display: flex;
  gap: 0.75rem;
  flex-wrap: wrap;
}

a::before {
  content: "[ ";
}

a::after {
  content: " ]";
}
</style>
