vim.g.mapleader = " "

require("packer").startup(function(use)
	use { "altercation/vim-colors-solarized"  }
	use {
    	'junegunn/fzf.vim',
    	requires = { 'junegunn/fzf', run = ':call fzf#install()' }
 	}
	use { 'mustache/vim-mustache-handlebars' }
	use { "wbthomason/packer.nvim" }
	use { 'kyazdani42/nvim-web-devicons' }
	use { 'amirrezaask/fuzzy.nvim', requires={'nvim-lua/plenary.nvim'}}
	use { "ellisonleao/gruvbox.nvim" }
	use ('nvim-treesitter/nvim-treesitter', {run = ':TSUpdate'})
	use {
		'nvim-telescope/telescope.nvim', tag = '0.1.4',
		 requires = { {'nvim-lua/plenary.nvim'} }
	}
	use({
	  "chama-chomo/grail",
	  -- Optional; default configuration will be used if setup isn't called.
	  config = function()
		require("grail").setup()
	  end,
	})
	use {
	  'nvim-lualine/lualine.nvim',
	   requires = { 'kyazdani42/nvim-web-devicons', opt = true }
	}
	use { "fatih/vim-go" }
	use {
		'VonHeikemen/lsp-zero.nvim',
  		branch = 'v1.x',
  		requires = {
		{'neovim/nvim-lspconfig'},             -- Required
		{'williamboman/mason.nvim'},           -- Optional
		{'williamboman/mason-lspconfig.nvim'}, -- Optional
		{'hrsh7th/nvim-cmp'},         -- Required
		{'hrsh7th/cmp-nvim-lsp'},     -- Required
		{'hrsh7th/cmp-buffer'},       -- Optional
		{'hrsh7th/cmp-path'},         -- Optional
		{'saadparwaiz1/cmp_luasnip'}, -- Optional
		{'hrsh7th/cmp-nvim-lua'},     -- Optional
		{'L3MON4D3/LuaSnip'},             -- Required
		{'rafamadriz/friendly-snippets'}, -- Optional
  	},
	use {"akinsho/toggleterm.nvim", tag = '*' },
	-- use "jhlgns/naysayer88.vim",
	use "terrortylor/nvim-comment",
	use "CreaturePhil/vim-handmade-hero",
	use {
	  "nvim-neo-tree/neo-tree.nvim",
		branch = "v3.x",
		requires = { 
		  "nvim-lua/plenary.nvim",
		  "nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
		  "MunifTanjim/nui.nvim",
		  -- "3rd/image.nvim", -- Optional image support in preview window: See `# Preview Mode` for more information
		  {
			's1n7ax/nvim-window-picker',
			version = '2.*',
			config = function()
				require 'window-picker'.setup({
					filter_rules = {
						include_current_win = false,
						autoselect_one = true,
						-- filter using buffer options
						bo = {
							-- if the file type is one of following, the window will be ignored
							filetype = { 'neo-tree', "neo-tree-popup", "notify" },
							-- if the buffer type is one of following, the window will be ignored
							buftype = { 'terminal', "quickfix" },
						},
				},
			})
			end,
		  },
		},
		config = function ()
		  -- If you want icons for diagnostic errors, you'll need to define them somewhere:
		  vim.fn.sign_define("DiagnosticSignError",
			{text = " ", texthl = "DiagnosticSignError"})
		  vim.fn.sign_define("DiagnosticSignWarn",
			{text = " ", texthl = "DiagnosticSignWarn"})
		  vim.fn.sign_define("DiagnosticSignInfo",
			{text = " ", texthl = "DiagnosticSignInfo"})
		  vim.fn.sign_define("DiagnosticSignHint",
			{text = "󰌵", texthl = "DiagnosticSignHint"})

		  require("neo-tree").setup({
			close_if_last_window = false, -- Close Neo-tree if it is the last window left in the tab
			popup_border_style = "rounded",
			enable_git_status = true,
			enable_diagnostics = true,
			open_files_do_not_replace_types = { "terminal", "trouble", "qf" }, -- when opening files, do not use windows containing these filetypes or buftypes
			sort_case_insensitive = false, -- used when sorting files and directories in the tree
			sort_function = nil , -- use a custom function for sorting files and directories in the tree 
			-- sort_function = function (a,b)
			--       if a.type == b.type then
			--           return a.path > b.path
			--       else
			--           return a.type > b.type
			--       end
			--   end , -- this sorts files and directories descendantly
			default_component_configs = {
			  container = {
				enable_character_fade = true
			  },
			  indent = {
				indent_size = 2,
				padding = 1, -- extra padding on left hand side
				-- indent guides
				with_markers = true,
				indent_marker = "│",
				last_indent_marker = "└",
				highlight = "NeoTreeIndentMarker",
				-- expander config, needed for nesting files
				with_expanders = nil, -- if nil and file nesting is enabled, will enable expanders
				expander_collapsed = "",
				expander_expanded = "",
				expander_highlight = "NeoTreeExpander",
			  },
			  icon = {
				folder_closed = "",
				folder_open = "",
				folder_empty = "󰜌",
				-- The next two settings are only a fallback, if you use nvim-web-devicons and configure default icons there
				-- then these will never be used.
				default = "*",
				highlight = "NeoTreeFileIcon"
			  },
			  modified = {
				symbol = "[+]",
				highlight = "NeoTreeModified",
			  },
			  name = {
				trailing_slash = false,
				use_git_status_colors = true,
				highlight = "NeoTreeFileName",
			  },
			  git_status = {
				symbols = {
				  -- Change type
				  added     = "", -- or "✚", but this is redundant info if you use git_status_colors on the name
				  modified  = "", -- or "", but this is redundant info if you use git_status_colors on the name
				  deleted   = "✖",-- this can only be used in the git_status source
				  renamed   = "󰁕",-- this can only be used in the git_status source
				  -- Status type
				  untracked = "",
				  ignored   = "",
				  unstaged  = "󰄱",
				  staged    = "",
				  conflict  = "",
				}
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
			  position = "left",
			  width = 40,
			  mapping_options = {
				noremap = true,
				nowait = true,
			  },
			  mappings = {
				["<space>"] = { 
					"toggle_node", 
					nowait = false, -- disable `nowait` if you have existing combos starting with this char that you want to use 
				},
				["<2-LeftMouse>"] = "open",
				["<cr>"] = "open",
				["<esc>"] = "cancel", -- close preview or floating neo-tree window
				["P"] = { "toggle_preview", config = { use_float = true, use_image_nvim = true } },
				-- Read `# Preview Mode` for more information
				["l"] = "focus_preview",
				["S"] = "open_split",
				["s"] = "open_vsplit",
				-- ["S"] = "split_with_window_picker",
				-- ["s"] = "vsplit_with_window_picker",
				["t"] = "open_tabnew",
				-- ["<cr>"] = "open_drop",
				-- ["t"] = "open_tab_drop",
				["w"] = "open_with_window_picker",
				--["P"] = "toggle_preview", -- enter preview mode, which shows the current node without focusing
				["C"] = "close_node",
				-- ['C'] = 'close_all_subnodes',
				["z"] = "close_all_nodes",
				--["Z"] = "expand_all_nodes",
				["a"] = { 
				  "add",
				  -- this command supports BASH style brace expansion ("x{a,b,c}" -> xa,xb,xc). see `:h neo-tree-file-actions` for details
				  -- some commands may take optional config options, see `:h neo-tree-mappings` for details
				  config = {
					show_path = "none" -- "none", "relative", "absolute"
				  }
				},
				["A"] = "add_directory", -- also accepts the optional config.show_path option like "add". this also supports BASH style brace expansion.
				["d"] = "delete",
				["r"] = "rename",
				["y"] = "copy_to_clipboard",
				["x"] = "cut_to_clipboard",
				["p"] = "paste_from_clipboard",
				["c"] = "copy", -- takes text input for destination, also accepts the optional config.show_path option like "add":
				-- ["c"] = {
				--  "copy",
				--  config = {
				--    show_path = "none" -- "none", "relative", "absolute"
				--  }
				--}
				["m"] = "move", -- takes text input for destination, also accepts the optional config.show_path option like "add".
				["q"] = "close_window",
				["R"] = "refresh",
				["?"] = "show_help",
				["<"] = "prev_source",
				[">"] = "next_source",
				["i"] = "show_file_details",
			  }
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
				always_show_by_pattern = { -- uses glob style patterns
				  --".env*",
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
			  hijack_netrw_behavior = "open_default", -- netrw disabled, opening a directory opens neo-tree
													  -- in whatever position is specified in window.position
									-- "open_current",  -- netrw disabled, opening a directory opens within the
													  -- window like netrw would, regardless of window.position
									-- "disabled",    -- netrw left alone, neo-tree does not handle opening dirs
			  use_libuv_file_watcher = false, -- This will use the OS level file watchers to detect changes
											  -- instead of relying on nvim autocmd events.
			  window = {
				mappings = {
				  ["<bs>"] = "navigate_up",
				  ["."] = "set_root",
				  ["H"] = "toggle_hidden",
				  ["/"] = "fuzzy_finder",
				  ["D"] = "fuzzy_finder_directory",
				  ["#"] = "fuzzy_sorter", -- fuzzy sorting using the fzy algorithm
				  -- ["D"] = "fuzzy_sorter_directory",
				  ["f"] = "filter_on_submit",
				  ["<c-x>"] = "clear_filter",
				  ["[g"] = "prev_git_modified",
				  ["]g"] = "next_git_modified",
				  ["o"] = { "show_help", nowait=false, config = { title = "Order by", prefix_key = "o" }},
				  ["oc"] = { "order_by_created", nowait = false },
				  ["od"] = { "order_by_diagnostics", nowait = false },
				  ["og"] = { "order_by_git_status", nowait = false },
				  ["om"] = { "order_by_modified", nowait = false },
				  ["on"] = { "order_by_name", nowait = false },
				  ["os"] = { "order_by_size", nowait = false },
				  ["ot"] = { "order_by_type", nowait = false },
				  -- ['<key>'] = function(state) ... end,
				},
				fuzzy_finder_mappings = { -- define keymaps for filter popup window in fuzzy_finder_mode
				  ["<down>"] = "move_cursor_down",
				  ["<C-n>"] = "move_cursor_down",
				  ["<up>"] = "move_cursor_up",
				  ["<C-p>"] = "move_cursor_up",
				  -- ['<key>'] = function(state, scroll_padding) ... end,
				},
			  },

			  commands = {} -- Add a custom command or override a global one using the same function name
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
				  ["bd"] = "buffer_delete",
				  ["<bs>"] = "navigate_up",
				  ["."] = "set_root",
				  ["o"] = { "show_help", nowait=false, config = { title = "Order by", prefix_key = "o" }},
				  ["oc"] = { "order_by_created", nowait = false },
				  ["od"] = { "order_by_diagnostics", nowait = false },
				  ["om"] = { "order_by_modified", nowait = false },
				  ["on"] = { "order_by_name", nowait = false },
				  ["os"] = { "order_by_size", nowait = false },
				  ["ot"] = { "order_by_type", nowait = false },
				}
			  },
			},
			git_status = {
			  window = {
				position = "float",
				mappings = {
				  ["A"]  = "git_add_all",
				  ["gu"] = "git_unstage_file",
				  ["ga"] = "git_add_file",
				  ["gr"] = "git_revert_file",
				  ["gc"] = "git_commit",
				  ["gp"] = "git_push",
				  ["gg"] = "git_commit_and_push",
				  ["o"] = { "show_help", nowait=false, config = { title = "Order by", prefix_key = "o" }},
				  ["oc"] = { "order_by_created", nowait = false },
				  ["od"] = { "order_by_diagnostics", nowait = false },
				  ["om"] = { "order_by_modified", nowait = false },
				  ["on"] = { "order_by_name", nowait = false },
				  ["os"] = { "order_by_size", nowait = false },
				  ["ot"] = { "order_by_type", nowait = false },
				}
			  }
			}
		  })

		  vim.cmd([[nnoremap \ :Neotree reveal<cr>]])
		end
	}}
end)

-- some
vim.keymap.set("n", "<M-b>", ":Ex<CR>")

-- split screen and navigation
vim.keymap.set("n", "<leader>v", ":vsplit<CR><C-w>l", { noremap = true })
vim.keymap.set("n", "<leader>h", ":wincmd h<CR>", { noremap = true })
vim.keymap.set("n", "<leader>l", ":wincmd l<CR>", { noremap = true })

-- See `:help telescope.builtin`
vim.keymap.set('n', '<leader>?', require('telescope.builtin').oldfiles, { desc = '[?] Find recently opened files' })
vim.keymap.set('n', '<leader><space>', require('telescope.builtin').buffers, { desc = '[ ] Find existing buffers' })
vim.keymap.set('n', '<leader>f', function()
	require('telescope.builtin').current_buffer_fuzzy_find(require('telescope.themes').get_dropdown {
		winblend = 10,
  		previewer = false,
    })
end, { desc = '[/] Fuzzily search in current buffer' })

vim.keymap.set('n', '<leader>p', require('telescope.builtin').find_files, { desc = '[S]earch [F]iles' })
vim.keymap.set('n', '<M-p>', require('telescope.builtin').find_files, { desc = '[S]earch [F]iles' })
vim.keymap.set('n', '<leader>sh', require('telescope.builtin').help_tags, { desc = '[S]earch [H]elp' })
vim.keymap.set('n', '<leader>sw', require('telescope.builtin').grep_string, { desc = '[S]earch current [W]ord' })
vim.keymap.set('n', '<leader>sg', require('telescope.builtin').live_grep, { desc = '[S]earch by [G]rep' })
vim.keymap.set('n', '<leader>sd', require('telescope.builtin').diagnostics, { desc = '[S]earch [D]iagnostics' })

-- TREESITTER
require'nvim-treesitter.configs'.setup {
	ensure_installed = {"c", "php", "lua", "vim", "go", "javascript", "typescript", "rust"},
	highlight = {
		enable = false,
	}
}

-- GRUVBOX
require("gruvbox").setup({
	contrast = "hard",
	palette_overrides = {
		gray = "#2ea542", -- comments are green and by that I mean GREEN
	}
})

-- LUALINE
require("lualine").setup{
	options = {
		icons_enabled = false,
		theme = "onedark",
		component_separators = "|",
		section_separators = "",
	},
}

-- LSP
local lsp = require("lsp-zero")

lsp.preset("recommended")

lsp.ensure_installed({
	"tsserver",
	"gopls",
	"eslint",
	"rust_analyzer",
})

lsp.set_preferences({
	sign_icons = {}
})

lsp.on_attach(function(client, bufnr)
	local opts = {buffer = bufnr, remap = false}
	vim.keymap.set("n", "gd", function() vim.lsp.buf.definition() end, opts)
end)

lsp.setup()

vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
	vim.lsp.diagnostic.on_publish_diagnostics, {
		signs = false,
		virtual_text = true,
		underline = false,
	}
)

-- netrw config
vim.g.netrw_banner = 0
vim.g.netrw_keepdir = 0
vim.g.netrw_winsize = 30

-- COMMENT
require("nvim_comment").setup({
	operator_mapping = "<leader>/"
})

-- TERMINAL SETUP
require("toggleterm").setup{
	direction = "horizontal",
	size = 90,
	open_mapping = [[<M-j>]]
}

-- COLORSCHEME
vim.cmd("colorscheme gruvbox")
-- Adding the same comment color in each theme
vim.cmd([[
	augroup CustomCommentCollor
		autocmd!
		autocmd VimEnter * hi Comment guifg=#2ea542
	augroup END
]])

-- Disable annoying match brackets and all the jaz
vim.cmd([[
	augroup CustomHI
		autocmd!
		autocmd VimEnter * NoMatchParen
	augroup END
]])

vim.o.background = "dark"

vim.env.FZF_DEFAULT_COMMAND = 'rg --files --no-ignore --hidden --follow'

vim.keymap.set("i", "jj", "<Esc>")

vim.opt.guicursor = "i:block"
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.number = false
vim.opt.relativenumber = true
vim.opt.swapfile = false

vim.o.hlsearch = true
vim.o.mouse = 'a'
vim.o.breakindent = true
vim.o.undofile = true
vim.o.ignorecase = true
vim.o.updatetime = 250
vim.o.timeout = true
vim.o.timeoutlen = 300
--vim.o.completeopt = 'menuone,noselect'
vim.o.termguicolors = true

