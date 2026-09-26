<script setup>
import TerminalLine from "./TerminalLine.vue"
import ProfileLinks from "./ProfileLinks.vue"

const showGithubLink = import.meta.env.VITE_HIDE_GITHUB_LINK !== "true"

const links = [
  ...(showGithubLink ? [{ label: "GitHub", href: "https://github.com/annika-klu" }] : []),
  { label: "XING", href: "https://www.xing.com/profile/Annika_Kluepfel" },
  { label: "CV", href: `${import.meta.env.BASE_URL}cv.pdf` }
]
</script>

<template>
  <main class="card">
    <TerminalLine prefix="$">whoami</TerminalLine>

    <h1>Annika Kl&uuml;pfel</h1>

    <div class="role">Full-Stack Web Developer</div>

    <p>
      Frontend is where I started – Vue is my framework of choice. My real passion, however, lies
      beneath the surface: databases, APIs, automation, and the systems that keep applications
      running.
    </p>

    <p>Currently exploring Linux and networking by building a small homelab.</p>

    <TerminalLine prefix="&gt;">vue · react · python · sql · docker</TerminalLine>

    <ProfileLinks :links="links" />
  </main>
</template>

<style scoped>
.card {
  width: min(90vw, 43rem);

  padding: 3rem;

  background: var(--glass);
  backdrop-filter: blur(1.5rem);
  -webkit-backdrop-filter: blur(1.5rem);

  border: 1px solid var(--border);
  border-radius: 1.75rem;

  box-shadow: 0 1.5625rem 5rem rgba(0, 0, 0, 0.35);
}

.card :deep(.terminal) {
  margin-bottom: 2rem;
}

h1 {
  margin: 0 0 0.75rem;
  font-size: clamp(2.4rem, 8vw, 3.4rem);
  font-weight: 700;
  letter-spacing: -0.04em;
}

.role {
  font-size: 1.2rem;
  color: var(--accent);
  margin-bottom: 1.75rem;
}

p {
  color: var(--muted);
  line-height: 1.7;
  margin-bottom: 1.75rem;
}

@media (max-width: 37.5rem) {
  .card {
    padding: 2rem;
  }
}
</style>
