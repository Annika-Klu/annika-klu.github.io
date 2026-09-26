# Annika Kluepfel | Full-Stack Software Developer

Welcome! This is my personal website, built with Vue and Vite:
**[annika-klu.github.io](https://annika-klu.github.io/)**

You'll also find my CV there as a PDF: **[annika-klu.github.io/cv.pdf](https://annika-klu.github.io/cv.pdf)**

## CV as code

The CV is written in YAML ([`cv/cv.yml`](cv/cv.yml)) and typeset with
[Typst](https://typst.app) ([`cv/cv.typ`](cv/cv.typ)). The deploy workflow
generates the PDF on every build, so the published CV always matches the data.
I also use this setup to maintain my CV locally, e.g. a version in German or with more details for direct applications.

Requires the [Typst CLI](https://github.com/typst/typst) (`winget install --id Typst.Typst`).

| Command | Output |
| --- | --- |
| `npm run cv:en` | `public/cv.pdf` (public, English, served by the site) |
| `npm run cv:de` | `cv/cv-de.pdf` (public, German) |
| `npm run cv:en:private` / `cv:de:private` | `cv/cv-*-private.pdf`, adds address, phone and photo from the gitignored `cv/private.yml` (see [`cv/private.example.yml`](cv/private.example.yml)) |

## Development

```sh
npm install
npm run cv:en   # optional, so /cv.pdf works locally
npm run dev
```
