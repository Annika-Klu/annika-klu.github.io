<script setup>
import BasePage from "../components/BasePage.vue";
import GoUp from "../components/GoUp.vue";
import ProjectGallery from "../components/ProjectGallery.vue";
</script>

<template>
  <BasePage grayscale id="landing">
    <div class="intro">
      <p>Annika.</p>
      <h1>Data loving developer.</h1>
      <a href="#project-section" class="line bottom landing-link">projects</a>
    </div>
  </BasePage>
  <BasePage id="project-section">
    <ProjectGallery />
    <GoUp id="go-up"/>
  </BasePage>
</template>

<style scoped>
#project-section {
  position: relative;
}

  
@media (orientation: landscape) and (max-width: 800px) {
  #project-section {
    position: relative;
    padding: 0
  }

  .intro {
    margin-top: 0;
    margin-left: 2rem;
  }
}
 
.intro {
  color: var(--white-smoke);
  max-width: 45rem;
  margin-top: 2rem;
  display: flex;
  flex-direction: column;
  gap: 0.5rem;
}

.intro p {
  font-size: clamp(1.8rem, 2.2rem, 2.7rem);
}
.intro h1 {
  color: var(--primary);
  font-size: clamp(3rem, 4rem, 4rem);
}

@media (max-width: 350px) and (orientation: portrait) {
  .intro h1 {
    font-size: 3.5rem;
  }
}

a:not(#go-up) {
  color: var(--white);
  margin-top: 1rem;
  max-width: 10rem;
  font-size: clamp(1.5rem, 2rem, 2.5rem);
  border: 2px solid var(--primary);
  background: transparent;
  padding: .5rem 1rem .7rem 1rem;
}
</style>
