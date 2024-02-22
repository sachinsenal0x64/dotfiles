-- Misc

vim.opt.mouse = ""
lvim.transparent_window = true
lvim.leader = "space"
lvim.colorscheme = "tokyonight-night"
vim.opt.termguicolors = true
vim.o.background = ""
lvim.transparent_window = true
lvim.builtin.lualine.sections.lualine_c = { "diff" }
lvim.builtin.treesitter.ensure_installed = { "python" }

-- No need to set style = "lvim"

local components = require("lvim.core.lualine.components")

lvim.builtin.lualine.sections.lualine_a = { "mode" }
lvim.builtin.lualine.sections.lualine_y = {
	components.spaces,
	components.location,
}

package.path = package.path .. ";" .. vim.fn.expand("$HOME") .. "/.luarocks/share/lua/5.1/?/init.lua;"

package.path = package.path .. ";" .. vim.fn.expand("$HOME") .. "/.luarocks/share/lua/5.1/?.lua;"

-- Keybindigs

lvim.keys.normal_mode["<leader>r"] = ":SymbolRenamerOpen<CR>"
lvim.keys.normal_mode["gt"] = ":BufferLineCycleNext<CR>"
lvim.keys.normal_mode["gT"] = ":BufferLineCyclePrev<CR>"
lvim.keys.normal_mode["bd"] = ":bd<CR>"
lvim.keys.normal_mode["sr"] = ":SessionsLoad<CR>"
lvim.keys.normal_mode["ss"] = ":SessionsSave<CR>"

-- Format Go code & auto import

local format_sync_grp = vim.api.nvim_create_augroup("GoImport", {})
vim.api.nvim_create_autocmd("BufWritePre", {
	pattern = "*.go",
	callback = function()
		require("go.format")
	end,
	group = format_sync_grp,
})

-- lvim.builtin.which_key.mappings["P"] = {
-- 	"<cmd>lua require'telescope'.extensions.project.project{}<CR>",
-- 	"Projects",
-- }

-- lvim.builtin.which_key.mappings = {
--["c"] = { "<cmd>bd<CR>", "Delete Buffer" },
--   ["e"] = { "<cmd>NvimTreeToggle<CR>", "Explorer" },
--   ["h"] = { '<cmd>let @/=""<CR>', "No Highlight" },
--   ["i"] = { "<cmd>Lazy install<cr>", "Install" },
--   ["z"] = { "<cmd>Lazy sync<cr>", "Sync" },
--   ["S"] = { "<cmd>Lazy clear<cr>", "Status" },
--   ["u"] = { "<cmd>Lazy update<cr>", "Update" },
-- }

-- Plugins

lvim.plugins = {

	-- COLORSCHEME

	{

		"folke/tokyonight.nvim",
		lazy = false,
		priority = 1000,
		opts = {
			transparent = true,
			styles = {
				sidebars = "transparent",
				keywords = { bold = true },
				functions = { bold = true },
				floats = "transparent",
			},
			on_colors = function(colors)
				colors.bg_statusline = colors.NONE
			end,
		},
	},

	-- YAZI FILE MANAGER

	{
		"DreamMaoMao/yazi.nvim",
		dependencies = {
			"nvim-telescope/telescope.nvim",
			"nvim-lua/plenary.nvim",
		},

		keys = {
			{ "<leader>yz", "<cmd>Yazi<CR>", desc = "Toggle Yazi" },
		},
	},

	-- NEORG ORGANIZE FILES / NOTE TAKE

	{
		"nvim-neorg/neorg",
		build = ":Neorg sync-parsers",
		-- tag = "*",
		dependencies = { "nvim-lua/plenary.nvim" },
		config = function()
			require("neorg").setup({
				load = {
					["core.defaults"] = {}, -- Loads default behaviour
					["core.concealer"] = {}, -- Adds pretty icons to your documents
					["core.dirman"] = { -- Manages Neorg workspaces
						config = {
							workspaces = {
								notes = "~/notes",
							},
						},
					},
				},
			})
		end,
	},

	-- IMAGE PREVIEW
	{
		"3rd/image.nvim",
		config = function()
			require("image").setup({
				backend = "kitty",
				integrations = {
					markdown = {
						enabled = true,
						clear_in_insert_mode = true,
						download_remote_images = true,
						only_render_image_at_cursor = true,
						filetypes = { "markdown", "vimwiki" }, -- markdown extensions (ie. quarto) can go here
					},
					neorg = {
						enabled = true,
						clear_in_insert_mode = true,
						download_remote_images = false,
						only_render_image_at_cursor = true,
						filetypes = { "norg" },
					},
				},
				max_width = nil,
				max_height = nil,
				max_width_window_percentage = nil,
				max_height_window_percentage = 50,
				window_overlap_clear_enabled = false, -- toggles images when windows are overlapped
				window_overlap_clear_ft_ignore = { "cmp_menu", "cmp_docs", "" },
				editor_only_render_when_focused = false, -- auto show/hide images when the editor gains/looses focus
				tmux_show_only_in_active_window = false, -- auto show/hide images in the correct Tmux window (needs visual-activity off)
				hijack_file_patterns = { "*.png", "*.jpg", "*.jpeg", "*.gif", "*.webp" }, -- render image files as images when opened
			})
		end,
	},

	-- DASHBOARD

	{

		"goolord/alpha-nvim",
		dependencies = {
			"nvim-tree/nvim-web-devicons",
		},
		config = function()
			local alpha = require("alpha")
			local dashboard = require("alpha.themes.dashboard")

			_Gopts = {
				position = "center",
				hl = "Type",
				wrap = "overflow",
			}

			-- DASHBOARD HEADER

			local function getGreeting(name)
				local tableTime = os.date("*t")
				local datetime = os.date(" %Y-%m-%d-%A   %H:%M:%S ")
				local hour = tableTime.hour
				local greetingsTable = {
					[1] = "  Sleep well",
					[2] = "  Good morning",
					[3] = "  Good afternoon",
					[4] = "  Good evening",
					[5] = "󰖔  Good night",
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
				return "\t\t\t" .. datetime .. "\t" .. greetingsTable[greetingIndex] .. ", " .. name
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

			local userName = "Lazy"
			local greeting = getGreeting(userName)
			local marginBottom = 0
			-- dashboard.section.header.val = vim.split(logo .. "\n" .. greeting, "\n")

			-- Split logo into lines
			local logoLines = {}
			for line in logo:gmatch("[^\r\n]+") do
				table.insert(logoLines, line)
			end

			-- Calculate padding for centering the greeting
			local logoWidth = logo:find("\n") - 1 -- Assuming the logo width is the width of the first line
			local greetingWidth = #greeting
			local padding = math.floor((logoWidth - greetingWidth) / 2)

			-- Generate spaces for padding
			local paddedGreeting = string.rep(" ", padding) .. greeting

			-- Add margin lines below the padded greeting
			local margin = string.rep("\n", marginBottom)

			-- Concatenate logo, padded greeting, and margin
			local adjustedLogo = logo .. "\n" .. paddedGreeting .. margin

			-- Set the adjusted logo with the moved greeting to the dashboard section
			dashboard.section.header.val = vim.split(adjustedLogo, "\n")

			dashboard.section.buttons.val = {
				dashboard.button("n", "  New file", ":ene <BAR> startinsert <CR>"),
				dashboard.button(
					"f",
					"  Find file",
					":cd $HOME | silent Telescope find_files hidden=true no_ignore=true <CR>"
				),
				dashboard.button("t", "  Find text", ":Telescope live_grep <CR>"),
				dashboard.button("r", "󰄉  Recent files", ":Telescope oldfiles <CR>"),
				dashboard.button("u", "󱐥  Update plugins", "<cmd>Lazy update<CR>"),
				dashboard.button("c", "  Settings", ":e $HOME/.config/lvim/config.lua<CR>"),
				dashboard.button("p", "  Projects", ":e $HOME/Documents/github <CR>"),
				dashboard.button("d", "󱗼  Dotfiles", ":e $HOME/dotfiles <CR>"),
				dashboard.button("q", "󰿅  Quit", "<cmd>qa<CR>"),
			}

			-- local function footer()
			-- 	return "Footer Text"
			-- end

			-- dashboard.section.footer.val = footer()

			dashboard.opts.opts.noautocmd = true
			alpha.setup(dashboard.opts)
		end,
	},

	-- PYTHON LSP

	{
		"pappasam/jedi-language-server",
		config = function()
			require("lspconfig").jedi_language_server.setup({
				cmd = { "jedi-language-server" },
				filetypes = { "python" },
				single_file_support = true,
				root_dir = function()
					return vim.loop.cwd()
				end,
			})
		end,
	},

	-- FORMATTNG

	{
		"stevearc/conform.nvim",
		enabled = true,
		event = { "BufReadPre", "BufNewFile" }, -- to disable, comment this out
		config = function()
			local conform = require("conform")

			conform.setup({
				formatters_by_ft = {
					javascript = { "prettier" },
					typescript = { "prettier" },
					javascriptreact = { "prettier" },
					typescriptreact = { "prettier" },
					svelte = { "prettier" },
					css = { "prettier" },
					html = { "prettier" },
					json = { "prettier" },
					yaml = { "prettier" },
					markdown = { "prettier" },
					graphql = { "prettier" },
					lua = { "stylua" },
					python = { "isort", "ruff_format" },
				},
				format_on_save = {
					lsp_fallback = true,
					async = false,
					timeout_ms = 1000,
				},
			})

			vim.keymap.set({ "n", "v" }, "<leader>mf", function()
				conform.format({
					lsp_fallback = true,
					async = false,
					timeout_ms = 1000,
				})
			end, { desc = "Format file or range (in visual mode)" })
		end,
	},

	-- TYPE CHECKING

	{
		"mfussenegger/nvim-lint",
		lazy = true,
		event = { "BufReadPre", "BufNewFile" }, -- to disable, comment this out
		config = function()
			local lint = require("lint")

			lint.linters_by_ft = {
				javascript = { "eslint_d" },
				typescript = { "eslint_d" },
				javascriptreact = { "eslint_d" },
				typescriptreact = { "eslint_d" },
				svelte = { "eslint_d" },
				python = { "ruff" },
			}

			local lint_augroup = vim.api.nvim_create_augroup("lint", { clear = true })

			vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost", "InsertLeave" }, {
				group = lint_augroup,
				callback = function()
					lint.try_lint()
				end,
			})

			vim.keymap.set({ "n", "v" }, "<leader>ml", function()
				lint.try_lint()
			end, { desc = "Trigger linting for current file" })
		end,
	},

	-- SESSION MANAGER

	{
		"natecraddock/sessions.nvim",
		config = function()
			require("sessions").setup({
				session_filepath = vim.fn.stdpath("data") .. "/sessions",
				absolute = true,
				autosave = true,
				save = true,
			})
		end,
	},

	-- GO

	{
		"ray-x/go.nvim",
		dependencies = { -- optional packages
			"ray-x/guihua.lua",
			"neovim/nvim-lspconfig",
			"nvim-treesitter/nvim-treesitter",
		},
		config = function()
			require("go").setup()
		end,
		event = { "CmdlineEnter" },
		ft = { "go", "gomod" },
		build = ':lua require("go.install").update_all_sync()', -- if you need to install/update all binaries
	},
	{
		"Zeioth/markmap.nvim",
		build = "yarn global add markmap-cli",
		cmd = { "MarkmapOpen", "MarkmapSave", "MarkmapWatch", "MarkmapWatchStop" },
		opts = {
			html_output = "/tmp/markmap.html", -- (default) Setting a empty string "" here means: [Current buffer path].html
			hide_toolbar = false, -- (default)
			grace_period = 3600000, -- (default) Stops markmap watch after 60 minutes. Set it to 0 to disable the grace_period.
		},
		config = function(_, opts)
			require("markmap").setup(opts)
		end,
	},

	-- Present

	{
		"Chaitanyabsprip/present.nvim",
		config = function()
			require("present").setup({
				default_mappings = true,
				kitty = {
					normal_font_size = 12,
					zoom_font_size = 50,
				},
			})
		end,
	},

	-- Rename

	{
		"seasonalmatcha/symbol-renamer.nvim",
		dependencies = {
			"nvim-lua/plenary.nvim",
		},
		config = function()
			require("symbol-renamer").setup({
				borderchars = { "─", "│", "─", "│", "╭", "╮", "╯", "╰" },
				relative = "cursor",
				focusable = true,
				width = 40,
				height = 1,
				line = "cursor+2",
				col = "cursor",
				padding = { 0, 1, 0, 1 },
			})
		end,
	},

	-- VENV SWITCHER

	{
		"linux-cultist/venv-selector.nvim",
		dependencies = { "neovim/nvim-lspconfig", "nvim-telescope/telescope.nvim", "mfussenegger/nvim-dap-python" },
		opts = {
			-- Your options go here
			venvwrapper_path = "~/Documents/venv",
			auto_refresh = true,
		},
		event = "VeryLazy", -- Optional: needed only if you want to type `:VenvSelect` without a keymapping
		keys = {
			-- Keymap to open VenvSelector to pick a venv.
			{ "<leader>vs", "<cmd>VenvSelect<cr>" },
			-- Keymap to retrieve the venv from a cache (the one previously used for the same project directory).
			{ "<leader>vc", "<cmd>VenvSelectCached<cr>" },
		},
	},
}
