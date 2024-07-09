--Disable The StatusLine

vim.opt.guicursor = {
  'n-v-c:block-Cursor/lCursor-blinkwait1000-blinkon100-blinkoff100',
  'i-ci:ver25-Cursor/lCursor-blinkwait1000-blinkon100-blinkoff100',
  'r:hor50-Cursor/lCursor-blinkwait100-blinkon100-blinkoff100',
}

local home = os.getenv 'HOME'
local foldIcon = '•••'
local hlgroup = 'NonText'
local function foldTextFormatter(virtText, lnum, endLnum, width, truncate)
  local newVirtText = {}
  local suffix = '  ' .. foldIcon .. '  ' .. tostring(endLnum - lnum)
  local sufWidth = vim.fn.strdisplaywidth(suffix)
  local targetWidth = width - sufWidth
  local curWidth = 0
  for _, chunk in ipairs(virtText) do
    local chunkText = chunk[1]
    local chunkWidth = vim.fn.strdisplaywidth(chunkText)
    if targetWidth > curWidth + chunkWidth then
      table.insert(newVirtText, chunk)
    else
      chunkText = truncate(chunkText, targetWidth - curWidth)
      local hlGroup = chunk[2]
      table.insert(newVirtText, { chunkText, hlGroup })
      chunkWidth = vim.fn.strdisplaywidth(chunkText)
      if curWidth + chunkWidth < targetWidth then
        suffix = suffix .. (' '):rep(targetWidth - curWidth - chunkWidth)
      end
      break
    end
    curWidth = curWidth + chunkWidth
  end
  table.insert(newVirtText, { suffix, hlgroup })
  return newVirtText
end
vim.o.inccommand = 'split'

vim.api.nvim_create_autocmd('User', {
  pattern = { 'alpha' },
  command = 'set laststatus=0',
})

vim.api.nvim_create_autocmd('BufUnload', {
  buffer = 0,
  callback = function()
    vim.opt.laststatus = 2
  end,
})

vim.opt.termguicolors = true
vim.filetype.add { extension = { templ = 'templ' } }
vim.opt.autochdir = true
vim.opt.swapfile = false
vim.opt.showtabline = 0
vim.o.cmdheight = 1

-- Markdown specific settings
vim.opt.wrap = true -- Wrap text
vim.opt.breakindent = true -- Match indent on line break
vim.opt.linebreak = true -- Line break on whole words

-- Allow j/k when navigating wrapped lines
vim.keymap.set('n', 'j', 'gj')
vim.keymap.set('n', 'k', 'gk')

-- Spell check
vim.opt.spelllang = 'en_us'
vim.opt.spell = true

-- Float Terminal
vim.api.nvim_set_keymap('n', '<F10>', '<Cmd>lua require("nvterm.terminal").toggle "float"<CR>', { noremap = true, silent = true })

vim.api.nvim_set_keymap('n', '<F12>', '<Cmd>set autochdir!<CR>', { noremap = true, silent = true })

local function set_statusline_transparency()
  vim.opt.statusline = ''
  vim.api.nvim_set_hl(0, 'Statusline', { link = 'Normal' })
end

-- Run the function when Neovim starts
vim.api.nvim_create_autocmd({ 'VimEnter' }, { callback = set_statusline_transparency })

vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- Set to true if you have a Nerd Font installed
vim.g.have_nerd_font = true

-- [[ Setting options ]]
-- See `:help vim.opt`
-- NOTE: You can change these options as you wish!
--  For more options, you can see `:help option-list`

-- Make line numbers default
vim.opt.number = true
-- You can also add relative line numbers, to help with jumping.
--  Experiment for yourself to see if you like it!
-- vim.opt.relativenumber = true

-- Enable mouse mode, can be useful for resizing splits for example!
vim.opt.mouse = ''

-- Don't show the mode, since it's already in the status line
vim.opt.showmode = false

-- Sync clipboard between OS and Neovim.
--  Remove this option if you want your OS clipboard to remain independent.
--  See `:help 'clipboard'`

vim.opt.clipboard = 'unnamedplus'
-- Enable break indent
vim.opt.breakindent = true

-- Save undo history
vim.opt.undofile = true

-- Case-insensitive searching UNLESS \C or one or more capital letters in the search term
vim.opt.ignorecase = true
vim.opt.smartcase = true

-- Keep signcolumn on by default
vim.opt.signcolumn = 'yes'

-- Decrease update time
vim.opt.updatetime = 250

-- Decrease mapped sequence wait time
-- Displays which-key popup sooner
vim.opt.timeoutlen = 300

-- Configure how new splits should be opened
vim.opt.splitright = true
vim.opt.splitbelow = true

-- Sets how neovim will display certain whitespace characters in the editor.
--  See `:help 'list'`
--  and `:help 'listchars'`
vim.opt.list = true
vim.opt.listchars = { tab = '» ', trail = '·', nbsp = '␣' }

-- Preview substitutions live, as you type!
vim.opt.inccommand = 'split'

-- Show which line your cursor is on
vim.opt.cursorline = true

-- Minimal number of screen lines to keep above and below the cursor.
vim.opt.scrolloff = 10

-- [[ Basic Keymaps ]]
--  See `:help vim.keymap.set()`

-- Set highlight on search, but clear on pressing <Esc> in normal mode
vim.opt.hlsearch = true
vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')

vim.keymap.set('n', 'bp', '<Cmd>bp<CR>')
vim.keymap.set('n', 'bn', '<Cmd>bn<CR>')
vim.keymap.set('n', '<F9>', '<Cmd>bd!<CR>')

-- Diagnostic keymaps
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, { desc = 'Go to previous [D]iagnostic message' })
vim.keymap.set('n', ']d', vim.diagnostic.goto_next, { desc = 'Go to next [D]iagnostic message' })
vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float, { desc = 'Show diagnostic [E]rror messages' })
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostic [Q]uickfix list' })
vim.keymap.set('n', 'ss', '<Cmd>SessionsSave<CR>')
vim.keymap.set('n', 'rs', '<Cmd>SessionsLoad<CR>')

-- Exit terminal mode in the builtin terminal with a shortcut that is a bit easier
-- for people to discover. Otherwise, you normally need to press <C-\><C-n>, which
-- is not what someone will guess without a bit more experience.
--
-- NOTE: This won't work in all terminal emulators/tmux/etc. Try your own mapping
-- or just use <C-\><C-n> to exit terminal mode
vim.keymap.set('t', '<Esc><Esc>', '<C-\\><C-n>', { desc = 'Exit terminal mode' })

-- TIP: Disable arrow keys in normal mode
-- vim.keymap.set('n', '<left>', '<cmd>echo "Use h to move!!"<CR>')
-- vim.keymap.set('n', '<right>', '<cmd>echo "Use l to move!!"<CR>')
-- vim.keymap.set('n', '<up>', '<cmd>echo "Use k to move!!"<CR>')
-- vim.keymap.set('n', '<down>', '<cmd>echo "Use j to move!!"<CR>')

-- Keybinds to make split navigation easier.
--  Use CTRL+<hjkl> to switch between windows
--
--  See `:help wincmd` for a list of all window commands
vim.keymap.set('n', '<C-h>', '<C-w><C-h>', { desc = 'Move focus to the left window' })
vim.keymap.set('n', '<C-l>', '<C-w><C-l>', { desc = 'Move focus to the right window' })
vim.keymap.set('n', '<C-j>', '<C-w><C-j>', { desc = 'Move focus to the lower window' })
vim.keymap.set('n', '<C-k>', '<C-w><C-k>', { desc = 'Move focus to the upper window' })

-- [[ Basic Autocommands ]]
--  See `:help lua-guide-autocommands`

-- Highlight when yanking (copying) text
--  Try it with `yap` in normal mode
--  See `:help vim.highlight.on_yank()`
vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking (copying) text',
  group = vim.api.nvim_create_augroup('kickstart-highlight-yank', { clear = true }),
  callback = function()
    vim.highlight.on_yank()
  end,
})

-- [[ Install `lazy.nvim` plugin manager ]]
--    See `:help lazy.nvim.txt` or https://github.com/folke/lazy.nvim for more info
local lazypath = vim.fn.stdpath 'data' .. '/lazy/lazy.nvim'
if not vim.loop.fs_stat(lazypath) then
  local lazyrepo = 'https://github.com/folke/lazy.nvim.git'
  vim.fn.system { 'git', 'clone', '--filter=blob:none', '--branch=stable', lazyrepo, lazypath }
end ---@diagnostic disable-next-line: undefined-field

vim.opt.rtp:prepend(lazypath)

-- [[ Configure and install plugins ]]
--
--  To check the current status of your plugins, run
--    :Lazy
--
--  You can press `?` in this menu for help. Use `:q` to close the window
--
--  To update plugins you can run
--    :Lazy update
--
-- NOTE: Here is where you install your plugins.
require('lazy').setup({
  -- NOTE: Plugins can be added with a link (or for a github repo: 'owner/repo' link).
  'tpope/vim-sleuth', -- Detect tabstop and shiftwidth automatically

  -- NOTE: Plugins can also be added by using a table,
  -- with the first argument being the link and the following
  -- keys can be used to configure plugin behavior/loading/etc.
  --
  -- Use `opts = {}` to force a plugin to be loaded.
  --
  --  This is equivalent to:
  --    require('Comment').setup({})

  -- debug.lua
  --
  -- Shows how to use the DAP plugin to debug your code.
  --
  -- Primarily focused on configuring the debugger for Go, but can
  -- be extended to other languages as well. That's why it's called
  -- kickstart.nvim and not kitchen-sink.nvim ;)

  {
    'nvim-neotest/neotest',
    dependencies = {
      'nvim-neotest/neotest-python',
      'nvim-neotest/nvim-nio',
      'nvim-lua/plenary.nvim',
      'nvim-neotest/neotest-go',
      'antoinemadec/FixCursorHold.nvim',
      'nvim-treesitter/nvim-treesitter',
    },
    config = function()
      require('neotest').setup {
        adapters = {
          require 'neotest-python',
        },
      }
    end,
    config = function()
      -- get neotest namespace (api call creates or returns namespace)
      local neotest_ns = vim.api.nvim_create_namespace 'neotest'
      vim.diagnostic.config({
        virtual_text = {
          format = function(diagnostic)
            local message = diagnostic.message:gsub('\n', ' '):gsub('\t', ' '):gsub('%s+', ' '):gsub('^%s+', '')
            return message
          end,
        },
      }, neotest_ns)
      require('neotest').setup {
        -- your neotest config here
        adapters = {
          require 'neotest-go' { experimental = {
            test_table = true,
          } },
        },
      }
    end,
    vim.api.nvim_set_keymap(
      'n',
      '<Leader>tr',
      ':lua require("neotest").run.run({vim.loop.cwd(), extra_args = {"-race"}})<CR> <BAR> :lua require("neotest").summary.toggle()<CR>',
      { noremap = true, silent = true }
    ),
    vim.api.nvim_set_keymap('n', '<Leader>ts', ':lua require("neotest").summary.toggle()<CR>', { noremap = true, silent = true }),
    vim.api.nvim_set_keymap('n', '<Leader>tc', ':on<CR>', { noremap = true, silent = true }),
    vim.api.nvim_set_keymap('n', '<Leader>to', ':lua require("neotest").output.open({ enter = true })<CR>', { noremap = true, silent = true }),
  },
  {

    -- NOTE: Yes, you can install new plugins here!
    'mfussenegger/nvim-dap',
    -- NOTE: And you can specify dependencies as well
    dependencies = {
      -- Creates a beautiful debugger UI
      'rcarriga/nvim-dap-ui',

      -- Required dependency for nvim-dap-ui
      'nvim-neotest/nvim-nio',

      -- Installs the debug adapters for you
      'williamboman/mason.nvim',
      'jay-babu/mason-nvim-dap.nvim',

      -- Add your own debuggers here
      'leoluz/nvim-dap-go',
    },
    config = function()
      local dap = require 'dap'
      local dapui = require 'dapui'

      require('mason-nvim-dap').setup {
        -- Makes a best effort to setup the various debuggers with
        -- reasonable debug configurations
        automatic_setup = true,

        -- You can provide additional configuration to the handlers,
        -- see mason-nvim-dap README for more information
        handlers = {},

        -- You'll need to check that you have the required things installed
        -- online, please don't ask me how to install them :)
        ensure_installed = {
          -- Update this to ensure that you have the debuggers for the langs you want
          'delve',
        },
      }

      -- Basic debugging keymaps, feel free to change to your liking!
      vim.keymap.set('n', '<F11>', dap.continue, { desc = 'Debug: Start/Continue' })
      vim.keymap.set('n', '<F1>', dap.step_into, { desc = 'Debug: Step Into' })
      vim.keymap.set('n', '<F2>', dap.step_over, { desc = 'Debug: Step Over' })
      vim.keymap.set('n', '<F3>', dap.step_out, { desc = 'Debug: Step Out' })
      vim.keymap.set('n', '<leader>b', dap.toggle_breakpoint, { desc = 'Debug: Toggle Breakpoint' })
      vim.keymap.set('n', '<leader>B', function()
        dap.set_breakpoint(vim.fn.input 'Breakpoint condition: ')
      end, { desc = 'Debug: Set Breakpoint' })

      -- Dap UI setup
      -- For more information, see |:help nvim-dap-ui|
      dapui.setup {
        -- Set icons to characters that are more likely to work in every terminal.
        --    Feel free to remove or use ones that you like more! :)
        --    Don't feel like these are good choices.
        icons = { expanded = '▾', collapsed = '▸', current_frame = '*' },
        controls = {
          icons = {
            pause = '⏸',
            play = '▶',
            step_into = '⏎',
            step_over = '⏭',
            step_out = '⏮',
            step_back = 'b',
            run_last = '▶▶',
            terminate = '⏹',
            disconnect = '⏏',
          },
        },
      }

      -- Toggle to see last session result. Without this, you can't see session output in case of unhandled exception.
      vim.keymap.set('n', '<F7>', dapui.toggle, { desc = 'Debug: See last session result.' })

      dap.listeners.after.event_initialized['dapui_config'] = dapui.open
      dap.listeners.before.event_terminated['dapui_config'] = dapui.close
      dap.listeners.before.event_exited['dapui_config'] = dapui.close

      -- Install golang specific config
      require('dap-go').setup()
    end,
    {
      'ziontee113/icon-picker.nvim',
      config = function()
        require('icon-picker').setup { disable_legacy_commands = true }

        local opts = { noremap = true, silent = true }

        vim.keymap.set('n', '<Leader>i', '<cmd>IconPickerNormal<cr>', opts)
        vim.keymap.set('n', '<Leader>g', '<cmd>IconPickerYank<cr>', opts) --> Yank the selected icon into register
      end,
    },
    {
      'vhyrro/luarocks.nvim',
      priority = 1000,
      config = true,
    },
    {
      'nvim-neorg/neorg',
      dependencies = { 'nvim-lua/plenary.nvim', 'luarocks.nvim', 'lua-utils.nvim', 'nvim-nio', 'nui.nvim', 'pathlib.nvim' },
      config = function()
        require('neorg').setup {
          load = {
            ['core.defaults'] = {}, -- Loads default behaviour
            ['core.concealer'] = {
              config = {
                icon_preset = 'diamond',
              },
            }, -- Adds pretty icons to your documents
            ['core.dirman'] = { -- Manages Neorg workspaces
              config = {
                workspaces = {
                  work = '~/notes/work',
                  personal = '~/notes/private',
                },
              },
            },
            ['core.keybinds'] = {
              config = {
                hook = function(keybinds)
                  -- I want my regualar <CR> saves mapping, use K instead
                  keybinds.remap_key('norg', 'n', '<CR>', 'K')

                  -- Can't use <C-Space> on my mac as I use it for language switch, CTRL-T is fine
                  keybinds.remap_key('norg', 'n', '<C-Space>', '<C-t>')
                end,
              },
            },
            -- Convert unordered lists to ordered lists or vice versa with <LL>LT
            ['core.pivot'] = {},
            -- Continue current type of item (heading, list, todo) with Alt-Enter
            ['core.itero'] = {},
            -- Support completion in norg files
            ['core.completion'] = {
              config = {
                engine = 'nvim-cmp',
              },
            },
          },
        }
      end,
    },
    {
      'MeanderingProgrammer/markdown.nvim',
      name = 'render-markdown', -- Only needed if you have another plugin named markdown.nvim
      dependencies = { 'nvim-treesitter/nvim-treesitter', 'echasnovski/mini.nvim' }, -- if you use the mini.nvim suite
      config = function()
        require('render-markdown').setup {}
      end,
    },
    { -- UFO
      'kevinhwang91/nvim-ufo',
      dependencies = 'kevinhwang91/promise-async',
      event = 'BufReadPost', -- needed for folds to load in time
      keys = {
        {
          'zr',
          function()
            require('ufo').openFoldsExceptKinds { 'imports', 'comment' }
          end,
          desc = ' 󱃄 Open All Folds except comments',
        },
        {
          'zm',
          function()
            require('ufo').closeAllFolds()
          end,
          desc = ' 󱃄 Close All Folds',
        },
        {
          'z1',
          function()
            require('ufo').closeFoldsWith(1)
          end,
          desc = ' 󱃄 Close L1 Folds',
        },
        {
          'z2',
          function()
            require('ufo').closeFoldsWith(2)
          end,
          desc = ' 󱃄 Close L2 Folds',
        },
        {
          'z3',
          function()
            require('ufo').closeFoldsWith(3)
          end,
          desc = ' 󱃄 Close L3 Folds',
        },
        {
          'z4',
          function()
            require('ufo').closeFoldsWith(4)
          end,
          desc = ' 󱃄 Close L4 Folds',
        },
      },
      init = function()
        -- INFO fold commands usually change the foldlevel, which fixes folds, e.g.
        -- auto-closing them after leaving insert mode, however ufo does not seem to
        -- have equivalents for zr and zm because there is no saved fold level.
        -- Consequently, the vim-internal fold levels need to be disabled by setting
        -- them to 99
        vim.opt.foldlevel = 99
        vim.opt.foldlevelstart = 99
      end,
      opts = {
        provider_selector = function(_, ft, _)
          -- INFO some filetypes only allow indent, some only LSP, some only
          -- treesitter. However, ufo only accepts two kinds as priority,
          -- therefore making this function necessary :/
          local lspWithOutFolding = { 'markdown', 'sh', 'css', 'html', 'python' }
          if vim.tbl_contains(lspWithOutFolding, ft) then
            return { 'treesitter', 'indent' }
          end
          return { 'lsp', 'indent' }
        end,
        -- open opening the buffer, close these fold kinds
        -- use `:UfoInspect` to get available fold kinds from the LSP
        close_fold_kinds_for_ft = { lsp = { 'imports', 'comment' } },
        open_fold_hl_timeout = 800,
        fold_virt_text_handler = foldTextFormatter,
      },
    },
    {
      'aznhe21/actions-preview.nvim',
      config = function()
        local actions_preview = require 'actions-preview'
        vim.keymap.set('v', 'gt', actions_preview.code_actions)
        vim.keymap.set('n', 'gt', actions_preview.code_actions)
      end,
    },
    {
      'sainnhe/gruvbox-material',
      enabled = true,
      priority = 1000,
      config = function()
        vim.g.gruvbox_material_transparent_background = 0
        vim.g.gruvbox_material_foreground = 'mix'
        vim.g.gruvbox_material_background = 'hard' -- soft, medium, hard
        vim.g.gruvbox_material_ui_contrast = 'high' -- The contrast of line numbers, indent lines, etc.
        vim.g.gruvbox_material_float_style = 'bright' -- Background of floating windows
        vim.g.gruvbox_material_statusline_style = 'material'
        vim.g.gruvbox_material_cursor = 'auto'

        -- vim.g.gruvbox_material_colors_override = { bg0 = '#000000' } -- #0e1010
        -- vim.g.gruvbox_material_colors_override = { bg0 = "#121212" }
        -- vim.g.gruvbox_material_better_performance = 1

        vim.cmd.colorscheme 'gruvbox-material'
      end,
    },
    {
      'NvChad/nvterm',
      config = function()
        require('nvterm').setup {
          terminals = {
            shell = vim.o.shell,
            list = {},
            type_opts = {
              float = {
                relative = 'editor',
                row = 0.3,
                col = 0.25,
                width = 0.5,
                height = 0.4,
                border = 'rounded',
              },
              horizontal = { location = 'rightbelow', split_ratio = 0.3 },
              vertical = { location = 'rightbelow', split_ratio = 0.5 },
            },
          },
          behavior = {
            autoclose_on_quit = {
              enabled = false,
              confirm = true,
            },
            close_on_exit = true,
            auto_insert = true,
          },
        }
      end,
    },

    {
      'yanskun/gotests.nvim',
      ft = 'go',
      config = function()
        require('gotests').setup()
      end,
    },
    {
      'siawkz/nvim-cheatsh',
      dependencies = {
        'nvim-telescope/telescope.nvim',
      },
      opts = {
        cheatsh_url = 'https://cht.sh/', -- URL of the cheat.sh instance to use, support self-hosted instances
        position = 'bottom', -- position of the window can be: bottom, top, left, right
        height = 20, -- height of the cheat when position is top or bottom
        width = 100, -- width of the cheat when position is left or right
      },
    },

    -- SESSION MANAGER

    {
      'natecraddock/sessions.nvim',
      config = function()
        require('sessions').setup {
          session_filepath = vim.fn.stdpath 'data' .. '/sessions',
          absolute = true,
          autosave = true,
          save = true,
        }
      end,
    },
    {
      'sachinsenal0x64/hot.nvim',
      config = function()
        local opts = require('hot.params').opts

        -- Update the Lualine Status
        Reloader = opts.tweaks.default
        Reloader = '󰒲 '

        Pattern = opts.tweaks.patterns
        Pattern = { 'main.py', 'main.go' }

        opts.tweaks.start = '󱓞 '
        opts.tweaks.stop = ' 󰒲 '
        opts.tweaks.test = '󰤑'
        opts.tweaks.test_done = '󰙨'
        opts.tweaks.test_fail = '󰤒'

        -- If the 'main.*' file doesn't exist, it will fall back to 'index.*'
        opts.tweaks.custom_file = 'index'

        -- Add Languages
        opts.set.languages.python = {
          cmd = 'python3',
          desc = 'Run Python file asynchronously',
          kill_desc = 'Kill the running Python file',
          emoji = '',
          test = 'python -m unittest -v',
          ext = { '.py' },
        }

        opts.set.languages.go = {
          cmd = 'go run',
          desc = 'Run Go file asynchronously',
          kill_desc = 'Kill the running Go file',
          emoji = '',
          test = 'go test',
          ext = { '.go' },
        }

        -- Thot Health Check
        vim.api.nvim_set_keymap('n', 'ho', '<Cmd>lua require("thot").check()<CR>', { noremap = true, silent = true })

        -- Keybinds

        -- Start
        vim.api.nvim_set_keymap('n', '<leader>a', '<Cmd>lua require("hot").restart()<CR>', { noremap = true, silent = true })
        -- Silent
        vim.api.nvim_set_keymap('n', '<F4>', '<Cmd>lua require("hot").silent()<CR>', { noremap = true, silent = true })
        -- Stop
        vim.api.nvim_set_keymap('n', '<F5>', '<Cmd>lua require("hot").stop()<CR>', { noremap = true, silent = true })
        -- Test
        vim.api.nvim_set_keymap('n', '<F6>', '<Cmd>lua require("hot").test_restart()<CR>', { noremap = true, silent = true })
        -- Close Buffer
        vim.api.nvim_set_keymap('n', '<F8>', '<Cmd>lua require("hot").close_output_buffer()<CR>', { noremap = true, silent = true })
        -- Open Buffer
        vim.api.nvim_set_keymap('n', '<F7>', '<Cmd>lua require("hot").open_output_buffer()<CR>', { noremap = true, silent = true })
      end,
    },
    {
      'michaelrommel/nvim-silicon',
      lazy = true,
      cmd = 'Silicon',
      init = function()
        local wk = require 'which-key'
        wk.register({
          ['s'] = {
            name = 'Silicon',
            ['s'] = {
              function()
                require('nvim-silicon').shoot()
              end,
              'Create code screenshot',
            },
            ['f'] = {
              function()
                require('nvim-silicon').file()
              end,
              'Save code screenshot as file',
            },
            ['c'] = {
              function()
                require('nvim-silicon').clip()
              end,
              'Copy code screenshot to clipboard',
            },
          },
        }, { prefix = '<leader>', mode = 'v' })
      end,
      config = function()
        require('silicon').setup {
          font = 'JetBrainsMono NF=34;Noto Color Emoji=34',
          theme = 'Dracula',
          background = '#ABB8C3',
          output = function()
            return home .. os.date '/Pictures/screenshots/%Y-%m-%dT%H-%M-%SZ' .. '_code.png'
          end,
        }
      end,
    },
    {
      -- A Neovim Plugin for the yazi terminal file browser.
      -- SEE: https://github.com/mikavilpas/yazi.nvim
      'mikavilpas/yazi.nvim',

      event = 'VeryLazy',
      dependencies = {
        'nvim-lua/plenary.nvim',
      },

      config = function()
        local plugin = require 'yazi'

        local keymap = vim.keymap.set

        local search_cwd = function()
          plugin.yazi(nil, vim.fn.getcwd())
        end

        local search_parent = function()
          local bufnr = vim.api.nvim_get_current_buf()
          local bufname = vim.api.nvim_buf_get_name(bufnr)
          local bufdir = vim.fn.fnamemodify(bufname, ':p:h')

          if bufdir == '' then
            bufdir = vim.fn.getcwd()
          end

          plugin.yazi(nil, bufname)
        end

        keymap('n', '<leader>p', search_parent, { desc = 'Open the file [p]xplorer in parent directory.' })

        keymap('n', '<leader>e', search_cwd, { desc = 'Open the file [e]xplorer in cwd.' })

        plugin.setup {
          open_for_directories = false,
          floating_window_scaling_factor = 0.9,
          yazi_floating_window_winblend = 0,
          yazi_floating_window_border = 'rounded',
        }
      end,
    }, -- add this to the file where you setup your other plugins:
    -- {
    --   'monkoose/neocodeium',
    --   config = function()
    --     local neocodeium = require 'neocodeium'
    --     neocodeium.setup {}
    --     vim.keymap.set('i', '<A-f>', function()
    --       neocodeium.accept()
    --     end)
    --     vim.keymap.set('i', '<A-w>', function()
    --       neocodeium.accept_word()
    --     end)
    --     vim.keymap.set('i', '<A-x>', function()
    --       neocodeium.accept_line()
    --     end)
    --     vim.keymap.set('i', '<A-e>', function()
    --       neocodeium.cycle_or_complete()
    --     end)
    --     vim.keymap.set('i', '<A-r>', function()
    --       neocodeium.cycle_or_complete(-1)
    --     end)
    --     vim.keymap.set('i', '<A-c>', function()
    --       neocodeium.clear()
    --     end)
    --   end,
    -- },
    --
    {
      'pteroctopus/faster.nvim',
      config = function()
        require('faster').setup {
          -- Behaviour table contains configuration for behaviours faster.nvim uses
          behaviours = {
            -- Bigfile configuration controls disabling and enabling of features when
            -- big file is opened
            bigfile = {
              -- Behaviour can be turned on or off. To turn on set to true, otherwise
              -- set to false
              on = true,
              -- Table which contains names of features that will be disabled when
              -- bigfile is opened. Feature names can be seen in features table below.
              -- features_disabled can also be set to "all" and then all features that
              -- are on (on=true) are going to be disabled for this behaviour
              features_disabled = {
                'illuminate',
                'matchparen',
                'lsp',
                'treesitter',
                'indent_blankline',
                'vimopts',
                'syntax',
                'filetype',
              },
              -- Files larger than `filesize` are considered big files. Value is in MB.
              filesize = 2,
              -- Autocmd pattern that controls on which files behaviour will be applied.
              -- `*` means any file.
              pattern = '*',
              -- Optional extra patterns and sizes for which bigfile behaviour will apply.
              -- Note! that when multiple patterns (including the main one) and filesizes
              -- are defined: bigfile behaviour will be applied for minimum filesize of
              -- those defined in all applicable patterns for that file.
              -- extra_pattern example in multi line comment is bellow:
              --[[
      extra_patterns = {
        -- If this is used than bigfile behaviour for *.md files will be
        -- triggered for filesize of 1.1MiB
        { filesize = 1.1, pattern = "*.md" },
        -- If this is used than bigfile behaviour for *.log file will be
        -- triggered for the value in `behaviours.bigfile.filesize`
        { pattern  = "*.log" },
        -- Next line is invalid without the pattern and will be ignored
        { filesize = 3 },
      },
      ]]
              -- By default `extra_patterns` is an empty table: {}.
              extra_patterns = {},
            },
            -- Fast macro configuration controls disabling and enabling features when
            -- macro is executed
            fastmacro = {
              -- Behaviour can be turned on or off. To turn on set to true, otherwise
              -- set to false
              on = true,
              -- Table which contains names of features that will be disabled when
              -- macro is executed. Feature names can be seen in features table below.
              -- features_disabled can also be set to "all" and then all features that
              -- are on (on=true) are going to be disabled for this behaviour.
              -- Specificaly: lualine plugin is disabled when macros are executed because
              -- if a recursive macro opens a buffer on every iteration this error will
              -- happen after 300-400 hundred iterations:
              -- `E5108: Error executing lua Vim:E903: Process failed to start: too many open files: "/usr/bin/git"`
              features_disabled = { 'lualine' },
            },
          },
          -- Feature table contains configuration for features faster.nvim will disable
          -- and enable according to rules defined in behaviours.
          -- Defined feature will be used by faster.nvim only if it is on (`on=true`).
          -- Defer will be used if some features need to be disabled after others.
          -- defer=false features will be disabled first and defer=true features last.
          features = {
            -- Neovim filetype plugin
            -- https://neovim.io/doc/user/filetype.html
            filetype = {
              on = true,
              defer = true,
            },
            -- Illuminate plugin
            -- https://github.com/RRethy/vim-illuminate
            illuminate = {
              on = true,
              defer = false,
            },
            -- Indent Blankline
            -- https://github.com/lukas-reineke/indent-blankline.nvim
            indent_blankline = {
              on = true,
              defer = false,
            },
            -- Neovim LSP
            -- https://neovim.io/doc/user/lsp.html
            lsp = {
              on = true,
              defer = false,
            },
            -- Lualine
            -- https://github.com/nvim-lualine/lualine.nvim
            lualine = {
              on = true,
              defer = false,
            },
            -- Neovim Pi_paren plugin
            -- https://neovim.io/doc/user/pi_paren.html
            matchparen = {
              on = true,
              defer = false,
            },
            -- Neovim syntax
            -- https://neovim.io/doc/user/syntax.html
            syntax = {
              on = true,
              defer = true,
            },
            -- Neovim treesitter
            -- https://neovim.io/doc/user/treesitter.html
            treesitter = {
              on = true,
              defer = false,
            },
            -- Neovim options that affect speed when big file is opened:
            -- swapfile, foldmethod, undolevels, undoreload, list
            vimopts = {
              on = true,
              defer = false,
            },
          },
        }
      end,
    },
    -- IMAGE PREVIEW
    {
      '3rd/image.nvim',
      commit = '52cf96d',
      config = function()
        require('image').setup {
          backend = 'kitty',
          integrations = {
            markdown = {
              enabled = true,
              clear_in_insert_mode = true,
              download_remote_images = true,
              only_render_image_at_cursor = true,
              filetypes = { 'markdown', 'vimwiki' }, -- markdown extensions (ie. quarto) can go here
            },
            neorg = {
              enabled = true,
              clear_in_insert_mode = true,
              download_remote_images = true,
              only_render_image_at_cursor = true,
              filetypes = { 'norg' },
            },
          },
          max_width = nil,
          max_height = nil,
          max_width_window_percentage = nil,
          max_height_window_percentage = 50,
          window_overlap_clear_enabled = false, -- toggles images when windows are overlapped
          window_overlap_clear_ft_ignore = { 'cmp_menu', 'cmp_docs', '' },
          editor_only_render_when_focused = false, -- auto show/hide images when the editor gains/looses focus
          tmux_show_only_in_active_window = false, -- auto show/hide images in the correct Tmux window (needs visual-activity off)
          hijack_file_patterns = { '*.png', '*.jpg', '*.jpeg', '*.gif', '*.webp' }, -- render image files as images when opened
        }
      end,
    },
    -- Here is a more advanced example where we pass configuration
    -- options to `gitsigns.nvim`. This is equivalent to the following Lua:
    --    require('gitsigns').setup({ ... })
    --
    -- See `:help gitsigns` to understand what the configuration keys do
    { -- Adds git related signs to the gutter, as well as utilities for managing changes
      'lewis6991/gitsigns.nvim',

      config = function()
        require('gitsigns').setup {

          signs = {
            add = { text = '┃' },
            change = { text = '┃' },
            delete = { text = '_' },
            topdelete = { text = '‾' },
            changedelete = { text = '~' },
            untracked = { text = '┆' },
          },
          signcolumn = true, -- Toggle with `:Gitsigns toggle_signs`
          numhl = false, -- Toggle with `:Gitsigns toggle_numhl`
          linehl = false, -- Toggle with `:Gitsigns toggle_linehl`
          word_diff = false, -- Toggle with `:Gitsigns toggle_word_diff`
          watch_gitdir = {
            follow_files = true,
          },
          auto_attach = true,
          attach_to_untracked = false,
          current_line_blame = false, -- Toggle with `:Gitsigns toggle_current_line_blame`
          current_line_blame_opts = {
            virt_text = true,
            virt_text_pos = 'eol', -- 'eol' | 'overlay' | 'right_align'
            delay = 1000,
            ignore_whitespace = false,
            virt_text_priority = 100,
          },
          current_line_blame_formatter = '<author>, <author_time:%Y-%m-%d> - <summary>',
          current_line_blame_formatter_opts = {
            relative_time = false,
          },
          sign_priority = 6,
          update_debounce = 100,
          status_formatter = nil, -- Use default
          max_file_length = 40000, -- Disable if file is longer than this (in lines)
          preview_config = {
            -- Options passed to nvim_open_win
            border = 'single',
            style = 'minimal',
            relative = 'cursor',
            row = 0,
            col = 1,
          },
        }
      end,
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

    -- VENV SWITCHER

    -- debugging

    { 'rcarriga/nvim-dap-ui', dependencies = { 'mfussenegger/nvim-dap', 'nvim-neotest/nvim-nio' } },

    {
      'linux-cultist/venv-selector.nvim',
      branch = 'regexp',
      dependencies = { 'neovim/nvim-lspconfig', 'nvim-telescope/telescope.nvim', 'mfussenegger/nvim-dap-python' },
      opts = {
        -- Your options go here
        venvwrapper_path = '~/Documents/venv/',
        auto_refresh = true,
      },
      event = 'VeryLazy', -- Optional: needed only if you want to type `:VenvSelect` without a keymapping
      keys = {
        -- Keymap to open VenvSelector to pick a venv.
        { '<leader>vs', '<cmd>VenvSelect<cr>' },
        -- Keymap to retrieve the venv from a cache (the one previously used for the same project directory).
        { '<leader>vc', '<cmd>VenvSelectCached<cr>' },
      },
    },
    {
      'nvim-neo-tree/neo-tree.nvim',
      branch = 'v3.x',
      requires = {
        'nvim-lua/plenary.nvim',
        'nvim-tree/nvim-web-devicons', -- not strictly required, but recommended
        'MunifTanjim/nui.nvim',
        '3rd/image.nvim', -- Optional image support in preview window: See `# Preview Mode` for more information
      },
      {
        's1n7ax/nvim-window-picker',
        version = '2.*',
        config = function()
          require('window-picker').setup {
            filter_rules = {
              include_current_win = false,
              autoselect_one = true,
              -- filter using buffer options
              bo = {
                -- if the file type is one of following, the window will be ignored
                filetype = { 'neo-tree', 'neo-tree-popup', 'notify' },
                -- if the buffer type is one of following, the window will be ignored
                buftype = { 'terminal', 'quickfix' },
              },
            },
          }
        end,
      },
      config = function()
        -- If you want icons for diagnostic errors, you'll need to define them somewhere:
        vim.fn.sign_define('DiagnosticSignError', { text = ' ', texthl = 'DiagnosticSignError' })
        vim.fn.sign_define('DiagnosticSignWarn', { text = ' ', texthl = 'DiagnosticSignWarn' })
        vim.fn.sign_define('DiagnosticSignInfo', { text = ' ', texthl = 'DiagnosticSignInfo' })
        vim.fn.sign_define('DiagnosticSignHint', { text = '󰌵', texthl = 'DiagnosticSignHint' })

        require('neo-tree').setup {
          close_if_last_window = false, -- Close Neo-tree if it is the last window left in the tab
          popup_border_style = 'rounded',
          enable_git_status = true,
          enable_diagnostics = true,
          enable_normal_mode_for_inputs = false, -- Enable normal mode for input dialogs.
          open_files_do_not_replace_types = { 'terminal', 'trouble', 'qf' }, -- when opening files, do not use windows containing these filetypes or buftypes
          sort_case_insensitive = false, -- used when sorting files and directories in the tree
          sort_function = nil, -- use a custom function for sorting files and directories in the tree
          -- sort_function = function (a,b)
          --       if a.type == b.type then
          --           return a.path > b.path
          --       else
          --           return a.type > b.type
          --       end
          --   end , -- this sorts files and directories descendantly
          default_component_configs = {
            container = {
              enable_character_fade = true,
            },
            indent = {
              indent_size = 2,
              padding = 1, -- extra padding on left hand side
              -- indent guides
              with_markers = true,
              indent_marker = '│',
              last_indent_marker = '└',
              highlight = 'NeoTreeIndentMarker',
              -- expander config, needed for nesting files
              with_expanders = nil, -- if nil and file nesting is enabled, will enable expanders
              expander_collapsed = '',
              expander_expanded = '',
              expander_highlight = 'NeoTreeExpander',
            },
            icon = {
              folder_closed = '',
              folder_open = '',
              folder_empty = '󰜌',
              -- The next two settings are only a fallback, if you use nvim-web-devicons and configure default icons there
              -- then these will never be used.
              default = '*',
              highlight = 'NeoTreeFileIcon',
            },
            modified = {
              symbol = '[+]',
              highlight = 'NeoTreeModified',
            },
            name = {
              trailing_slash = false,
              use_git_status_colors = true,
              highlight = 'NeoTreeFileName',
            },
            git_status = {
              symbols = {
                -- Change type
                added = '', -- or "✚", but this is redundant info if you use git_status_colors on the name
                modified = '', -- or "", but this is redundant info if you use git_status_colors on the name
                deleted = '✖', -- this can only be used in the git_status source
                renamed = '󰁕', -- this can only be used in the git_status source
                -- Status type
                untracked = '',
                ignored = '',
                unstaged = '󰄱',
                staged = '',
                conflict = '',
              },
            },
            -- If you don't want to use these columns, you can set `enabled = false` for each of them individually
            file_size = {
              enabled = true,
              required_width = 64, -- min width of window required to show this column
            },
            type = {
              enabled = true,
              required_width = 122, -- min width of window required to show this column
            },
            last_modified = {
              enabled = true,
              required_width = 88, -- min width of window required to show this column
            },
            created = {
              enabled = true,
              required_width = 110, -- min width of window required to show this column
            },
            symlink_target = {
              enabled = false,
            },
          },
          -- A list of functions, each representing a global custom command
          -- that will be available in all sources (if not overridden in `opts[source_name].commands`)
          -- see `:h neo-tree-custom-commands-global`
          commands = {},
          window = {
            position = 'left',
            width = 40,
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
              ['<esc>'] = 'cancel', -- close preview or floating neo-tree window
              ['P'] = { 'toggle_preview', config = { use_float = true, use_image_nvim = true } },
              -- Read `# Preview Mode` for more information
              ['l'] = 'focus_preview',
              ['S'] = 'open_split',
              ['s'] = 'open_vsplit',
              -- ["S"] = "split_with_window_picker",
              -- ["s"] = "vsplit_with_window_picker",
              ['t'] = 'open_tabnew',
              -- ["<cr>"] = "open_drop",
              -- ["t"] = "open_tab_drop",
              ['w'] = 'open_with_window_picker',
              --["P"] = "toggle_preview", -- enter preview mode, which shows the current node without focusing
              ['C'] = 'close_node',
              -- ['C'] = 'close_all_subnodes',
              ['z'] = 'close_all_nodes',
              --["Z"] = "expand_all_nodes",
              ['a'] = {
                'add',
                -- this command supports BASH style brace expansion ("x{a,b,c}" -> xa,xb,xc). see `:h neo-tree-file-actions` for details
                -- some commands may take optional config options, see `:h neo-tree-mappings` for details
                config = {
                  show_path = 'none', -- "none", "relative", "absolute"
                },
              },
              ['A'] = 'add_directory', -- also accepts the optional config.show_path option like "add". this also supports BASH style brace expansion.
              ['d'] = 'delete',
              ['r'] = 'rename',
              ['y'] = 'copy_to_clipboard',
              ['x'] = 'cut_to_clipboard',
              ['p'] = 'paste_from_clipboard',
              ['c'] = 'copy', -- takes text input for destination, also accepts the optional config.show_path option like "add":
              -- ["c"] = {
              --  "copy",
              --  config = {
              --    show_path = "none" -- "none", "relative", "absolute"
              --  }
              --}
              ['m'] = 'move', -- takes text input for destination, also accepts the optional config.show_path option like "add".
              ['q'] = 'close_window',
              ['R'] = 'refresh',
              ['?'] = 'show_help',
              ['<'] = 'prev_source',
              ['>'] = 'next_source',
              ['i'] = 'show_file_details',
            },
          },
          nesting_rules = {},
          filesystem = {
            filtered_items = {
              visible = false, -- when true, they will just be displayed differently than normal items
              hide_dotfiles = true,
              hide_gitignored = true,
              hide_hidden = true, -- only works on Windows for hidden files/directories
              hide_by_name = {
                --"node_modules"
              },
              hide_by_pattern = { -- uses glob style patterns
                --"*.meta",
                --"*/src/*/tsconfig.json",
              },
              always_show = { -- remains visible even if other settings would normally hide it
                --".gitignored",
              },
              never_show = { -- remains hidden even if visible is toggled to true, this overrides always_show
                --".DS_Store",
                --"thumbs.db"
              },
              never_show_by_pattern = { -- uses glob style patterns
                --".null-ls_*",
              },
            },
            follow_current_file = {
              enabled = false, -- This will find and focus the file in the active buffer every time
              --               -- the current file is changed while the tree is open.
              leave_dirs_open = false, -- `false` closes auto expanded dirs, such as with `:Neotree reveal`
            },
            group_empty_dirs = false, -- when true, empty folders will be grouped together
            hijack_netrw_behavior = 'open_default', -- netrw disabled, opening a directory opens neo-tree
            -- in whatever position is specified in window.position
            -- "open_current",  -- netrw disabled, opening a directory opens within the
            -- window like netrw would, regardless of window.position
            -- "disabled",    -- netrw left alone, neo-tree does not handle opening dirs
            use_libuv_file_watcher = false, -- This will use the OS level file watchers to detect changes
            -- instead of relying on nvim autocmd events.
            window = {
              mappings = {
                ['<bs>'] = 'navigate_up',
                ['.'] = 'set_root',
                ['H'] = 'toggle_hidden',
                ['/'] = 'fuzzy_finder',
                ['D'] = 'fuzzy_finder_directory',
                ['#'] = 'fuzzy_sorter', -- fuzzy sorting using the fzy algorithm
                -- ["D"] = "fuzzy_sorter_directory",
                ['f'] = 'filter_on_submit',
                ['<c-x>'] = 'clear_filter',
                ['[g'] = 'prev_git_modified',
                [']g'] = 'next_git_modified',
                ['o'] = { 'show_help', nowait = false, config = { title = 'Order by', prefix_key = 'o' } },
                ['oc'] = { 'order_by_created', nowait = false },
                ['od'] = { 'order_by_diagnostics', nowait = false },
                ['og'] = { 'order_by_git_status', nowait = false },
                ['om'] = { 'order_by_modified', nowait = false },
                ['on'] = { 'order_by_name', nowait = false },
                ['os'] = { 'order_by_size', nowait = false },
                ['ot'] = { 'order_by_type', nowait = false },
                -- ['<key>'] = function(state) ... end,
              },
              fuzzy_finder_mappings = { -- define keymaps for filter popup window in fuzzy_finder_mode
                ['<down>'] = 'move_cursor_down',
                ['<C-n>'] = 'move_cursor_down',
                ['<up>'] = 'move_cursor_up',
                ['<C-p>'] = 'move_cursor_up',
                -- ['<key>'] = function(state, scroll_padding) ... end,
              },
            },

            commands = {}, -- Add a custom command or override a global one using the same function name
          },
          buffers = {
            follow_current_file = {
              enabled = true, -- This will find and focus the file in the active buffer every time
              --              -- the current file is changed while the tree is open.
              leave_dirs_open = false, -- `false` closes auto expanded dirs, such as with `:Neotree reveal`
            },
            group_empty_dirs = true, -- when true, empty folders will be grouped together
            show_unloaded = true,
            window = {
              mappings = {
                ['bd'] = 'buffer_delete',
                ['<bs>'] = 'navigate_up',
                ['.'] = 'set_root',
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
              position = 'float',
              mappings = {
                ['A'] = 'git_add_all',
                ['gu'] = 'git_unstage_file',
                ['ga'] = 'git_add_file',
                ['gr'] = 'git_revert_file',
                ['gc'] = 'git_commit',
                ['gp'] = 'git_push',
                ['gg'] = 'git_commit_and_push',
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
        }

        vim.cmd [[nnoremap \ :Neotree reveal<cr>]]
      end,
    },

    -- GO

    {
      'ray-x/go.nvim',
      dependencies = { -- optional packages
        'ray-x/guihua.lua',
        'neovim/nvim-lspconfig',
        'nvim-treesitter/nvim-treesitter',
      },
      config = function()
        require('go').setup {
          verbose = false,
          lsp_cfg = false,
        }
      end,
      event = { 'CmdlineEnter' },
      ft = { 'go', 'gomod' },
      build = ':lua require("go.install").update_all_sync()',
    },

    { -- Linting
      'mfussenegger/nvim-lint',
      event = { 'BufReadPre', 'BufNewFile' },
      config = function()
        local lint = require 'lint'
        lint.linters_by_ft = {
          clojure = { 'clj-kondo' },
          dockerfile = { 'hadolint' },
          inko = { 'inko' },
          janet = { 'janet' },
          json = { 'jsonlint' },
          markdown = { 'vale' },
          rst = { 'vale' },
          ruby = { 'ruby' },
          terraform = { 'tflint' },
          text = { 'vale' },
        }

        -- To allow other plugins to add linters to require('lint').linters_by_ft,
        -- instead set linters_by_ft like this:
        -- lint.linters_by_ft = lint.linters_by_ft or {}
        -- lint.linters_by_ft['markdown'] = { 'markdownlint' }
        --
        -- However, note that this will enable a set of default linters,
        -- which will cause errors unless these tools are available:
        --
        -- You can disable the default linters by setting their filetypes to nil:
        -- lint.linters_by_ft['clojure'] = nil
        -- lint.linters_by_ft['dockerfile'] = nil
        -- lint.linters_by_ft['inko'] = nil
        -- lint.linters_by_ft['janet'] = nil
        -- lint.linters_by_ft['json'] = nil
        -- lint.linters_by_ft['markdown'] = nil
        -- lint.linters_by_ft['rst'] = nil
        -- lint.linters_by_ft['ruby'] = nil
        -- lint.linters_by_ft['terraform'] = nil
        -- lint.linters_by_ft['text'] = nil

        -- Create autocommand which carries out the actual linting
        -- on the specified events.
        local lint_augroup = vim.api.nvim_create_augroup('lint', { clear = true })
        vim.api.nvim_create_autocmd({ 'BufEnter', 'BufWritePost', 'InsertLeave' }, {
          group = lint_augroup,
          callback = function()
            require('lint').try_lint()
          end,
        })
        -- Set pylint to work in virtualenv
        require('lint').linters.pylint.cmd = 'python'
        require('lint').linters.pylint.args = { '-m', 'pylint', '-f', 'json' }
      end,
    },

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
        }
      end,
    },
    {
      'NeogitOrg/neogit',
      dependencies = {
        'nvim-lua/plenary.nvim', -- required
        'sindrets/diffview.nvim', -- optional - Diff integration

        -- Only one of these is needed, not both.
        'nvim-telescope/telescope.nvim', -- optional
        'ibhagwan/fzf-lua', -- optional
      },
      config = function()
        require('neogit').setup { config = true }
      end,
    },
    { 'sitiom/nvim-numbertoggle' },
    {
      'brenoprata10/nvim-highlight-colors',
      config = function()
        require('nvim-highlight-colors').setup {
          ---Render style
          ---@usage 'background'|'foreground'|'virtual'
          render = 'background',

          ---Set virtual symbol (requires render to be set to 'virtual')
          virtual_symbol = '■',

          ---Highlight named colors, e.g. 'green'
          enable_named_colors = true,

          ---Highlight tailwind colors, e.g. 'bg-blue-500'
          enable_tailwind = true,

          ---Set custom colors
          ---Label must be properly escaped with '%' to adhere to `string.gmatch`
          --- :help string.gmatch
          custom_colors = {
            { label = '%-%-theme%-primary%-color', color = '#0f1219' },
            { label = '%-%-theme%-secondary%-color', color = '#5a5d64' },
          },
        }
      end,
    },
    {
      'tris203/precognition.nvim',
      event = 'VeryLazy',
      config = function()
        require('precognition').setup {
          highlightColor = { link = 'Comment' },
        }
      end,
    },
    {
      'theHamsta/nvim-dap-virtual-text',
      dependencies = {
        'mfussenegger/nvim-dap',
        'rcarriga/nvim-dap-ui',
      },
      config = function()
        require('nvim-dap-virtual-text').setup {}
      end,
    },
    -- {
    --   'Exafunction/codeium.vim',
    --   dependencies = {
    --     'nvim-lua/plenary.nvim',
    --     'hrsh7th/nvim-cmp',
    --   },
    --   config = function()
    --     require('codeium').setup {
    --       config_path = home .. '/.codeium/config.json',
    --       enable_chat = true,
    --     }
    --     -- Change '<C-g>' here to any keycode you like.
    --   end,
    -- },
    {
      'xiyaowong/transparent.nvim',
      config = function()
        require('transparent').setup {
          vim.api.nvim_command ':TransparentEnable',
          -- Optional, you don't have to run setup.
          clear_prefix = 'lualine',
          groups = { -- table: default groups
            'Normal',
            'NormalNC',
            'Comment',
            'Constant',
            'Special',
            'Identifier',
            'Statement',
            'PreProc',
            'Type',
            'Underlined',
            'Todo',
            'String',
            'Function',
            'Conditional',
            'Repeat',
            'Operator',
            'Structure',
            'LineNr',
            'NonText',
            'SignColumn',
            'CursorLine',
            'CursorLineNr',
            'StatusLine',
            'StatusLineNC',
            'EndOfBuffer',
          },
          extra_groups = {
            'NormalFloat', -- plugins which have float panel such as Lazy, Mason, LspInfo
            'NvimTreeNormal',
            'Float',
            'NvimTreeWinSeparator',
            'WinBar',
            'NoiceCmdlinePopupBorderCmdline',
            'NoiceCmdline',
            'MiniStatuslineModeNormal',
            'StatusLineNC',
            'StatusLine',
            'NoiceCmdlineIcon',
            'NoiceCmdlineIconCalculator',
            'NoiceCmdlinePopupTitle',
            'WinBarNC',
            'FloatBorder',
            'FoldColumn',
            'Folded',
            'NormalFloat',
            'Pmenu',
            'PmenuSbar',
            'PmenuThumb',
            'WinSeparator',
            'SignColumn',
            'NvimTreeNormalNC',
            'PmenuSel',
            'NvimTreeNormal',
            'NeoTreeNormal',
            'NeoTreeFloatBorder',
            'NeoTreeNormalNC',
            'NotifyINFOBody',
            'NotifyERRORBody',
            'NotifyWARNBody',
            'NotifyDEBUGBody',
            'NotifyTRACEBody',
            'NotifyINFOBorder',
            'NotifyERRORBorder',
            'NotifyWARNBorder',
            'NotifyDEBUGBorder',
            'NotifyTRACEBorder',
            'WhichKeyFloat',
            'TelescopeNormal',
            'TelescopePromptNormal',
            'TelescopePreviewNormal',
            'TelescopeResultsNormal',
            'NvimTreeEndOfBuffer',
          }, -- table: additional groups that should be cleared
          exclude_groups = {}, -- table: groups you don't want to clear
        }
      end,
    },
    {
      'fedepujol/move.nvim',
      config = function()
        require('move').setup {
          line = {
            enable = true, -- Enables line movement
            indent = true, -- Toggles indentation
          },
          block = {
            enable = true, -- Enables block movement
            indent = true, -- Toggles indentation
          },
          word = {
            enable = true, -- Enables word movement
          },
          char = {
            enable = true, -- Enables char movement
          },
        }
        local opts = { noremap = true, silent = true }
        -- Normal-mode commands
        vim.keymap.set('n', '<A-j>', ':MoveLine(1)<CR>', opts)
        vim.keymap.set('n', '<A-k>', ':MoveLine(-1)<CR>', opts)
        vim.keymap.set('n', '<A-h>', ':MoveHChar(-1)<CR>', opts)
        vim.keymap.set('n', '<A-l>', ':MoveHChar(1)<CR>', opts)
        vim.keymap.set('n', '<leader>wf', ':MoveWord(1)<CR>', opts)
        vim.keymap.set('n', '<leader>wb', ':MoveWord(-1)<CR>', opts)

        -- Visual-mode commands
        vim.keymap.set('v', '<A-j>', ':MoveBlock(1)<CR>', opts)
        vim.keymap.set('v', '<A-k>', ':MoveBlock(-1)<CR>', opts)

        vim.keymap.set('n', '<lt>', '<lt><lt>', { silent = true, desc = 'Outdent' })

        vim.keymap.set('n', '>', '>>', { silent = true, desc = 'Indent' })

        vim.keymap.set('v', '<lt>', '<lt>gv', { silent = true, desc = 'Indent' })

        vim.keymap.set('v', '>', '>gv', { silent = true, desc = 'Indent' })
      end,
    },
    {
      'linrongbin16/lsp-progress.nvim',
      config = function()
        require('lsp-progress').setup {
          client_format = function(client_name, spinner, series_messages)
            if #series_messages == 0 then
              return nil
            end
            return {
              name = client_name,
              body = spinner .. ' ' .. table.concat(series_messages, ', '),
            }
          end,
          format = function(client_messages)
            -- @param name string
            -- @param msg string?
            -- @return string
            local function stringify(name, msg)
              return msg and string.format('%s', name) or string.format('%s', name)
            end

            local lsp_clients = vim.lsp.get_clients()
            local client_names = {}

            for _, cli in ipairs(lsp_clients) do
              if type(cli) == 'table' and type(cli.name) == 'string' and string.len(cli.name) > 0 then
                table.insert(client_names, cli.name)
              end
            end

            local sign = '  LSP' -- nf-fa-gear \
            local messages_map = {}

            for _, climsg in ipairs(client_messages) do
              messages_map[climsg.name] = climsg.body
            end

            if #lsp_clients > 0 then
              table.sort(lsp_clients, function(a, b)
                return a.name < b.name
              end)

              local builder = {}
              for _, name in ipairs(client_names) do
                if messages_map[name] then
                  table.insert(builder, stringify(name, messages_map[name]))
                else
                  table.insert(builder, stringify(name))
                end
              end

              if #builder > 0 then
                return sign .. ' [' .. table.concat(builder, ', ') .. ']'
              end
            end

            return ''
          end,
        }
      end,
    },
    {
      'folke/noice.nvim',
      dependencies = {
        -- if you lazy-load any plugin below, make sure to add proper `module="..."` entries
        'MunifTanjim/nui.nvim',
        'rcarriga/nvim-notify',
      },
      init = function()
        require('notify').setup {
          background_colour = '#000000',
          timeout = 3000,
          render = 'compact',
          stages = 'fade',
          top_down = false,
        }
      end,

      config = function()
        require('noice').setup {
          presets = { inc_rename = true },
          cmdline = {
            enabled = true, -- enables the Noice cmdline UI
            view = 'cmdline_popup', -- view for rendering the cmdline. Change to `cmdline` to get a classic cmdline at the bottom
            opts = {}, -- global options for the cmdline. See section on views
            ---@type table<string, CmdlineFormat>
            format = {
              -- conceal: (default=true) This will hide the text in the cmdline that matches the pattern.
              -- view: (default is cmdline view)
              -- opts: any options passed to the view
              -- icon_hl_group: optional hl_group for the icon
              -- title: set to anything or empty string to hide
              cmdline = { pattern = '^:', icon = '', lang = 'vim' },
              search_down = { kind = 'search', pattern = '^/', icon = ' ', lang = 'regex' },
              search_up = { kind = 'search', pattern = '^%?', icon = ' ', lang = 'regex' },
              filter = { pattern = '^:%s*!', icon = '$', lang = 'bash' },
              lua = { pattern = { '^:%s*lua%s+', '^:%s*lua%s*=%s*', '^:%s*=%s*' }, icon = '', lang = 'lua' },
              help = { pattern = '^:%s*he?l?p?%s+', icon = '' },
              input = {}, -- Used by input()
              -- lua = false, -- to disable a format, set to `false`
            },
          },
          messages = {
            -- NOTE: If you enable messages, then the cmdline is enabled automatically.
            -- This is a current Neovim limitation.
            enabled = true, -- enables the Noice messages UI
            view = 'notify', -- default view for messages
            view_error = 'notify', -- view for errors
            view_warn = 'notify', -- view for warnings
            view_history = 'messages', -- view for :messages
            view_search = 'virtualtext', -- view for search count messages. Set to `false` to disable
          },
          popupmenu = {
            enabled = true, -- enables the Noice popupmenu UI
            ---@type 'nui'|'cmp'
            backend = 'nui', -- backend to use to show regular cmdline completions
            ---@type NoicePopupmenuItemKind|false
            -- Icons for completion item kinds (see defaults at noice.config.icons.kinds)
            kind_icons = {}, -- set to `false` to disable icons
          },
          -- default options for require('noice').redirect
          -- see the section on Command Redirection
          ---@type NoiceRouteConfig
          redirect = {
            view = 'popup',
            filter = { event = 'msg_show' },
          },
          notify = {
            -- Noice can be used as `vim.notify` so you can route any notification like other messages
            -- Notification messages have their level and other properties set.
            -- event is always "notify" and kind can be any log level as a string
            -- The default routes will forward notifications to nvim-notify
            -- Benefit of using Noice for this is the routing and consistent history view
            enabled = true,
            view = 'notify',
          },
          lsp = {
            progress = {
              enabled = false,
            },
            -- override markdown rendering so that **cmp** and other plugins use **Treesitter**
            override = {
              ['vim.lsp.util.convert_input_to_markdown_lines'] = true,
              ['vim.lsp.util.stylize_markdown'] = true,
              ['cmp.entry.get_documentation'] = true, -- requires hrsh7th/nvim-cmp
            },
          },
          -- you can enable a preset for easier configuration
          presets = {
            bottom_search = true, -- use a classic bottom cmdline for search
            command_palette = true, -- position the cmdline and popupmenu together
            long_message_to_split = true, -- long messages will be sent to a split
            inc_rename = true, -- enables an input dialog for inc-rename.nvim
            lsp_doc_border = false, -- add a border to hover docs and signature help
          },
        }
      end,
    },
    {
      'ThePrimeagen/harpoon',
      branch = 'harpoon2',
      commit = 'e76cb03',
      dependencies = {
        'nvim-lua/plenary.nvim',
        'letieu/harpoon-lualine',
      },
      init = function()
        -- Harpoon telescope extension
        require('telescope').load_extension 'harpoon'
      end,

      config = function()
        local harpoon = require 'harpoon'
        harpoon:setup {
          global_settings = {
            menu = {
              width = vim.api.nvim_win_get_width(0) - 4,
            },

            -- sets the marks upon calling `toggle` on the ui, instead of require `:w`.
            save_on_toggle = true,

            -- saves the harpoon file upon every change. disabling is unrecommended.
            save_on_change = true,

            -- sets harpoon to run the command immediately as it's passed to the terminal when calling `sendCommand`.
            enter_on_sendcmd = false,

            -- closes any tmux windows harpoon that harpoon creates when you close Neovim.
            tmux_autoclose_windows = false,

            -- filetypes that you want to prevent from adding to the harpoon list menu.
            excluded_filetypes = { 'harpoon' },

            -- set marks specific to each git branch inside git repository
            mark_branch = true,

            -- enable tabline with harpoon marks
            tabline = false,
            tabline_prefix = '   ',
            tabline_suffix = '   ',
          },

          vim.keymap.set('n', '<leader>h', '<cmd>Telescope harpoon marks<cr>'),
          vim.keymap.set('n', '<A-a>', function()
            harpoon:list():add()
          end, { silent = true, desc = 'Append current file to harpoon' }),
          vim.keymap.set('n', '<C-h>', function()
            harpoon.ui:toggle_quick_menu(harpoon:list())
          end, { silent = true, desc = 'Toggle harpoon quick menu' }),

          vim.keymap.set('n', '<A-b>', function()
            harpoon:list():remove()
          end, { silent = true, desc = 'Toggle to delete files from harpoon' }),

          vim.keymap.set('n', '<leader>hn', function()
            harpoon:list():next { ui_nav_wrap = true }
          end, { silent = true, desc = 'Next Section' }),

          vim.keymap.set('n', '<leader>hp', function()
            harpoon:list():prev { ui_nav_wrap = true }
          end, { silent = true, desc = 'Previous Section' }),

          vim.keymap.set('n', '<A-1>', function()
            harpoon:list():select(1)
          end, { silent = true, desc = 'Jumps to item 1 in the list' }),
          vim.keymap.set('n', '<A-2>', function()
            harpoon:list():select(2)
          end, { silent = true, desc = 'Jumps to item 2 in the list' }),
          vim.keymap.set('n', '<A-3>', function()
            harpoon:list():select(3)
          end, { silent = true, desc = 'Jumps to item 3 in the list' }),
          vim.keymap.set('n', '<A-4>', function()
            harpoon:list():select(4)
          end, { silent = true, desc = 'Jumps to item 4 in the list' }),
        }
      end,
    },
    {

      'nvim-lualine/lualine.nvim',
      dependencies = {
        'nvim-tree/nvim-web-devicons',
        'letieu/harpoon-lualine',
      },
      config = function()
        local lualine = require 'lualine'
        local colors = {
          bg = '#1e1e2e',
          fg = '#cdd6f4',
          yellow = '#f9e2af',
          cyan = '#89dceb',
          darkblue = '#89b4fa',
          green = '#a6e3a1',
          orange = '#fab387',
          violet = '#f5c2e7',
          magenta = '#cba6f7',
          blue = '#74c7ec',
          red = '#ba778a',
          lightgreen = '#4f9e6f',
        }

        local conditions = {
          hide_in_width = function()
            return vim.fn.winwidth(0) > 80
          end,
        }

        local mode_color = {
          n = colors.red,
          i = colors.green,
          v = colors.blue,
          [''] = colors.blue,
          V = colors.blue,
          c = colors.magenta,
          no = colors.red,
          s = colors.orange,
          S = colors.orange,
          [''] = colors.orange,
          ic = colors.yellow,
          R = colors.violet,
          Rv = colors.violet,
          cv = colors.red,
          ce = colors.red,
          r = colors.cyan,
          rm = colors.cyan,
          ['r?'] = colors.cyan,
          ['!'] = colors.red,
          t = colors.red,
        }

        local mode = {
          'mode',
          icon = ' ',
          separator = { left = '', right = '' },
          right_padding = 2,
          color = function()
            return { bg = mode_color[vim.fn.mode()], fg = colors.bg }
          end,
        }
        local filename = {
          'filename',
          file_status = true,
          color = { fg = colors.magenta, bg = 'None', gui = 'bold' },
        }
        local branch = {
          'branch',
          icon = '',
          color = { fg = colors.violet, bg = 'None', gui = 'bold' },
          on_click = function()
            vim.cmd 'Neogit'
          end,
        }
        local diagnostics = {
          'diagnostics',
          sources = { 'nvim_diagnostic' },
          symbols = { error = ' ', warn = ' ', info = ' ' },
          diagnostics_color = {
            color_error = { fg = colors.red, bg = 'None', gui = 'bold' },
            color_warn = { fg = colors.yellow, bg = 'None', gui = 'bold' },
            color_info = { fg = colors.cyan, bg = 'None', gui = 'bold' },
          },
          color = { bg = mode, gui = 'bold' },
        }
        local hot = {
          'Reloader',
        }
        local harpoon = {
          'harpoon2',
          icon = '󰀱',
          indicators = { '1', '2', '3', '4' },
          active_indicators = { '[1]', '[2]', '[3]', '[4]' },
          _separator = ' ',
          separator = { left = '', right = '' },
          color = function()
            return { bg = mode_color[vim.fn.mode()], fg = colors.bg, gui = 'bold' }
          end,
        }
        local diff = {
          'diff',
          symbols = { added = ' ', modified = '󰝤 ', removed = ' ' },
          diff_color = {
            added = { fg = colors.green, bg = 'None' },
            modified = { fg = colors.orange, bg = 'None' },
            removed = { fg = colors.red, bg = 'None' },
          },
          cond = conditions.hide_in_width,
        }
        local fileformat = {
          'fileformat',
          fmt = string.upper,
          color = { fg = colors.green, bg = 'None', gui = 'bold' },
        }

        local buffers = {
          function()
            local bufs = vim.api.nvim_list_bufs()
            local bufNumb = 0
            local function buffer_is_valid(buf_id, buf_name)
              return 1 == vim.fn.buflisted(buf_id) and buf_name ~= ''
            end
            for idx = 1, #bufs do
              local buf_id = bufs[idx]
              local buf_name = vim.api.nvim_buf_get_name(buf_id)
              if buffer_is_valid(buf_id, buf_name) then
                bufNumb = bufNumb + 1
              end
            end

            if bufNumb == 0 then
              return 'No buffs'
            elseif bufNumb == 1 then
              return bufNumb .. ' buff'
            else
              return bufNumb .. ' buffs'
            end
          end,
          color = { fg = colors.darkblue, bg = 'None' },
          on_click = function()
            require('buffer_manager.ui').toggle_quick_menu()
          end,
        }
        local filetype = {
          'filetype',
          icon_only = true,
          color = { fg = colors.darkblue, bg = 'None' },
        }
        local progress = {
          'progress',
          color = { fg = colors.magenta, bg = 'None' },
        }
        local location = {
          'location',
          separator = { left = '', right = '' },
          left_padding = 2,
          color = function()
            return { bg = mode_color[vim.fn.mode()], fg = colors.bg }
          end,
        }
        local sep = {
          '%=',
          color = { fg = colors.bg, bg = 'None' },
        }
        local lsp = {
          function()
            return require('lsp-progress').progress()
          end,
          color = { fg = colors.lightgreen, bg = 'None', gui = 'bold' },
        }

        lualine.setup {
          options = {
            extensions = { 'quickfix', 'fzf', 'neo-tree' },
            disabled_filetypes = {
              statusline = {
                'dashboard',
                'aerial',
                'dapui_.',
                'neo%-tree',
                'NvimTree',
              },
            },
            theme = {
              normal = {
                a = { bg = 'None', gui = 'bold' },
                b = { bg = 'None', gui = 'bold' },
                c = { bg = 'None', gui = 'bold' },
                x = { bg = 'None', gui = 'bold' },
                y = { bg = 'None', gui = 'bold' },
                z = { bg = 'None', gui = 'bold' },
              },
              insert = {
                a = { bg = 'None', gui = 'bold' },
                b = { bg = 'None', gui = 'bold' },
                c = { bg = 'None', gui = 'bold' },
                x = { bg = 'None', gui = 'bold' },
                y = { bg = 'None', gui = 'bold' },
                z = { bg = 'None', gui = 'bold' },
              },
              visual = {
                a = { bg = 'None', gui = 'bold' },
                b = { bg = 'None', gui = 'bold' },
                c = { bg = 'None', gui = 'bold' },
                x = { bg = 'None', gui = 'bold' },
                y = { bg = 'None', gui = 'bold' },
                z = { bg = 'None', gui = 'bold' },
              },
              replace = {
                a = { bg = 'None', gui = 'bold' },
                b = { bg = 'None', gui = 'bold' },
                c = { bg = 'None', gui = 'bold' },
                x = { bg = 'None', gui = 'bold' },
                y = { bg = 'None', gui = 'bold' },
                z = { bg = 'None', gui = 'bold' },
              },
              command = {
                a = { bg = 'None', gui = 'bold' },
                b = { bg = 'None', gui = 'bold' },
                c = { bg = 'None', gui = 'bold' },
                x = { bg = 'None', gui = 'bold' },
                y = { bg = 'None', gui = 'bold' },
                z = { bg = 'None', gui = 'bold' },
              },
              inactive = {
                a = { bg = 'None', gui = 'bold' },
                b = { bg = 'None', gui = 'bold' },
                c = { bg = 'None', gui = 'bold' },
                x = { bg = 'None', gui = 'bold' },
                y = { bg = 'None', gui = 'bold' },
                z = { bg = 'None', gui = 'bold' },
              },
            },
            component_separators = '',
            section_separators = { left = '', right = '' },
            always_divide_middle = false,
          },
          winbar = {
            lualine_a = {},
            lualine_b = {},
            lualine_c = {},
            lualine_x = {},
            lualine_y = {},
            lualine_z = {},
          },
          sections = {
            lualine_a = { mode },
            lualine_b = {
              filename,
              hot,
              branch,
              diff,
              {
                require('noice').api.status.command.get,
                cond = require('noice').api.status.command.has,
                color = { fg = '#ba778a' },
              },
            },
            lualine_c = {
              diagnostics,
              sep,
              harpoon,
            },
            lualine_x = { fileformat, lsp },
            lualine_y = { buffers, { 'filetype', cond = nil, padding = { left = 1, right = 1 }, color = { fg = colors.darkblue, bg = 'None' } }, progress },
            lualine_z = { location },
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
        }
      end,
    },

    -- DASHBOARD
    {

      'goolord/alpha-nvim',
      dependencies = {
        'nvim-tree/nvim-web-devicons',
        'nvim-lua/plenary.nvim',
      },
      config = function()
        local alpha = require 'alpha'
        local dashboard = require 'alpha.themes.dashboard'
        _Gopts = {
          position = 'center',
          hl = 'Type',
          wrap = 'overflow',
        }

        -- DASHBOARD HEADER

        local function getGreeting(name)
          local tableTime = os.date '*t'
          local datetime = os.date ' %Y-%m-%d-%A   %H:%M:%S '
          local hour = tableTime.hour
          local greetingsTable = {
            [1] = '  Sleep well',
            [2] = '  Good morning',
            [3] = '  Good afternoon',
            [4] = '  Good evening',
            [5] = '󰖔  Good night',
          }
          local greetingIndex = 0
          if hour == 23 or hour < 7 then
            greetingIndex = 1
          elseif hour < 12 then
            greetingIndex = 2
          elseif hour >= 12 and hour < 18 then
            greetingIndex = 3
          elseif hour >= 18 and hour < 21 then
            greetingIndex = 4
          elseif hour >= 21 then
            greetingIndex = 5
          end
          return datetime .. '  ' .. greetingsTable[greetingIndex] .. ', ' .. name
        end

        local logo = [[
        


                                              
       ████ ██████           █████      ██
      ███████████             █████ 
      █████████ ███████████████████ ███   ███████████
     █████████  ███    █████████████ █████ ██████████████
    █████████ ██████████ █████████ █████ █████ ████ █████
  ███████████ ███    ███ █████████ █████ █████ ████ █████
 ██████  █████████████████████ ████ █████ █████ ████ ██████

      ]]

        local userName = 'Lazy'
        local greeting = getGreeting(userName)
        local marginBottom = 0
        dashboard.section.header.val = vim.split(logo, '\n')
        -- Split logo into lines
        local logoLines = {}
        for line in logo:gmatch '[^\r\n]+' do
          table.insert(logoLines, line)
        end

        -- Calculate padding for centering the greeting
        local logoWidth = logo:find '\n' - 1 -- Assuming the logo width is the width of the first line
        local greetingWidth = #greeting
        local padding = math.floor((logoWidth - greetingWidth) / 2)

        -- Generate spaces for padding
        local paddedGreeting = string.rep(' ', padding) .. greeting

        -- Add margin lines below the padded greeting
        local margin = string.rep('\n', marginBottom)

        -- Concatenate logo, padded greeting, and margin
        local adjustedLogo = logo .. '\n' .. paddedGreeting .. margin

        dashboard.section.buttons.val = {
          dashboard.button('n', '  New file', ':ene <BAR> startinsert <CR>'),
          dashboard.button('f', '  Find file', ':cd $HOME | silent Telescope find_files hidden=true no_ignore=true <CR>'),
          dashboard.button('t', '  Find text', ':Telescope live_grep <CR>'),
          dashboard.button('r', '󰄉  Recent files', ':Telescope oldfiles <CR>'),
          dashboard.button('u', '󱐥  Update plugins', '<cmd>Lazy update<CR>'),
          dashboard.button('c', '  Settings', ':e $HOME/.config/nvim/init.lua<CR>'),
          dashboard.button('p', '  Projects', ':e $HOME/Documents/github <CR>'),
          dashboard.button('d', '󱗼  Dotfiles', ':e $HOME/dotfiles <CR>'),
          dashboard.button('q', '󰿅  Quit', '<cmd>qa<CR>'),
        }

        -- local function footer()
        -- 	return "Footer Text"
        -- end

        -- dashboard.section.footer.val = vim.split('\n\n' .. getGreeting 'Lazy', '\n')

        vim.api.nvim_create_autocmd('User', {
          pattern = 'LazyVimStarted',
          desc = 'Add Alpha dashboard footer',
          once = true,
          callback = function()
            local stats = require('lazy').stats()
            local ms = math.floor(stats.startuptime * 100 + 0.5) / 100
            dashboard.section.footer.val = { ' ', ' ', ' ', '  When it does not exist, design it. ' }
            vim.cmd 'highlight DashboardFooter guifg=#ba778a'
            dashboard.section.header.opts.hl = 'DashboardFooter'
            vim.cmd 'highlight Keyword guifg=#ba778a'
            dashboard.section.buttons.opts.hl = 'Keyword'

            pcall(vim.cmd.AlphaRedraw)
          end,
        })

        dashboard.opts.opts.noautocmd = true
        alpha.setup(dashboard.opts)
      end,
    },

    -- NOTE: Plugins can specify dependencies.
    --
    -- The dependencies are proper plugin specifications as well - anything
    -- you do for a plugin at the top level, you can do for a dependency.
    --
    -- Use the `dependencies` key to specify the dependencies of a particular plugin

    { 'lukas-reineke/indent-blankline.nvim', main = 'ibl', opts = {} },

    { -- Fuzzy Finder (files, lsp, etc)
      'nvim-telescope/telescope.nvim',
      event = 'VimEnter',
      branch = '0.1.x',
      dependencies = {
        'nvim-lua/plenary.nvim',
        { -- If encountering errors, see telescope-fzf-native README for installation instructions
          'nvim-telescope/telescope-fzf-native.nvim',

          -- `build` is used to run some command when the plugin is installed/updated.
          -- This is only run then, not every time Neovim starts up.
          build = 'make',

          -- `cond` is a condition used to determine whether this plugin should be
          -- installed and loaded.
          cond = function()
            return vim.fn.executable 'make' == 1
          end,
        },
        { 'nvim-telescope/telescope-ui-select.nvim' },

        -- Useful for getting pretty icons, but requires a Nerd Font.
        { 'nvim-tree/nvim-web-devicons', enabled = vim.g.have_nerd_font },
      },
      config = function()
        -- Telescope is a fuzzy finder that comes with a lot of different things that
        -- it can fuzzy find! It's more than just a "file finder", it can search
        -- many different aspects of Neovim, your workspace, LSP, and more!
        --
        -- The easiest way to use Telescope, is to start by doing something like:
        --  :Telescope help_tags
        --
        -- After running this command, a window will open up and you're able to
        -- type in the prompt window. You'll see a list of `help_tags` options and
        -- a corresponding preview of the help.
        --
        -- Two important keymaps to use while in Telescope are:
        --  - Insert mode: <c-/>
        --  - Normal mode: ?
        --
        -- This opens a window that shows you all of the keymaps for the current
        -- Telescope picker. This is really useful to discover what Telescope can
        -- do as well as how to actually do it!

        -- [[ Configure Telescope ]]
        -- See `:help telescope` and `:help telescope.setup()`
        require('telescope').setup {
          -- You can put your default mappings / updates / etc. in here
          --  All the info you're looking for is in `:help telescope.setup()`
          --
          -- defaults = {
          --   mappings = {
          --     i = { ['<c-enter>'] = 'to_fuzzy_refine' },
          --   },
          -- },
          -- pickers = {}
          extensions = {
            ['ui-select'] = {
              require('telescope.themes').get_dropdown(),
            },
          },
        }

        -- Enable Telescope extensions if they are installed
        pcall(require('telescope').load_extension, 'fzf')
        pcall(require('telescope').load_extension, 'ui-select')

        -- See `:help telescope.builtin`
        local builtin = require 'telescope.builtin'
        vim.keymap.set('n', '<leader>sh', builtin.help_tags, { desc = '[S]earch [H]elp' })
        vim.keymap.set('n', '<leader>sk', builtin.keymaps, { desc = '[S]earch [K]eymaps' })
        vim.keymap.set('n', '<leader>sf', builtin.find_files, { desc = '[S]earch [F]iles' })
        vim.keymap.set('n', '<leader>ss', builtin.builtin, { desc = '[S]earch [S]elect Telescope' })
        vim.keymap.set('n', '<leader>sw', builtin.grep_string, { desc = '[S]earch current [W]ord' })
        vim.keymap.set('n', '<leader>sg', builtin.live_grep, { desc = '[S]earch by [G]rep' })
        vim.keymap.set('n', '<leader>sd', builtin.diagnostics, { desc = '[S]earch [D]iagnostics' })
        vim.keymap.set('n', '<leader>sr', builtin.resume, { desc = '[S]earch [R]esume' })
        vim.keymap.set('n', '<leader>s.', builtin.oldfiles, { desc = '[S]earch Recent Files ("." for repeat)' })
        vim.keymap.set('n', '<leader><leader>', builtin.buffers, { desc = '[ ] Find existing buffers' })

        -- Slightly advanced example of overriding default behavior and theme
        vim.keymap.set('n', '<leader>/', '<CMD>Telescope current_buffer_fuzzy_find<CR>')

        -- It's also possible to pass additional configuration options.
        --  See `:help telescope.builtin.live_grep()` for information about particular keys
        vim.keymap.set('n', '<leader>s/', function()
          builtin.live_grep {
            grep_open_files = true,
            prompt_title = 'Live Grep in Open Files',
          }
        end, { desc = '[S]earch [/] in Open Files' })

        -- Shortcut for searching your Neovim configuration files
        vim.keymap.set('n', '<leader>sn', function()
          builtin.find_files { cwd = vim.fn.stdpath 'config' }
        end, { desc = '[S]earch [N]eovim files' })
      end,
    },

    { -- LSP Configuration & Plugins
      'neovim/nvim-lspconfig',
      dependencies = {
        -- Automatically install LSPs and related tools to stdpath for Neovim
        'williamboman/mason.nvim',
        'williamboman/mason-lspconfig.nvim',
        'WhoIsSethDaniel/mason-tool-installer.nvim',

        -- Useful status updates for LSP.
        -- NOTE: `opts = {}` is the same as calling `require('fidget').setup({})`

        -- `neodev` configures Lua LSP for your Neovim config, runtime and plugins
        -- used for completion, annotations and signatures of Neovim apis
        { 'folke/neodev.nvim', opts = {} },
      },

      -- Use an on_attach function to only map the following keys
      -- after the language server attaches to the current buffer
      config = function()
        -- Brief aside: **What is LSP?**
        --
        -- LSP is an initialism you've probably heard, but might not understand what it is.
        --
        -- LSP stands for Language Server Protocol. It's a protocol that helps editors
        -- and language tooling communicate in a standardized fashion.
        --
        -- In general, you have a "server" which is some tool built to understand a particular
        -- language (such as `gopls`, `lua_ls`, `rust_analyzer`, etc.). These Language Servers
        -- (sometimes called LSP servers, but that's kind of like ATM Machine) are standalone
        -- processes that communicate with some "client" - in this case, Neovim!
        --
        -- LSP provides Neovim with features like:
        --  - Go to definition
        --  - Find references
        --  - Autocompletion
        --  - Symbol Search
        --  - and more!
        --
        -- Thus, Language Servers are external tools that must be installed separately from
        -- Neovim. This is where `mason` and related plugins come into play.
        --
        -- If you're wondering about lsp vs treesitter, you can check out the wonderfully
        -- and elegantly composed help section, `:help lsp-vs-treesitter`
        --  This function gets run when an LSP attaches to a particular buffer.
        --    That is to say, every time a new file is opened that is associated with
        --    an lsp (for example, opening `main.rs` is associated with `rust_analyzer`) this
        --    function will be executed to configure the current buffer
        require('lspconfig.ui.windows').default_options.border = 'rounded'
        local util = require 'lspconfig.util'

        vim.api.nvim_create_autocmd('LspAttach', {
          group = vim.api.nvim_create_augroup('kickstart-lsp-attach', { clear = true }),
          callback = function(event)
            -- NOTE: Remember that Lua is a real programming language, and as such it is possible
            -- to define small helper and utility functions so you don't have to repeat yourself.
            --
            -- In this case, we create a function that lets us more easily define mappings specific
            -- for LSP related items. It sets the mode, buffer and description for us each time.
            local map = function(keys, func, desc)
              vim.keymap.set('n', keys, func, { buffer = event.buf, desc = 'LSP: ' .. desc })
            end

            -- Jump to the definition of the word under your cursor.
            --  This is where a variable was first declared, or where a function is defined, etc.
            --  To jump back, press <C-t>.
            map('gd', require('telescope.builtin').lsp_definitions, '[G]oto [D]efinition')

            -- Find references for the word under your cursor.
            map('gr', require('telescope.builtin').lsp_references, '[G]oto [R]eferences')

            -- Jump to the implementation of the word under your cursor.
            --  Useful when your language has ways of declaring types without an actual implementation.
            map('gI', require('telescope.builtin').lsp_implementations, '[G]oto [I]mplementation')

            -- Jump to the type of the word under your cursor.
            --  Useful when you're not sure what type a variable is and you want to see
            --  the definition of its *type*, not where it was *defined*.
            map('<leader>D', require('telescope.builtin').lsp_type_definitions, 'Type [D]efinition')

            -- Fuzzy find all the symbols in your current document.
            --  Symbols are things like variables, functions, types, etc.
            map('<leader>ds', require('telescope.builtin').lsp_document_symbols, '[D]ocument [S]ymbols')

            -- Fuzzy find all the symbols in your current workspace.
            --  Similar to document symbols, except searches over your entire project.
            map('<leader>ws', require('telescope.builtin').lsp_dynamic_workspace_symbols, '[W]orkspace [S]ymbols')

            -- Rename the variable under your cursor.
            --  Most Language Servers support renaming across files, etc.
            map('<leader>rn', vim.lsp.buf.rename, '[R]e[n]ame')

            -- Execute a code action, usually your cursor needs to be on top of an error
            -- or a suggestion from your LSP for this to activate.
            map('<leader>ca', vim.lsp.buf.code_action, '[C]ode [A]ction')

            -- Opens a popup that displays documentation about the word under your cursor
            --  See `:help K` for why this keymap.
            map('K', vim.lsp.buf.hover, 'Hover Documentation')

            -- WARN: This is not Goto Definition, this is Goto Declaration.
            --  For example, in C this would take you to the header.
            map('gD', vim.lsp.buf.declaration, '[G]oto [D]eclaration')

            -- The following two autocommands are used to highlight references of the
            -- word under your cursor when your cursor rests there for a little while.
            --    See `:help CursorHold` for information about when this is executed
            --
            -- When you move your cursor, the highlights will be cleared (the second autocommand).
            local client = vim.lsp.get_client_by_id(event.data.client_id)
            if client and client.server_capabilities.documentHighlightProvider then
              vim.api.nvim_create_autocmd({ 'CursorHold', 'CursorHoldI' }, {
                buffer = event.buf,
                callback = vim.lsp.buf.document_highlight,
              })

              vim.api.nvim_create_autocmd({ 'CursorMoved', 'CursorMovedI' }, {
                buffer = event.buf,
                callback = vim.lsp.buf.clear_references,
              })
            end
          end,
        })

        -- LSP servers and clients are able to communicate to each other what features they support.
        --  By default, Neovim doesn't support everything that is in the LSP specification.
        --  When you add nvim-cmp, luasnip, etc. Neovim now has *more* capabilities.
        --  So, we create new capabilities with nvim cmp, and then broadcast that to the servers.
        local capabilities = vim.lsp.protocol.make_client_capabilities()
        capabilities = vim.tbl_deep_extend('force', capabilities, require('cmp_nvim_lsp').default_capabilities())

        -- Enable the following language servers
        --  Feel free to add/remove any LSPs that you want here. They will automatically be installed.
        --
        --  Add any additional override configuration in the following tables. Available keys are:
        --  - cmd (table): Override the default command used to start the server
        --  - filetypes (table): Override the default list of associated filetypes for the server
        --  - capabilities (table): Override fields in capabilities. Can be used to disable certain LSP features.
        --  - settings (table): Override the default settings passed when initializing the server.
        --        For example, to see the options for `lua_ls`, you could go to: https://luals.github.io/wiki/settings/

        local servers = {
          -- ... etc. See `:help lspconfig-all` for a list of all the pre-configured LSPs
          --
          -- Some languages (like typescript) have entire language plugins that can be useful:
          --    https://github.com/pmizio/typescript-tools.nvim
          --
          -- But for many setups, the LSP (`tsserver`) will work just fine

          -- clangd = {},

          templ = {},

          tailwindcss = {
            filetypes = { 'templ', 'astro', 'javascript', 'typescript', 'vue' },
            init_options = { userLanguages = { templ = 'html' } },
          },

          taplo = {},

          ltex = {
            cmd = { 'ltex-ls' },
            {
              'bib',
              'gitcommit',
              'markdown',
              'org',
              'plaintex',
              'rst',
              'rnoweb',
              'tex',
              'pandoc',
              'quarto',
              'rmd',
              'context',
              'html',
              'xhtml',
              'mail',
              'text',
            },
            flags = { debounce_text_changes = 300 },
            settings = {
              ltex = {
                language = 'en-GB',
                enabled = {
                  'bibtex',
                  'gitcommit',
                  'markdown',
                  'org',
                  'tex',
                  'restructuredtext',
                  'rsweave',
                  'latex',
                  'quarto',
                  'rmd',
                  'context',
                  'xhtml',
                  'mail',
                  'plaintext',
                },
              },
            },
          },
          volar = {
            filetypes = { 'typescript', 'javascript', 'javascriptreact', 'typescriptreact', 'vue' },
            root_dir = require('lspconfig').util.root_pattern('package.json', 'vue.config.js', 'vue.config.ts', 'nuxt.config.js', 'nuxt.config.ts'),
            init_options = {
              vue = {
                hybridMode = false,
              },
              typescript = {
                tsdk = vim.fn.getcwd() .. '/node_modules/typescript/lib',
              },
            },
          },

          pyright = {},

          htmx = {
            filetypes = { 'html', 'templ' },
          },

          lua_ls = {
            -- cmd = {...},
            filetypes = { 'lua' },
            -- capabilities = {},
            settings = {
              Lua = {
                runtime = {
                  -- Tell the language server which version of Lua you're using (most likely LuaJIT)
                  version = 'LuaJIT',
                  -- Setup your lua path
                },
                completion = {
                  callSnippet = 'Both',
                },

                -- You can toggle below to ignore Lua_LS's noisy `missing-fields` warnings
                -- diagnostics = { disable = { 'missing-fields' } },
              },
            },
          },
        }

        -- Ensure the servers and tools above are installed
        --  To check the current status of installed tools and/or manually install
        --  other tools, you can run
        --    :Mason
        --
        --  You can press `g?` for help in this menu.
        require('mason').setup {
          ui = {
            border = 'rounded',
            height = 0.8,
            icons = {
              package_installed = '✓',
              package_pending = '➜',
              package_uninstalled = '✗',
            },
          },
        }

        -- You can add other tools here that you want Mason to install
        -- for you, so that they are available from within Neovim.
        local ensure_installed = vim.tbl_keys(servers or {})
        vim.list_extend(ensure_installed, {
          'pylint',
          'stylua',
          'jsonlint',
          'prettier',
          'prettierd',
          'isort',
          'black',
          'gofumpt',
          'ltex-ls',
          'goimports-reviser',
          'vale',
          'debugpy',
        })
        require('mason-tool-installer').setup { ensure_installed = ensure_installed }

        require('mason-lspconfig').setup {

          handlers = {
            function(server_name)
              local server = servers[server_name] or {}
              -- This handles overriding only values explicitly passed
              -- by the server configuration above. Useful when disabling
              -- certain features of an LSP (for example, turning off formatting for tsserver)
              server.capabilities = vim.tbl_deep_extend('force', {}, capabilities, server.capabilities or {})
              require('lspconfig')[server_name].setup(server)
            end,
          },
        }
      end,
    },

    {
      'stevearc/conform.nvim',
      enabled = true,
      event = { 'BufReadPre', 'BufNewFile' }, -- to disable, comment this out
      config = function()
        local conform = require 'conform'

        conform.setup {
          formatters_by_ft = {
            javascript = { 'prettier' },
            typescript = { 'prettier' },
            javascriptreact = { 'prettier' },
            typescriptreact = { 'prettier' },
            svelte = { 'prettier' },
            css = { 'prettier' },
            html = { 'prettier' },
            json = { 'prettier' },
            vue = { { 'prettierd', 'prettier' } },
            yaml = { 'prettier' },
            markdown = { 'prettier' },
            graphql = { 'prettier' },
            python = { 'black' },
            go = { 'gofumpt', 'goimports' },
            lua = { 'stylua' },
          },
          format_after_save = {
            lsp_fallback = true,
            async = true,
            timeout_ms = 1000,
          },
        }

        vim.keymap.set({ 'n', 'v' }, '<leader>mf', function()
          conform.format {
            lsp_fallback = true,
            async = false,
            timeout_ms = 1000,
          }
        end, { desc = 'Format file or range (in visual mode)' })
      end,
    },

    -- Autocompletion

    {
      'hrsh7th/nvim-cmp',
      event = 'InsertEnter',
      dependencies = {

        {
          'L3MON4D3/LuaSnip',
          build = (function()
            -- Build Step is needed for regex support in snippets.
            -- This step is not supported in many windows environments.
            -- Remove the below condition to re-enable on windows.
            if vim.fn.has 'win32' == 1 or vim.fn.executable 'make' == 0 then
              return
            end
            return 'make install_jsregexp'
          end)(),
          dependencies = {
            -- `friendly-snippets` contains a variety of premade snippets.
            --    See the README about individual language/framework/plugin snippets:
            --    https://github.com/rafamadriz/friendly-snippets
            {
              'rafamadriz/friendly-snippets',
              config = function()
                require('luasnip.loaders.from_vscode').lazy_load()
              end,
            },
          },
        },
        'saadparwaiz1/cmp_luasnip',
        'neovim/nvim-lspconfig',
        'hrsh7th/cmp-nvim-lsp',
        'hrsh7th/cmp-path',
        'onsails/lspkind.nvim',
        -- 'Exafunction/codeium.vim',
        'petertriho/cmp-git',
        'hrsh7th/cmp-buffer',
        'hrsh7th/cmp-cmdline',
        'onsails/lspkind.nvim',
      },
      config = function()
        local cmp = require 'cmp'
        local luasnip = require 'luasnip'
        local format = require 'cmp_git.format'
        local sort = require 'cmp_git.sort'
        luasnip.config.setup {}
        require('cmp_git').setup {
          -- defaults
          filetypes = { 'gitcommit', 'octo' },
          remotes = { 'upstream', 'origin' }, -- in order of most to least prioritized
          enableRemoteUrlRewrites = false, -- enable git url rewrites, see https://git-scm.com/docs/git-config#Documentation/git-config.txt-urlltbasegtinsteadOf
          git = {
            commits = {
              limit = 100,
              sort_by = sort.git.commits,
              format = format.git.commits,
            },
          },
          github = {

            hosts = {}, -- list of private instances of github
            issues = {
              fields = { 'title', 'number', 'body', 'updatedAt', 'state' },
              filter = 'all', -- assigned, created, mentioned, subscribed, all, repos
              limit = 100,
              state = 'open', -- open, closed, all
              sort_by = sort.github.issues,
              format = format.github.issues,
            },
            mentions = {
              limit = 100,
              sort_by = sort.github.mentions,
              format = format.github.mentions,
            },
            pull_requests = {
              fields = { 'title', 'number', 'body', 'updatedAt', 'state' },
              limit = 100,
              state = 'open', -- open, closed, merged, all
              sort_by = sort.github.pull_requests,
              format = format.github.pull_requests,
            },
          },
          gitlab = {
            hosts = {}, -- list of private instances of gitlab
            issues = {
              limit = 100,
              state = 'opened', -- opened, closed, all
              sort_by = sort.gitlab.issues,
              format = format.gitlab.issues,
            },
            mentions = {
              limit = 100,
              sort_by = sort.gitlab.mentions,
              format = format.gitlab.mentions,
            },
            merge_requests = {
              limit = 100,
              state = 'opened', -- opened, closed, locked, merged
              sort_by = sort.gitlab.merge_requests,
              format = format.gitlab.merge_requests,
            },
          },
          trigger_actions = {
            {
              debug_name = 'git_commits',
              trigger_character = ':',
              action = function(sources, trigger_char, callback, params, git_info)
                return sources.git:get_commits(callback, params, trigger_char)
              end,
            },
            {
              debug_name = 'gitlab_issues',
              trigger_character = '#',
              action = function(sources, trigger_char, callback, params, git_info)
                return sources.gitlab:get_issues(callback, git_info, trigger_char)
              end,
            },
            {
              debug_name = 'gitlab_mentions',
              trigger_character = '@',
              action = function(sources, trigger_char, callback, params, git_info)
                return sources.gitlab:get_mentions(callback, git_info, trigger_char)
              end,
            },
            {
              debug_name = 'gitlab_mrs',
              trigger_character = '!',
              action = function(sources, trigger_char, callback, params, git_info)
                return sources.gitlab:get_merge_requests(callback, git_info, trigger_char)
              end,
            },
            {
              debug_name = 'github_issues_and_pr',
              trigger_character = '#',
              action = function(sources, trigger_char, callback, params, git_info)
                return sources.github:get_issues_and_prs(callback, git_info, trigger_char)
              end,
            },
            {
              debug_name = 'github_mentions',
              trigger_character = '@',
              action = function(sources, trigger_char, callback, params, git_info)
                return sources.github:get_mentions(callback, git_info, trigger_char)
              end,
            },
          },
        }
        cmp.setup {
          experimental = {
            ghost_text = true,
          },
          formatting = {
            format = require('lspkind').cmp_format {
              mode = 'symbol_text',
              maxwidth = 50,
              ellipsis_char = '...',
              show_labelDetails = true,
              symbol_map = {
                Codeium = '󰚩',
                Text = '󰉿',
                Method = '󰆧',
                Function = '󰊕',
                Constructor = '',
                Field = '󰜢',
                Variable = '󰀫',
                Class = '󰠱',
                Interface = '',
                Module = '',
                Property = '󰜢',
                Unit = '󰑭',
                Value = '󰎠',
                Enum = '',
                Keyword = '󰌋',
                Snippet = '',
                Color = '󰏘',
                File = '󰈙',
                Reference = '󰈇',
                Folder = '󰉋',
                EnumMember = '',
                Constant = '󰏿',
                Struct = '󰙅',
                Event = '',
                Operator = '󰆕',
                TypeParameter = '',
              },
            },
          },

          snippet = {
            expand = function(args)
              luasnip.lsp_expand(args.body)
            end,
          },

          window = {
            completion = cmp.config.window.bordered(),
            documentation = cmp.config.window.bordered(),
          },

          completion = { completeopt = 'menu,menuone,noinsert' },

          -- For an understanding of why these mappings were
          -- chosen, you will need to read `:help ins-completion`
          --
          -- No, but seriously. Please read `:help ins-completion`, it is really good!
          mapping = cmp.mapping.preset.insert {
            -- Select the [n]ext item
            ['<C-n>'] = cmp.mapping.select_next_item(),
            -- Select the [p]revious item
            ['<C-p>'] = cmp.mapping.select_prev_item(),

            -- Scroll the documentation window [b]ack / [f]orward
            ['<C-b>'] = cmp.mapping.scroll_docs(-4),
            ['<C-f>'] = cmp.mapping.scroll_docs(4),

            -- Accept ([y]es) the completion.
            --  This will auto-import if your LSP supports it.
            --  This will expand snippets if the LSP sent a snippet.
            ['<Return>'] = cmp.mapping.confirm { select = true },

            -- Manually trigger a completion from nvim-cmp.
            --  Generally you don't need this, because nvim-cmp will display
            --  completions whenever it has completion options available.
            ['<C-Space>'] = cmp.mapping.complete {},

            -- Think of <c-l> as moving to the right of your snippet expansion.
            --  So if you have a snippet that's like:
            --  function $name($args)
            --    $body
            --  end
            --
            -- <c-l> will move you to the right of each of the expansion locations.
            -- <c-h> is similar, except moving you backwards.
            ['<C-l>'] = cmp.mapping(function()
              if luasnip.expand_or_locally_jumpable() then
                luasnip.expand_or_jump()
              end
            end, { 'i', 's' }),
            ['<C-h>'] = cmp.mapping(function()
              if luasnip.locally_jumpable(-1) then
                luasnip.jump(-1)
              end
            end, { 'i', 's' }),

            -- For more advanced Luasnip keymaps (e.g. selecting choice nodes, expansion) see:
            --    https://github.com/L3MON4D3/LuaSnip?tab=readme-ov-file#keymaps
          },

          -- Use buffer source for `/` and `?` (if you enabled `native_menu`, this won't work anymore).
          cmp.setup.cmdline({ '/', '?' }, {
            mapping = cmp.mapping.preset.cmdline(),
            sources = cmp.config.sources {
              { name = 'luasnip' },
              { name = 'path' },
              { name = 'buffer' },
            },
          }),

          -- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).

          cmp.setup.cmdline(':', {
            mapping = cmp.mapping.preset.cmdline(),
            sources = cmp.config.sources {
              { name = 'path' },
              { name = 'cmdline' },
              { name = 'buffer' },
              { name = 'luasnip' },
            },
          }),

          sources = {
            { name = 'git' },
            { name = 'nvim_lsp' },
            { name = 'luasnip' },
            { name = 'path' },
            { name = 'buffer' },
            { name = 'codeium' },
            { name = 'cmdline' },
          },
        }
      end,
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
        require('mini.ai').setup { n_lines = 500 }

        -- Add/delete/replace surroundings (brackets, quotes, etc.)
        --
        -- - saiw) - [S]urround [A]dd [I]nner [W]ord [)]Paren
        -- - sd'   - [S]urround [D]elete [']quotes
        -- - sr)'  - [S]urround [R]eplace [)] [']
        require('mini.surround').setup()

        -- Simple and easy statusline.
        --  You could remove this setup call if you don't like it,
        --  and try some other statusline plugin
        local statusline = require 'mini.statusline'
        -- set use_icons to true if you have a Nerd Font
        statusline.setup { use_icons = vim.g.have_nerd_font }

        -- You can configure sections in the statusline by overriding their
        -- default behavior. For example, here we set the section for
        -- cursor location to LINE:COLUMN
        ---@diagnostic disable-next-line: duplicate-set-field
        statusline.section_location = function()
          return '%2l:%-2v'
        end

        -- ... and there is more!
        --  Check out: https://github.com/echasnovski/mini.nvim
      end,
    },
    { -- Highlight, edit, and navigate code
      'nvim-treesitter/nvim-treesitter',
      build = ':TSUpdate',
      opts = {
        ensure_installed = { 'go', 'gotmpl', 'gomod', 'gosum', 'bash', 'c', 'html', 'lua', 'luadoc', 'markdown_inline', 'markdown', 'vim', 'vimdoc' },
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

    -- The following two comments only work if you have downloaded the kickstart repo, not just copy pasted the
    -- init.lua. If you want these files, they are in the repository, so you can just download them and
    -- place them in the correct locations.

    -- NOTE: Next step on your Neovim journey: Add/Configure additional plugins for Kickstart
    --
    --  Here are some example plugins that I've included in the Kickstart repository.
    --  Uncomment any of the lines below to enable them (you will need to restart nvim).
    --
    -- require 'kickstart.plugins.debug',
    -- require 'kickstart.plugins.indent_line',
    -- require 'kickstart.plugins.lint',

    -- NOTE: The import below can automatically add your own plugins, configuration, etc from `lua/custom/plugins/*.lua`
    --    This is the easiest way to modularize your config.
    --
    --  Uncomment the following line and add your plugins to `lua/custom/plugins/*.lua` to get going.
    --    For additional information, see `:help lazy.nvim-lazy.nvim-structuring-your-plugins`
    -- { import = 'custom.plugins' },
  },
}, {
  ui = {
    border = 'rounded',
    size = {
      width = 0.8,
      height = 0.8,
    },

    -- If you are using a Nerd Font: set icons to an empty table which will use the
    -- default lazy.nvim defined Nerd Font icons, otherwise define a unicode icons table
    icons = vim.g.have_nerd_font and {} or {
      cmd = '⌘',
      config = '🛠',
      event = '📅',
      ft = '📂',
      init = '⚙',
      keys = '🗝',
      plugin = '🔌',
      runtime = '💻',
      require = '🌙',
      source = '📄',
      start = '🚀',
      task = '📌',
      lazy = '💤 ',
    },
  },
})

-- listen lsp-progress event and refresh lualine
vim.api.nvim_create_augroup('lualine_augroup', { clear = true })
vim.api.nvim_create_autocmd('User', {
  group = 'lualine_augroup',
  pattern = 'LspProgressStatusUpdated',
  callback = require('lualine').refresh,
})

-- Theline beneath this is called `modeline`. See `:help modeline`
-- vim: ts=2 sts=2 sw=2 et
