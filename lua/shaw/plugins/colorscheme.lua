return {

  {
    'loctvl842/monokai-pro.nvim',
    priority = 1000,
    config = function()
      require('monokai-pro').setup {
        -- transparent_background = true,
        filter = 'octagon',
        -- terminal_colors = true,
        -- devicons = true, -- highlight the icons of `nvim-web-devicons`
      }
      vim.cmd.colorscheme 'monokai-pro'
    end,
  },

  { -- You can easily change to a different colorscheme.
    -- Change the name of the colorscheme plugin below, and then
    -- change the command in the config to whatever the name of that colorscheme is.
    --
    -- If you want to see what colorschemes are already installed, you can use `:Telescope colorscheme`.
    'folke/tokyonight.nvim',
    -- priority = 1000, -- Make sure to load this before all the other start plugins.
    -- init = function()
    --   -- Load the colorscheme here.
    --   -- Like many other themes, this one has different styles, and you could load
    --   -- any other, such as 'tokyonight-storm', 'tokyonight-moon', or 'tokyonight-day'.
    --   vim.cmd.colorscheme 'tokyonight-night'

    --   -- You can configure highlights by doing something like:
    --   vim.cmd.hi 'Comment gui=none'
    -- end,
  },

  {
    'rose-pine/neovim',
    name = 'rose-pine',
    priority = 1000,
    init = function()
      -- Load the colorscheme here.
      require('rose-pine').setup {}

      -- vim.cmd 'colorscheme rose-pine'
      -- vim.cmd 'colorscheme rose-pine-main'
      -- vim.cmd 'colorscheme rose-pine-moon'
      -- vim.cmd 'colorscheme rose-pine-dawn'
      -- vim.cmd.colorscheme 'rose-pine'
      -- vim.cmd.hi 'Comment gui=none'
    end,
  },

  {
    'rebelot/kanagawa.nvim',
    priority = 1000,
    init = function()
      -- Default options:
      -- require('kanagawa').setup {
      --   compile = false, -- enable compiling the colorscheme
      --   undercurl = true, -- enable undercurls
      --   commentStyle = { italic = true },
      --   functionStyle = {},
      --   keywordStyle = { italic = true },
      --   statementStyle = { bold = true },
      --   typeStyle = {},
      --   transparent = false, -- do not set background color
      --   dimInactive = false, -- dim inactive window `:h hl-NormalNC`
      --   terminalColors = true, -- define vim.g.terminal_color_{0,17}
      --   colors = { -- add/modify theme and palette colors
      --     palette = {},
      --     theme = { wave = {}, lotus = {}, dragon = {}, all = {} },
      --   },
      --   overrides = function(colors) -- add/modify highlights
      --     return {}
      --   end,
      --   theme = 'wave', -- Load "wave" theme when 'background' option is not set
      --   background = { -- map the value of 'background' option to a theme
      --     dark = 'wave', -- try "dragon" !
      --     light = 'lotus',
      --   },
      -- }

      -- setup must be called before loading
      -- vim.cmd 'colorscheme kanagawa'
    end,
  },
}
