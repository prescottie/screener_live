module.exports = {
  theme: {
    extend: {
      colors: {
        emerald: '#39DB8E',
        'emerald-light': '#75e6af',
        'emerald-dark': '#20ac68',
        'charcoal-light': "#495C6E",
        charcoal: '#323f4b',
        'charcoal-dark': "#1f252b",
        dsb: "#83B9C0", // DARK SKY BLUE
        'dsb-dark': "#3E737A",
        brown: "#81765d",
        ghost: "#F5F3F7",
      }
    }
  },
  purge: {
    enabled: process.env.MIX_ENV === "prod",
    content: [
      "../lib/**/*.eex",
      "../lib/**/*.leex",
      "../lib/**/*_view.ex"
    ],
    options: {
      whitelist: [/phx/, /nprogress/]
    }
  },
  plugins: [require("kutty")]
}
