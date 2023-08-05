<script setup>
defineProps({
  project: {
    type: Object,
    required: true
  }
})
</script>

<template>
  <div class="project">
    <a :href="project.githubUrl" class="github-logo" target="blank">
      <img src="https://github.com/favicon.ico" />
    </a>
    <div class="text">
      <h2>{{ project.title }}</h2>
      <p v-if="project.technologies.length" class="technologies">
        {{ project.technologies.join(" | ") }}
      </p>
      <p class="description">{{ project.description }}</p>
    </div>
    <a v-if="project.liveUrl" class="preview" :href="project.liveUrl" target="blank">
      <img :src="project.imgSrc" />
    </a>
    <div v-else class="preview">
      <img :src="project.imgSrc" />
    </div>
  </div>
</template>

<style scoped>
.project {
  padding: 1rem;
  display: flex;
  flex-direction: column;
  position: relative;
  justify-content: space-between;
  width: 100%;
  max-width: 35rem;
  gap: 1rem;
  filter: saturate(0);
  -webkit-filter: saturate(0);
  backdrop-filter: blur(10px);
  -webkit-backdrop-filter: blur(10px);
  background-color: rgba(255, 255, 255, 0.2);
}

@media only screen and (min-width: 800px) {
  .project {
    padding: 1.5rem;
  }
}

@media (orientation: landscape) {
  .project {
    width: 50rem;
  }

  @media  (max-width: 1000px) {

  .project {
    width: max-content;
  }
  

  .project .preview img {
    width: auto;
    max-height: 10rem;
    object-fit: cover;
  }
}
}

.project:hover {
  filter: saturate(1);
  -webkit-filter: saturate(1);
  -webkit-box-shadow: 3px 3px 10px 2px rgba(0, 0, 0, 0.2);
  box-shadow: 3px 3px 10px 2px rgba(0, 0, 0, 0.2);
}

.github-logo {
  position: absolute;
  right: 1.5rem;
  filter: invert(60%);
  -webkit-filter: invert(60%);
}

.github-logo:hover {
  filter: invert(0);
  -webkit-filter: invert(0);
}
.github-logo img {
  width: 1rem;
}


.project .text {
  margin-top: 1rem;
  display: flex;
  flex-direction: column;
  gap: 0.5rem;
}

.project .text .technologies {
  opacity: 0.4;
}

.project .text *:not(.description) {
  text-align: center;
}

.project .preview {
  width: 100%;
  display: flex;
  justify-content: center;
}

.project .preview img {
  max-width: 15rem;
  height: auto;
  object-fit: cover;
}

@media screen and (max-width: 900px) {
  .project {
    padding: .5rem;
  }
  .project .text h2 {
    font-size: 1.5rem;
  }
}
</style>
