return {
  {
    "bjarneo/aether.nvim",
    branch = "v3",
    name = "aether",
    priority = 1000,
    opts = {
      colors = {
        bg = "#0B0E20",
        dark_bg = "#080A1A",
        darker_bg = "#05060F",
        lighter_bg = "#171B38",

        fg = "#DCD4BC",
        dark_fg = "#A6A28E",
        light_fg = "#EDE6D2",
        bright_fg = "#FBFBF4",
        muted = "#7B7DB4",

        red = "#C85234",
        yellow = "#E6B14A",
        orange = "#E07B2C",
        green = "#8CAE3E",
        cyan = "#7FA3DC",
        blue = "#6E72C6",
        magenta = "#8B67C0",
        -- Aether keys Keyword off purple, and only newer aether.nvim builds
        -- alias magenta->purple. Set purple explicitly so keywords never
        -- fall back to the plugin's stock violet.
        purple = "#8B67C0",
        brown = "#8A4A2A",

        bright_red = "#E4703F",
        bright_yellow = "#F6D26C",
        bright_green = "#BFD45C",
        bright_cyan = "#A5C4F0",
        bright_blue = "#8A8EDE",
        bright_magenta = "#AC8AE0",
        bright_purple = "#AC8AE0",

        accent = "#A8BE4A",
        cursor = "#F6D26C",
        foreground = "#DCD4BC",
        background = "#0B0E20",
        selection = "#272B5E",
        selection_foreground = "#FBFBF4",
        selection_background = "#272B5E",
      },
    },
  },
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "aether",
    },
  },
}
