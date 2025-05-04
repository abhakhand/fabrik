// @ts-check
import { defineConfig } from "astro/config";
import starlight from "@astrojs/starlight";

// const locales = {
//   root: { label: "English", lang: "en" },
//   hi: { label: "हिन्दी", lang: "hi" },
//   es: { label: "Español", lang: "es" },
// };

// https://astro.build/config
export default defineConfig({
  integrations: [
    starlight({
      title: "Fabrik Docs",
      // locales,
      customCss: ["./src/styles/theme.css"],
      social: [
        {
          icon: "github",
          label: "GitHub",
          href: "https://github.com/abhakhand/fabrik",
        },
      ],
      sidebar: [
        {
          label: "Introduction",
          items: [
            { label: "Fabrik", slug: "introduction" },
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
            { label: "fabrik_snackbar", slug: "packages/fabrik_snackbar" },
          ],
        },
      ],
    }),
  ],
});
