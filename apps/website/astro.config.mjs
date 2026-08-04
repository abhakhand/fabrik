// @ts-check
import { defineConfig } from "astro/config";
import starlight from "@astrojs/starlight";

import tailwindcss from "@tailwindcss/vite";

// const locales = {
//   root: { label: "English", lang: "en" },
//   hi: { label: "हिन्दी", lang: "hi" },
//   es: { label: "Español", lang: "es" },
// };

// https://astro.build/config
export default defineConfig({
  integrations: [
    starlight({
      title: "Fabrik",
      tagline: "The clean Flutter toolkit.",
      description:
        "The Flutter toolkit for clean architecture, fast development, and scalable apps.",
      // `favicon` is resolved against `public/`, not `src/`. Pointing it at a
      // source path works in dev — where Astro can still serve out of `src/` —
      // but emits a dead `/./src/assets/…` URL in the production build.
      favicon: "/favicon.svg",
      // `logo` is different: it goes through Astro's asset pipeline and is
      // correctly given a source path.
      logo: { src: "./src/assets/logo.svg" },
      // locales,
      customCss: ["./src/styles/global.css"],
      social: [
        {
          icon: "github",
          label: "GitHub",
          href: "https://github.com/abhakhand/fabrik",
        },
      ],
      sidebar: [
        {
          label: "Getting started",
          items: [
            { label: "Introduction", slug: "introduction" },
            { label: "Choosing a package", slug: "choosing-a-package" },
            { label: "Core concepts", slug: "core-concepts" },
          ],
        },
        {
          label: "Packages",
          items: [
            { label: "fabrik_theme", slug: "packages/fabrik_theme" },
            { label: "fabrik_layout", slug: "packages/fabrik_layout" },
            { label: "fabrik_forms", slug: "packages/fabrik_forms" },
            { label: "fabrik_snackbar", slug: "packages/fabrik_snackbar" },
            { label: "fabrik_utils", slug: "packages/fabrik_utils" },
            { label: "fabrik_result", slug: "packages/fabrik_result" },
          ],
        },
      ],
    }),
  ],

  vite: {
    plugins: [tailwindcss()],
  },
});
