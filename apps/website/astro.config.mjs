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
      favicon: "./src/assets/logo.svg",
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
          label: "Fabrik",
          items: [
            { label: "Introduction", slug: "introduction" },
            {
              label: "Architecture",
              slug: "introduction/architecture",
            },
          ],
        },
        {
          label: "CLI",
          items: [
            { label: "Fabrik CLI", slug: "cli" },
            {
              label: "Installation & Usage",
              slug: "cli/cli-installation-and-usage",
            },
          ],
        },
        {
          label: "Packages",
          badge: { text: "new" },
          items: [
            { label: "fabrik_theme", slug: "packages/fabrik_theme" },
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
