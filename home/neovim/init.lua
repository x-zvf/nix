vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.mouse = "a"
vim.opt.showmode = false
vim.opt.breakindent = true
vim.opt.undofile = true
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.signcolumn = "yes"
vim.opt.updatetime = 250
vim.opt.timeoutlen = 500
vim.opt.splitright = true
vim.opt.splitbelow = true
vim.opt.list = true
vim.opt.listchars = { tab = "» ", trail = "·", nbsp = "␣" }
vim.opt.inccommand = "split"
vim.opt.scrolloff = 5

vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>")
vim.api.nvim_create_autocmd("TextYankPost", {
	desc = "Highlight when yanking (copying) text",
	group = vim.api.nvim_create_augroup("kickstart-highlight-yank", { clear = true }),
	callback = function()
		vim.highlight.on_yank()
	end,
})

vim.g.mapleader = " "
vim.g.maplocalleader = " "
vim.keymap.set("n", "<leader>p", '"+p')
vim.keymap.set("v", "<leader>y", '"+y')

vim.keymap.set("n", "<leader>wh", "<C-w><C-h>", { desc = "[W]indow focus left" })
vim.keymap.set("n", "<leader>wl", "<C-w><C-l>", { desc = "[W]indow focus right" })
vim.keymap.set("n", "<leader>wj", "<C-w><C-j>", { desc = "[W]indow focus down" })
vim.keymap.set("n", "<leader>wk", "<C-w><C-k>", { desc = "[W]indow focus up" })
vim.keymap.set("n", "<leader>ws", "<CMD>split<CR>", { desc = "[W]indow split horizontal" })
vim.keymap.set("n", "<leader>wv", "<CMD>vsplit<CR>", { desc = "[W]indow split vertical" })

require("gitsigns").setup()
require("telescope").setup({
	extensions = {
		["ui-select"] = {
			require("telescope.themes").get_dropdown(),
		},
	},
})
-- require('telescope').load_extension('fzf')
require("telescope").load_extension("ui-select")

local builtin = require("telescope.builtin")
vim.keymap.set("n", "<leader>sh", builtin.help_tags, { desc = "[S]earch [H]elp" })
vim.keymap.set("n", "<leader>sk", builtin.keymaps, { desc = "[S]earch [K]eymaps" })
vim.keymap.set("n", "<leader>sf", builtin.find_files, { desc = "[S]earch [F]iles" })
--vim.keymap.set('n', '<leader>sw', builtin.grep_string, { desc = '[S]earch current [W]ord' })
vim.keymap.set("n", "<leader>sg", builtin.live_grep, { desc = "[S]earch by [G]rep" })
vim.keymap.set("n", "<leader>sd", builtin.diagnostics, { desc = "[S]earch [D]iagnostics" })
vim.keymap.set("n", "<leader>sr", builtin.resume, { desc = "[S]earch [R]esume" })
vim.keymap.set("n", "<leader>s.", builtin.oldfiles, { desc = '[S]earch Recent Files ("." for repeat)' })
vim.keymap.set("n", "<leader><leader>", builtin.buffers, { desc = "[ ] Find existing buffers" })
vim.keymap.set("n", "<leader>/", function()
	builtin.current_buffer_fuzzy_find(require("telescope.themes").get_dropdown({
		winblend = 10,
		previewer = false,
	}))
end, { desc = "[/] Fuzzily search in current buffer" })

vim.keymap.set("n", "<leader>q", vim.diagnostic.setloclist, { desc = "Open diagnostic [Q]uickfix list" })

vim.keymap.set("n", "<leader>s/", function()
	builtin.live_grep({
		grep_open_files = true,
		prompt_title = "Live Grep in Open Files",
	})
end, { desc = "[S]earch [/] in Open Files" })

local autoformat = true
vim.keymap.set("n", "<leader>fe", function()
	autoformat = true
end, { desc = "[F]ormat on Save [E]nable" })
vim.keymap.set("n", "<leader>fd", function()
	autoformat = false
end, { desc = "[F]ormat on Save [D]isable" })

vim.api.nvim_create_autocmd("BufWritePre", {
	pattern = "*",
	callback = function(args)
		if autoformat then
			require("conform").format({ bufnr = args.buf })
		end
	end,
})

require("conform").setup({

	formatters_by_ft = {
		lua = { "stylua" },
		python = { "isort", "black" },
		javascript = { "prettierd" },
		nix = { "alejandra" },
	},
})

vim.keymap.set("n", "<leader>fb", function()
	require("conform").format({ async = true, lsp_fallback = true })
end, { desc = "[F]ormat [B]uffer" })

vim.api.nvim_create_autocmd("LspAttach", {
	group = vim.api.nvim_create_augroup("kickstart-lsp-attach", { clear = true }),
	callback = function(event)
		local map = function(keys, func, desc)
			vim.keymap.set("n", keys, func, { buffer = event.buf, desc = "LSP: " .. desc })
		end

		map("gd", require("telescope.builtin").lsp_definitions, "[G]oto [D]efinition")
		map("gD", vim.lsp.buf.declaration, "[G]oto [D]eclaration")
		map("gr", require("telescope.builtin").lsp_references, "[G]oto [R]eferences")
		map("gI", require("telescope.builtin").lsp_implementations, "[G]oto [I]mplementation")
		map("<leader>D", require("telescope.builtin").lsp_type_definitions, "Type [D]efinition")
		map("<leader>ds", require("telescope.builtin").lsp_document_symbols, "[D]ocument [S]ymbols")
		map("<leader>ws", require("telescope.builtin").lsp_dynamic_workspace_symbols, "[W]orkspace [S]ymbols")
		map("<leader>rn", vim.lsp.buf.rename, "[R]e[n]ame")
		map("<leader>ca", vim.lsp.buf.code_action, "[C]ode [A]ction")

		local client = vim.lsp.get_client_by_id(event.data.client_id)
		if client and client.supports_method(vim.lsp.protocol.Methods.textDocument_documentHighlight) then
			local highlight_augroup = vim.api.nvim_create_augroup("kickstart-lsp-highlight", { clear = false })
			vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
				buffer = event.buf,
				group = highlight_augroup,
				callback = vim.lsp.buf.document_highlight,
			})

			vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI" }, {
				buffer = event.buf,
				group = highlight_augroup,
				callback = vim.lsp.buf.clear_references,
			})

			vim.api.nvim_create_autocmd("LspDetach", {
				group = vim.api.nvim_create_augroup("kickstart-lsp-detach", { clear = true }),
				callback = function(event2)
					vim.lsp.buf.clear_references()
					vim.api.nvim_clear_autocmds({ group = "kickstart-lsp-highlight", buffer = event2.buf })
				end,
			})
		end

		if client and client.supports_method(vim.lsp.protocol.Methods.textDocument_inlayHint) then
			map("<leader>th", function()
				vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled({ bufnr = event.buf }))
			end, "[T]oggle Inlay [H]ints")
		end
	end,
})

local servers = {
	clangd = {},
	gopls = {},
	pyright = {},
	rust_analyzer = {},
	ts_ls = {},

	lua_ls = {
		settings = {
			Lua = {
				completion = {
					callSnippet = "Replace",
				},
				diagnostics = { disable = { "missing-fields" } },
			},
		},
	},
}

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = vim.tbl_deep_extend("force", capabilities, require("cmp_nvim_lsp").default_capabilities())
for lsname, lsopt in pairs(servers) do
	lsopt.capabilities = vim.tbl_deep_extend("force", {}, capabilities, lsopt.capabilities or {})
	require("lspconfig")[lsname].setup(lsopt)
end

require("lazydev").setup({
	library = {
		{ path = "luvit-meta/library", words = { "vim%.uv" } },
	},
})
local cmp = require("cmp")
local luasnip = require("luasnip")
luasnip.config.setup({})
cmp.setup({
	snippet = {
		expand = function(args)
			luasnip.lsp_expand(args.body)
		end,
	},
	completion = { completeopt = "menu,menuone,noinsert" },

	-- For an understanding of why these mappings were
	-- chosen, you will need to read `:help ins-completion`
	--
	-- No, but seriously. Please read `:help ins-completion`, it is really good!
	mapping = cmp.mapping.preset.insert({
		-- Select the [n]ext item
		["<C-n>"] = cmp.mapping.select_next_item(),
		-- Select the [p]revious item
		["<C-p>"] = cmp.mapping.select_prev_item(),

		-- Scroll the documentation window [b]ack / [f]orward
		["<C-b>"] = cmp.mapping.scroll_docs(-4),
		["<C-f>"] = cmp.mapping.scroll_docs(4),

		-- Accept ([y]es) the completion.
		["<C-y>"] = cmp.mapping.confirm({ select = true }),
		["<C-Space>"] = cmp.mapping.complete({}),

		-- Think of <c-l> as moving to the right of your snippet expansion.
		--  So if you have a snippet that's like:
		--  function $name($args)
		--    $body
		--  end
		--
		-- <c-l> will move you to the right of each of the expansion locations.
		-- <c-h> is similar, except moving you backwards.
		["<C-l>"] = cmp.mapping(function()
			if luasnip.expand_or_locally_jumpable() then
				luasnip.expand_or_jump()
			end
		end, { "i", "s" }),
		["<C-h>"] = cmp.mapping(function()
			if luasnip.locally_jumpable(-1) then
				luasnip.jump(-1)
			end
		end, { "i", "s" }),

		-- For more advanced Luasnip keymaps (e.g. selecting choice nodes, expansion) see:
		--    https://github.com/L3MON4D3/LuaSnip?tab=readme-ov-file#keymaps
	}),
	sources = {
		{
			name = "lazydev",
			-- set group index to 0 to skip loading LuaLS completions as lazydev recommends it
			group_index = 0,
		},
		{ name = "nvim_lsp" },
		{ name = "luasnip" },
		{ name = "path" },
	},
})