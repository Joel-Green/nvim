return {
  -- NOTE: Plugins can be added with a link (or for a github repo: 'owner/repo' link).
  'tpope/vim-sleuth', -- Detect tabstop and shiftwidth automatically
  'tpope/vim-fugitive',

  -- NOTE: Plugins can also be added by using a table,
  -- with the first argument being the link and the following
  -- keys can be used to configure plugin behavior/loading/etc.
  --
  -- Use `opts = {}` to force a plugin to be loaded.
  --
  --  This is equivalent to:
  --    require('Comment').setup({})

  -- "gc" to comment visual regions/lines
  -- 'tpope/vim-commentary',
  {
    'numToStr/Comment.nvim',
    lazy = false,
    config = function()
      require('Comment').setup {}
    end,
  },
  --
  -- Here is a more advanced example where we pass configuration
  -- options to `gitsigns.nvim`. This is equivalent to the following Lua:
  --    require('gitsigns').setup({ ... })
  --
  -- See `:help gitsigns` to understand what the configuration keys do
  { -- Adds git related signs to the gutter, as well as utilities for managing changes
    'lewis6991/gitsigns.nvim',
    opts = {
      signs = {
        add = { text = '+' },
        change = { text = '~' },
        delete = { text = '_' },
        topdelete = { text = '‾' },
        changedelete = { text = '~' },
      },
    },
  },

  -- NOTE: Plugins can also be configured to run Lua code when they are loaded.
  --
  -- This is often very useful to both group configuration, as well as handle
  -- lazy loading plugins that don't need to be loaded immediately at startup.
  --
  -- For example, in the following configuration, we use:
  --  event = 'VimEnter'
  --
  -- which loads which-key before all the UI elements are loaded. Events can be
  -- normal autocommands events (`:help autocmd-events`).
  --
  -- Then, because we use the `config` key, the configuration only runs
  -- after the plugin has been loaded:
  --  config = function() ... end

  { -- Useful plugin to show you pending keybinds.
    'folke/which-key.nvim',
    event = 'VimEnter', -- Sets the loading event to 'VimEnter'
    config = function() -- This is the function that runs, AFTER loading
      require('which-key').setup()

      -- Document existing key chains
      require('which-key').register {
        ['<leader>c'] = { name = '[C]ode', _ = 'which_key_ignore' },
        ['<leader>d'] = { name = '[D]ocument', _ = 'which_key_ignore' },
        ['<leader>r'] = { name = '[R]ename', _ = 'which_key_ignore' },
        ['<leader>s'] = { name = '[S]earch', _ = 'which_key_ignore' },
        ['<leader>w'] = { name = '[W]orkspace', _ = 'which_key_ignore' },
        ['<leader>x'] = { name = '[X] Trouble', _ = 'which_key_ignore' },
      }
    end,
  },

  -- NOTE: Plugins can specify dependencies.
  --
  -- The dependencies are proper plugin specifications as well - anything
  -- you do for a plugin at the top level, you can do for a dependency.
  --
  -- Use the `dependencies` key to specify the dependencies of a particular plugin

  { -- Autoformat
    'stevearc/conform.nvim',
    lazy = false,
    keys = {
      {
        '<leader>f',
        function()
          require('conform').format { async = true, lsp_fallback = true }
        end,
        mode = '',
        desc = '[F]ormat buffer',
      },
    },
    opts = {
      notify_on_error = false,
      format_on_save = function(bufnr)
        -- Disable "format_on_save lsp_fallback" for languages that don't
        -- have a well standardized coding style. You can add additional
        -- languages here or re-enable it for the disabled ones.
        local disable_filetypes = { c = true, cpp = true }
        return {
          timeout_ms = 500,
          lsp_fallback = not disable_filetypes[vim.bo[bufnr].filetype],
        }
      end,
      formatters_by_ft = {
        lua = { 'stylua' },
        -- Conform can also run multiple formatters sequentially
        -- python = { "isort", "black" },
        --
        -- You can use a sub-list to tell conform to run *until* a formatter
        -- is found.
        javascript = { { 'prettierd', 'prettier' } },
        typescript = { { 'prettierd', 'prettier' } },
        typescriptreact = { { 'prettierd', 'prettier' } },
        javascriptreact = { { 'prettierd', 'prettier' } },
      },
    },
  },

  {
    'chrisgrieser/nvim-spider',
    lazy = false,
    config = function() end,
  },

  -- Highlight todo, notes, etc in comments
  { 'folke/todo-comments.nvim', event = 'VimEnter', dependencies = { 'nvim-lua/plenary.nvim' }, opts = { signs = false } },

  { -- Collection of various small independent plugins/modules
    'echasnovski/mini.nvim',
    config = function()
      -- Better Around/Inside textobjects
      --
      -- Examples:
      --  - va)  - [V]isually select [A]round [)]paren
      --  - yinq - [Y]ank [I]nside [N]ext [']quote
      --  - ci'  - [C]hange [I]nside [']quote
      -- require('mini.ai').setup { n_lines = 500 }

      -- Add/delete/replace surroundings (brackets, quotes, etc.)
      --
      -- - saiw) - [S]urround [A]dd [I]nner [W]ord [)]Paren
      -- - sd'   - [S]urround [D]elete [']quotes
      -- - sr)'  - [S]urround [R]eplace [)] [']

      -- require('mini.files').setup()
      -- vim.keymap.set('n', '<leader>-', '<CMD>lua MiniFiles.open() <CR>', { desc = 'Open Mini Files' })
      -- vim.keymap.set('n', '<leader>_', '<CMD>lua MiniFiles.close() <CR>', { desc = 'Close Mini Files' })

      -- require('mini.surround').setup()

      -- -- Simple and easy statusline.
      -- --  You could remove this setup call if you don't like it,
      -- --  and try some other statusline plugin
      -- local statusline = require 'mini.statusline'
      -- -- set use_icons to true if you have a Nerd Font
      -- statusline.setup {
      --   use_icons = vim.g.have_nerd_font,
      --   content = {
      --     active = function()
      --       local mode, mode_hl = MiniStatusline.section_mode { trunc_width = 120 }
      --       -- local git = MiniStatusline.section_git { trunc_width = 75 }
      --       local diagnostics = MiniStatusline.section_diagnostics { trunc_width = 75 }
      --       local filename = MiniStatusline.section_filename { trunc_width = 140 }
      --       local fileinfo = MiniStatusline.section_fileinfo { trunc_width = 120 }
      --       local location = MiniStatusline.section_location { trunc_width = 75 }
      --       local search = MiniStatusline.section_searchcount { trunc_width = 75 }
      --       -- hack to make the monokai pro work
      --       -- if mode_hl == 'MiniStatuslineModeNormal' then
      --       --   mode_hl = 'MiniStatuslineModeVisual'
      --       -- end
      --
      --       return MiniStatusline.combine_groups {
      --         { hl = mode_hl, strings = { mode } },
      --         { hl = 'MiniStatuslineDevinfo', strings = { diagnostics } },
      --         '%<', -- Mark general truncate point
      --         { hl = 'MiniStatuslineFilename', strings = { filename } },
      --         '%=', -- End left alignment
      --         { hl = 'MiniStatuslineFileinfo', strings = { fileinfo } },
      --         { hl = mode_hl, strings = { search, location } },
      --       }
      --     end,
      --     inactive = nil,
      --   },
      -- }

      -- -- You can configure sections in the statusline by overriding their
      -- -- default behavior. For example, here we set the section for
      -- -- cursor location to LINE:COLUMN
      -- ---@diagnostic disable-next-line: duplicate-set-field
      -- statusline.section_location = function()
      --   return ''
      -- end

      -- ... and there is more!
      --  Check out: https://github.com/echasnovski/mini.nvim
    end,
  },

  { -- Highlight, edit, and navigate code

    'nvim-treesitter/nvim-treesitter',
    build = ':TSUpdate',
    opts = {
      ensure_installed = { 'bash', 'c', 'html', 'lua', 'luadoc', 'markdown', 'vim', 'vimdoc' },
      -- Autoinstall languages that are not installed
      auto_install = true,
      highlight = {
        enable = true,
        -- Some languages depend on vim's regex highlighting system (such as Ruby) for indent rules.
        --  If you are experiencing weird indenting issues, add the language to
        --  the list of additional_vim_regex_highlighting and disabled languages for indent.
        additional_vim_regex_highlighting = { 'ruby' },
      },
      indent = { enable = true, disable = { 'ruby' } },
    },
    config = function(_, opts)
      -- [[ Configure Treesitter ]] See `:help nvim-treesitter`

      ---@diagnostic disable-next-line: missing-fields
      require('nvim-treesitter.configs').setup(opts)

      -- There are additional nvim-treesitter modules that you can use to interact
      -- with nvim-treesitter. You should go explore a few and see what interests you:
      --
      --    - Incremental selection: Included, see `:help nvim-treesitter-incremental-selection-mod`
      --    - Show your current context: https://github.com/nvim-treesitter/nvim-treesitter-context
      --    - Treesitter + textobjects: https://github.com/nvim-treesitter/nvim-treesitter-textobjects
    end,
  },

  {
    'folke/trouble.nvim',
    branch = 'dev', -- IMPORTANT!
    keys = {
      {
        '<leader>xx',
        '<cmd>Trouble diagnostics toggle<cr>',
        desc = 'Diagnostics (Trouble)',
      },
      {
        '<leader>xX',
        '<cmd>Trouble diagnostics toggle filter.buf=0<cr>',
        desc = 'Buffer Diagnostics (Trouble)',
      },
      {
        '<leader>xs',
        '<cmd>Trouble symbols toggle focus=false<cr>',
        desc = 'Symbols (Trouble)',
      },
      {
        '<leader>xl',
        '<cmd>Trouble lsp toggle focus=false win.position=right<cr>',
        desc = 'LSP Definitions / references / ... (Trouble)',
      },
      {
        '<leader>xL',
        '<cmd>Trouble loclist toggle<cr>',
        desc = 'Location List (Trouble)',
      },
      {
        '<leader>xQ',
        '<cmd>Trouble qflist toggle<cr>',
        desc = 'Quickfix List (Trouble)',
      },
    },
    opts = {}, -- for default options, refer to the configuration section for custom setup.
  },

  {
    'nvim-neo-tree/neo-tree.nvim',
    branch = 'v3.x',
    dependencies = {
      'nvim-lua/plenary.nvim',
      'nvim-tree/nvim-web-devicons', -- not strictly required, but recommended
      'MunifTanjim/nui.nvim',
      -- "3rd/image.nvim", -- Optional image support in preview window: See `# Preview Mode` for more information
    },
    config = function()
      require('neo-tree').setup {
        auto_clean_after_session_restore = true, -- Automatically clean up broken neo-tree buffers saved in sessions
        window = { -- see https://github.com/MunifTanjim/nui.nvim/tree/main/lua/nui/popup for
          -- possible options. These can also be functions that return these options.
          position = 'right', -- left, right, top, bottom, float, current
          width = 40, -- applies to left and right positions
          height = 15, -- applies to top and bottom positions
          auto_expand_width = false, -- expand the window when file exceeds the window width. does not work with position = "float"
          popup = { -- settings that apply to float position only
            size = {
              height = '80%',
              width = '50%',
            },
            position = '50%', -- 50% means center it
            -- you can also specify border here, if you want a different setting from
            -- the global popup_border_style.
          },
          mapping_options = {
            noremap = true,
            nowait = true,
          },
          mappings = {
            ['<space>'] = {
              'toggle_node',
              nowait = false, -- disable `nowait` if you have existing combos starting with this char that you want to use
            },
            ['<2-LeftMouse>'] = 'open',
            ['<cr>'] = 'open',
            -- ["<cr>"] = { "open", config = { expand_nested_files = true } }, -- expand nested file takes precedence
            ['<esc>'] = 'cancel', -- close preview or floating neo-tree window
            ['P'] = { 'toggle_preview', config = { use_float = true, use_image_nvim = false } },
            ['l'] = 'focus_preview',
            ['S'] = 'open_split',
            -- ["S"] = "split_with_window_picker",
            ['s'] = 'open_vsplit',
            -- ["sr"] = "open_rightbelow_vs",
            -- ["sl"] = "open_leftabove_vs",
            -- ["s"] = "vsplit_with_window_picker",
            ['t'] = 'open_tabnew',
            -- ["<cr>"] = "open_drop",
            -- ["t"] = "open_tab_drop",
            ['w'] = 'open_with_window_picker',
            ['C'] = 'close_node',
            ['z'] = 'close_all_nodes',
            --["Z"] = "expand_all_nodes",
            ['R'] = 'refresh',
            ['a'] = {
              'add',
              -- some commands may take optional config options, see `:h neo-tree-mappings` for details
              config = {
                show_path = 'none', -- "none", "relative", "absolute"
              },
            },
            ['A'] = 'add_directory', -- also accepts the config.show_path and config.insert_as options.
            ['d'] = 'delete',
            ['r'] = 'rename',
            ['y'] = 'copy_to_clipboard',
            ['x'] = 'cut_to_clipboard',
            ['p'] = 'paste_from_clipboard',
            ['c'] = 'copy', -- takes text input for destination, also accepts the config.show_path and config.insert_as options
            ['m'] = 'move', -- takes text input for destination, also accepts the config.show_path and config.insert_as options
            ['e'] = 'toggle_auto_expand_width',
            ['q'] = 'close_window',
            ['?'] = 'show_help',
            ['<'] = 'prev_source',
            ['>'] = 'next_source',
          },
        },
        filesystem = {
          window = {
            mappings = {
              ['H'] = 'toggle_hidden',
              ['/'] = 'fuzzy_finder',
              ['D'] = 'fuzzy_finder_directory',
              --["/"] = "filter_as_you_type", -- this was the default until v1.28
              ['#'] = 'fuzzy_sorter', -- fuzzy sorting using the fzy algorithm
              -- ["D"] = "fuzzy_sorter_directory",
              ['f'] = 'filter_on_submit',
              ['<C-x>'] = 'clear_filter',
              ['<bs>'] = 'navigate_up',
              ['.'] = 'set_root',
              ['[g'] = 'prev_git_modified',
              [']g'] = 'next_git_modified',
              ['i'] = 'show_file_details',
              ['o'] = { 'show_help', nowait = false, config = { title = 'Order by', prefix_key = 'o' } },
              ['oc'] = { 'order_by_created', nowait = false },
              ['od'] = { 'order_by_diagnostics', nowait = false },
              ['og'] = { 'order_by_git_status', nowait = false },
              ['om'] = { 'order_by_modified', nowait = false },
              ['on'] = { 'order_by_name', nowait = false },
              ['os'] = { 'order_by_size', nowait = false },
              ['ot'] = { 'order_by_type', nowait = false },
            },
            fuzzy_finder_mappings = { -- define keymaps for filter popup window in fuzzy_finder_mode
              ['<down>'] = 'move_cursor_down',
              ['<C-n>'] = 'move_cursor_down',
              ['<up>'] = 'move_cursor_up',
              ['<C-p>'] = 'move_cursor_up',
            },
          },
          async_directory_scan = 'auto', -- "auto"   means refreshes are async, but it's synchronous when called from the Neotree commands.
          -- "always" means directory scans are always async.
          -- "never"  means directory scans are never async.
          scan_mode = 'shallow', -- "shallow": Don't scan into directories to detect possible empty directory a priori
          -- "deep": Scan into directories to detect empty or grouped empty directories a priori.
          bind_to_cwd = true, -- true creates a 2-way binding between vim's cwd and neo-tree's root
          cwd_target = {
            sidebar = 'tab', -- sidebar is when position = left or right
            current = 'window', -- current is when position = current
          },
          check_gitignore_in_search = true, -- check gitignore status for files/directories when searching
          find_by_full_path_words = false, -- `false` means it only searches the tail of a path.
          group_empty_dirs = false, -- when true, empty folders will be grouped together
          search_limit = 50, -- max number of search results when using filters
          follow_current_file = {
            enabled = false, -- This will find and focus the file in the active buffer every time
            leave_dirs_open = false, -- `false` closes auto expanded dirs, such as with `:Neotree reveal`
          },
          hijack_netrw_behavior = 'disabled', -- netrw disabled, opening a directory opens neo-tree
          -- in whatever position is specified in window.position
          -- "open_current",-- netrw disabled, opening a directory opens within the
          -- window like netrw would, regardless of window.position
          -- "disabled",    -- netrw left alone, neo-tree does not handle opening dirs
          use_libuv_file_watcher = true, -- This will use the OS level file watchers to detect changes
          -- instead of relying on nvim autocmd events.
        },
        buffers = {
          bind_to_cwd = true,
          follow_current_file = {
            enabled = true, -- This will find and focus the file in the active buffer every time
            --              -- the current file is changed while the tree is open.
            leave_dirs_open = false, -- `false` closes auto expanded dirs, such as with `:Neotree reveal`
          },
          group_empty_dirs = true, -- when true, empty directories will be grouped together
          show_unloaded = false, -- When working with sessions, for example, restored but unfocused buffers
          -- are mark as "unloaded". Turn this on to view these unloaded buffer.
          terminals_first = false, -- when true, terminals will be listed before file buffers
          window = {
            mappings = {
              ['<bs>'] = 'navigate_up',
              ['.'] = 'set_root',
              ['bd'] = 'buffer_delete',
              ['i'] = 'show_file_details',
              ['o'] = { 'show_help', nowait = false, config = { title = 'Order by', prefix_key = 'o' } },
              ['oc'] = { 'order_by_created', nowait = false },
              ['od'] = { 'order_by_diagnostics', nowait = false },
              ['om'] = { 'order_by_modified', nowait = false },
              ['on'] = { 'order_by_name', nowait = false },
              ['os'] = { 'order_by_size', nowait = false },
              ['ot'] = { 'order_by_type', nowait = false },
            },
          },
        },
        git_status = {
          window = {
            mappings = {
              ['A'] = 'git_add_all',
              ['gu'] = 'git_unstage_file',
              ['ga'] = 'git_add_file',
              ['gr'] = 'git_revert_file',
              ['gc'] = 'git_commit',
              ['gp'] = 'git_push',
              ['gg'] = 'git_commit_and_push',
              ['i'] = 'show_file_details',
              ['o'] = { 'show_help', nowait = false, config = { title = 'Order by', prefix_key = 'o' } },
              ['oc'] = { 'order_by_created', nowait = false },
              ['od'] = { 'order_by_diagnostics', nowait = false },
              ['om'] = { 'order_by_modified', nowait = false },
              ['on'] = { 'order_by_name', nowait = false },
              ['os'] = { 'order_by_size', nowait = false },
              ['ot'] = { 'order_by_type', nowait = false },
            },
          },
        },
        document_symbols = {
          follow_cursor = false,
          client_filters = 'first',
          renderers = {
            root = {
              { 'indent' },
              { 'icon', default = 'C' },
              { 'name', zindex = 10 },
            },
            symbol = {
              { 'indent', with_expanders = true },
              { 'kind_icon', default = '?' },
              {
                'container',
                content = {
                  { 'name', zindex = 10 },
                  { 'kind_name', zindex = 20, align = 'right' },
                },
              },
            },
          },
          window = {
            mappings = {
              ['<cr>'] = 'jump_to_symbol',
              ['o'] = 'jump_to_symbol',
              ['A'] = 'noop', -- also accepts the config.show_path and config.insert_as options.
              ['d'] = 'noop',
              ['y'] = 'noop',
              ['x'] = 'noop',
              ['p'] = 'noop',
              ['c'] = 'noop',
              ['m'] = 'noop',
              ['a'] = 'noop',
              ['/'] = 'filter',
              ['f'] = 'filter_on_submit',
            },
          },
          custom_kinds = {
            -- define custom kinds here (also remember to add icon and hl group to kinds)
            -- ccls
            -- [252] = 'TypeAlias',
            -- [253] = 'Parameter',
            -- [254] = 'StaticMethod',
            -- [255] = 'Macro',
          },
          kinds = {
            Unknown = { icon = '?', hl = '' },
            Root = { icon = '', hl = 'NeoTreeRootName' },
            File = { icon = '󰈙', hl = 'Tag' },
            Module = { icon = '', hl = 'Exception' },
            Namespace = { icon = '󰌗', hl = 'Include' },
            Package = { icon = '󰏖', hl = 'Label' },
            Class = { icon = '󰌗', hl = 'Include' },
            Method = { icon = '', hl = 'Function' },
            Property = { icon = '󰆧', hl = '@property' },
            Field = { icon = '', hl = '@field' },
            Constructor = { icon = '', hl = '@constructor' },
            Enum = { icon = '󰒻', hl = '@number' },
            Interface = { icon = '', hl = 'Type' },
            Function = { icon = '󰊕', hl = 'Function' },
            Variable = { icon = '', hl = '@variable' },
            Constant = { icon = '', hl = 'Constant' },
            String = { icon = '󰀬', hl = 'String' },
            Number = { icon = '󰎠', hl = 'Number' },
            Boolean = { icon = '', hl = 'Boolean' },
            Array = { icon = '󰅪', hl = 'Type' },
            Object = { icon = '󰅩', hl = 'Type' },
            Key = { icon = '󰌋', hl = '' },
            Null = { icon = '', hl = 'Constant' },
            EnumMember = { icon = '', hl = 'Number' },
            Struct = { icon = '󰌗', hl = 'Type' },
            Event = { icon = '', hl = 'Constant' },
            Operator = { icon = '󰆕', hl = 'Operator' },
            TypeParameter = { icon = '󰊄', hl = 'Type' },

            -- ccls
            -- TypeAlias = { icon = ' ', hl = 'Type' },
            -- Parameter = { icon = ' ', hl = '@parameter' },
            -- StaticMethod = { icon = '󰠄 ', hl = 'Function' },
            -- Macro = { icon = ' ', hl = 'Macro' },
          },
        },
        example = {
          renderers = {
            custom = {
              { 'indent' },
              { 'icon', default = 'C' },
              { 'custom' },
              { 'name' },
            },
          },
          window = {
            mappings = {
              ['<cr>'] = 'toggle_node',
              ['<C-e>'] = 'example_command',
              ['d'] = 'show_debug_info',
            },
          },
        },
      }

      vim.keymap.set('n', '<leader>-', '<cmd>Neotree reveal toggle<cr>', { desc = '[-] Toggle Neotree' })
    end,
  },

  {
    'mbbill/undotree',
    config = function()
      vim.keymap.set('n', '<leader>u', vim.cmd.UndotreeToggle)
    end,
  },
  {
    'kylechui/nvim-surround',
    version = '*', -- Use for stability; omit to use `main` branch for the latest features
    event = 'VeryLazy',
    config = function()
      require('nvim-surround').setup {
        -- Configuration here, or leave empty to use defaults
      }
    end,
  },
  {
    'ThePrimeagen/vim-be-good',
  },

  {
    'lukas-reineke/indent-blankline.nvim',
    main = 'ibl',
    config = function()
      require('ibl').setup {
        scope = { enabled = false },
      }
    end,
  },

  {
    'f-person/git-blame.nvim',
    opts = {},
  },

  {
    'nvim-lualine/lualine.nvim',
    dependencies = {
      'f-person/git-blame.nvim',
      'nvim-tree/nvim-web-devicons',
    },
    config = function()
      local git_blame = require 'gitblame'
      vim.g.gitblame_display_virtual_text = 0
      vim.g.gitblame_delay = 0
      -- }

      require('lualine').setup {
        options = {
          icons_enabled = true,
          theme = 'auto',
          -- component_separators = '',
          -- section_separators = { left = '', right = '' },
          --
          --
          component_separators = { left = ' ', right = ' ' },
          section_separators = { left = ' ', right = ' ' },
        },
        sections = {
          lualine_a = {
            {
              'mode',
              -- separator = { left = '' },
              -- separator = { left = '|', right = '|' },
              right_padding = 2,
            },
          },
          lualine_b = { 'filename', 'branch' },
          lualine_c = {
            '%=', --[[ add your center compoentnts here in place of this comment ]]

            { git_blame.get_current_blame_text, cond = git_blame.is_blame_text_available },
          },
          lualine_x = {},
          lualine_y = { 'filetype', 'progress' },
          lualine_z = {
            {
              'location',
              -- separator = { right = '' },
              -- separator = { right = '' },
              left_padding = 2,
            },
          },
        },
        inactive_sections = {
          lualine_a = { 'filename' },
          lualine_b = {},
          lualine_c = {},
          lualine_x = {},
          lualine_y = {},
          lualine_z = { 'location' },
        },
        tabline = {},
        extensions = {},
      }

      -- require('lualine').setup {
      --   options = {
      --     icons_enabled = true,
      --     theme = 'auto',
      --     component_separators = { left = '', right = '' },
      --     section_separators = { left = '', right = '' },
      --     disabled_filetypes = {
      --       statusline = {},
      --       winbar = {},
      --     },
      --     ignore_focus = {},
      --     always_divide_middle = true,
      --     globalstatus = false,
      --     refresh = {
      --       statusline = 1000,
      --       tabline = 1000,
      --       winbar = 1000,
      --     },
      --   },
      --   sections = {
      --     lualine_a = { 'mode' },
      --     lualine_b = { 'branch', 'diff', 'diagnostics' },
      --     lualine_c = { 'filename' },
      --     lualine_x = { 'encoding', 'fileformat', 'filetype' },
      --     lualine_y = { 'progress' },
      --     lualine_z = { 'location' },
      --   },
      --   inactive_sections = {
      --     lualine_a = {},
      --     lualine_b = {},
      --     lualine_c = { 'filename' },
      --     lualine_x = { 'location' },
      --     lualine_y = {},
      --     lualine_z = {},
      --   },
      --   tabline = {},
      --   winbar = {},
      --   inactive_winbar = {},
      --   extensions = {},
      -- }
    end,
  },

  {
    'stevearc/oil.nvim',
    -- Optional dependencies
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    config = function()
      require('oil').setup {
        default_file_explorer = false,
      }
      vim.keymap.set('n', '<leader>_', '<CMD>Oil<CR>', { desc = 'Open parent directory in Oil' })
    end,
  },

  -- { -- Add indentation guides even on blank lines
  --   'lukas-reineke/indent-blankline.nvim',
  --   -- Enable `lukas-reineke/indent-blankline.nvim`
  --   -- See `:help ibl`
  --   main = 'ibl',
  --   opts = {},
  -- },
}
