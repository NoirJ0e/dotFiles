-- In your AstroNvim plugins config
return {
  {
    "folke/snacks.nvim",
    priority = 1000,
    lazy = false,
    opts = {
      -- Enable animations globally
      animate = {
        enabled = true,
        fps = 60,
        easing = "outQuad",
      },

      -- Smooth scrolling
      scroll = {
        enabled = true,
        animate = {
          duration = { step = 15, total = 250 },
        },
      },

      -- Animated indent lines
      indent = {
        enabled = true,
        animate = {
          enabled = true,
          style = "out",
          easing = "linear",
          duration = {
            step = 20,
            total = 500,
          },
        },
      },

      -- Smooth notifications
      notifier = {
        enabled = true,
        timeout = 3000,
      },

      -- Dashboard animations
      dashboard = { enabled = true },

      -- Window animations
      win = { enabled = true },
    },
  },
}
