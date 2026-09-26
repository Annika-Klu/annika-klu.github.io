# Builds the site including the public CV and serves it with nginx.
#   docker build -t annika-klu .
#   docker run --rm -p 8080:80 annika-klu

# Official Typst image, only used as a source for the binary.
# Keep the version in sync with .github/workflows/deploy-build.yml.
FROM ghcr.io/typst/typst:0.15.1 AS typst

FROM node:22-alpine AS build
COPY --from=typst /bin/typst /usr/local/bin/typst
WORKDIR /app
COPY package.json package-lock.json ./
RUN npm ci
COPY . .
RUN npm run cv:en && npm run build

FROM nginx:alpine
COPY --from=build /app/dist /usr/share/nginx/html
EXPOSE 80
