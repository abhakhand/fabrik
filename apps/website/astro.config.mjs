// @ts-check
import { defineConfig } from "astro/config";
import starlight from "@astrojs/starlight";

// https://astro.build/config
export default defineConfig({
  integrations: [
    starlight({
      title: "Fabrik Docs",
      social: [
        {
          icon: "github",
          label: "GitHub",
          href: "https://github.com/withastro/starlight",
        },
      ],
      sidebar: [
        {
          label: "Introduction",
          items: [{ label: "Welcome to Fabrik", slug: "index" }],
        },
        {
          label: "CLI",
          items: [
            { label: "Overview", slug: "cli" },
            { label: "Commands", slug: "cli/commands" },
          ],
        },
        {
          label: "Packages",
          items: [
            { label: "fabrik_snackbar", slug: "packages/fabrik_snackbar" },
          ],
        },
      ],
    }),
  ],
});
