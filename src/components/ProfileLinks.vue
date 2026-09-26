<script setup>
const showGithubLink = import.meta.env.VITE_HIDE_GITHUB_LINK !== "true"

const links = [
  ...(showGithubLink ? [{ label: "GitHub", href: "https://github.com/annika-klu" }] : []),
  { label: "XING", href: "https://www.xing.com/profile/Annika_Kluepfel" },
  { label: "CV", href: `${import.meta.env.BASE_URL}cv.pdf` }
]
</script>

<template>
  <div class="links">
    <a
      v-for="link in links"
      :key="link.href"
      :href="link.href"
      target="_blank"
      rel="noopener noreferrer"
    >
      {{ link.label }}
      <span class="sr-only"> (opens in new tab)</span>
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

.sr-only {
  position: absolute;
  width: 1px;
  height: 1px;
  padding: 0;
  margin: -1px;
  overflow: hidden;
  clip: rect(0, 0, 0, 0);
  white-space: nowrap;
  border: 0;
}
</style>
