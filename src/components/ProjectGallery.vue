<script setup>
import { onMounted } from "vue"
import useHorizontalScroll from "../composables/useHorizontalScroll.js"
import ProjectCard from "../components/ProjectCard.vue"
import projects from "../assets/data/projects.json"

const { xScrollable, horizontalScroll } = useHorizontalScroll()
onMounted(() => {
  if (horizontalScroll.ignore.value) return
  else horizontalScroll.set()
})
</script>

<template>
  <div class="projects-wrapper" ref="xScrollable" @wheel="horizontalScroll.use">
    <ProjectCard v-for="project in projects" :key="project.id" :project="project" />
  </div>
</template>

<style scoped>
.projects-wrapper {
  height: 100%;
  width: 100%;
  display: inherit;
  gap: 2rem;
  padding: 50% 0;
  overflow-y: auto;
  mask-image: linear-gradient(
    to bottom,
    transparent,
    rgba(0, 0, 0, 1),
    rgba(0, 0, 0, 1),
    rgba(0, 0, 0, 1),
    transparent
  );
  -webkit-mask-image: linear-gradient(
    to bottom,
    transparent,
    rgba(0, 0, 0, 1),
    rgba(0, 0, 0, 1),
    rgba(0, 0, 0, 1),
    transparent
  );
  -ms-overflow-style: none;
  scrollbar-width: none;
  overscroll-behavior: contain;
}

.projects-wrapper::-webkit-scrollbar {
  display: none;
}

@media (orientation: landscape) {
  .projects-wrapper {
    grid-auto-flow: column;
    grid-auto-columns: min-content;
    gap: 3rem;   
    overflow-x: auto;
    overflow-y: hidden;
    padding: 0 30%;
    mask-image: linear-gradient(
      to left,
      transparent,
      rgba(0, 0, 0, 1),
      rgba(0, 0, 0, 1),
      rgba(0, 0, 0, 1),
      transparent
    );
    -webkit-mask-image: linear-gradient(
      to left,
      transparent,
      rgba(0, 0, 0, 1),
      rgba(0, 0, 0, 1),
      rgba(0, 0, 0, 1),
      transparent
    );
  }
}
</style>
