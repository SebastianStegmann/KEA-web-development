/** @type {import('tailwindcss').Config} */
module.exports = {
  content: ["../views/*.php"],
  theme: {
    extend: {
      fontFamily: {
        'roboto': ['Roboto', 'sans-serif'],
      },
      colors: {
        bkg: {          
          1: "hsl(var(--color-bkg-1) / <alpha-value> )",
          2: "hsl(var(--color-bkg-2) / <alpha-value> )",
        },
        text: "hsl(var(--color-text) / <alpha-value> )",
        border: "hsl(var(--color-border) / <alpha-value> )",
        button_bg: "hsl(var(--color-button-bg) / <alpha-value> )",
        button_bg_hover: "hsl(var(--color-button-bg-hover) / <alpha-value> )",
        button_text_hover: "hsl(var(--color-button-text-hover) / <alpha-value> )",
      }      
    },
  },
  plugins: [],
}

