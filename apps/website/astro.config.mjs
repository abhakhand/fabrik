// @ts-check
import { defineConfig } from "astro/config";
import starlight from "@astrojs/starlight";
import sitemap from "@astrojs/sitemap";

import tailwindcss from "@tailwindcss/vite";

// const locales = {
//   root: { label: "English", lang: "en" },
//   hi: { label: "हिन्दी", lang: "hi" },
//   es: { label: "Español", lang: "es" },
// };

// https://astro.build/config
export default defineConfig({
  // Required for canonical URLs, og:url, and the sitemap. Without it Astro
  // emits empty <link rel="canonical"> and <meta property="og:url"> tags and
  // skips sitemap generation entirely.
  //
  // This must match the host that actually serves the site — if both the
  // apex and www resolve, redirect one to the other so ranking signals are
  // not split across two origins.
  site: "https://www.fabriktool.com",

  integrations: [
    starlight({
      title: "Fabrik",
      tagline: "The clean Flutter toolkit.",
      description:
        "Fabrik is a Flutter toolkit of six independent packages for theming, responsive layout, form validation, snackbars, and typed error handling.",
      // `favicon` is resolved against `public/`, not `src/`. Pointing it at a
      // source path works in dev — where Astro can still serve out of `src/` —
      // but emits a dead `/./src/assets/…` URL in the production build.
      favicon: "/favicon.svg",
      // `logo` is different: it goes through Astro's asset pipeline and is
      // correctly given a source path.
      logo: { src: "./src/assets/logo.svg" },
      // locales,
      customCss: ["./src/styles/global.css"],
      head: [
        // Social preview card, used when a link is shared to Twitter, Slack,
        // Discord, and similar. Starlight sets og:title and og:description but
        // no image, which leaves shared links looking bare.
        {
          tag: "meta",
          attrs: {
            property: "og:image",
            content: "https://www.fabriktool.com/og.png",
          },
        },
        {
          tag: "meta",
          attrs: {
            name: "twitter:image",
            content: "https://www.fabriktool.com/og.png",
          },
        },
        // Structured data. Tells search engines this is developer
        // documentation for a named software library rather than a generic
        // marketing page.
        {
          tag: "script",
          attrs: { type: "application/ld+json" },
          content: JSON.stringify({
            "@context": "https://schema.org",
            "@type": "SoftwareApplication",
            name: "Fabrik",
            applicationCategory: "DeveloperApplication",
            operatingSystem: "Android, iOS, Web, macOS, Windows, Linux",
            description:
              "A Flutter toolkit of six independent packages for theming, responsive layout, form validation, snackbars, utilities, and typed error handling.",
            url: "https://www.fabriktool.com",
            author: {
              "@type": "Person",
              name: "Ashish Bhakhand",
              url: "https://github.com/abhakhand",
            },
            license: "https://github.com/abhakhand/fabrik/blob/main/LICENSE",
            codeRepository: "https://github.com/abhakhand/fabrik",
            programmingLanguage: "Dart",
            offers: {
              "@type": "Offer",
              price: "0",
              priceCurrency: "USD",
            },
          }),
        },
      ],
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
    sitemap(),
  ],

  vite: {
    plugins: [tailwindcss()],
  },
});
