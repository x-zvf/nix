{ pkgs, inputs, ... }:
{
  imports = [
    inputs.nixvim.homeManagerModules.nixvim
  ];
  programs.nixvim = {
    enable = true;
    viAlias = true;
    vimAlias = true;

    plugins = {
      lualine.enable = true;
    };
    #colorschemes.dracula.enable = true;
    colorschemes.catppuccin = {
      enable = true;
      flavour = "mocha";
    };

    clipboard = {
      register = "unnamedplus";
      providers.wl-copy.enable = true;
    };
    globals.mapleader = " ";
    options = {
      autoindent = true;
      fileencoding = "utf-8";
      foldlevel = 99;
      number = true;
      relativenumber = true;
      scrolloff = 5;
      shiftwidth = 4;
      softtabstop = 4;
      splitbelow = true;
      splitright = true;
      tabstop = 4;
      termguicolors = true;
    };

    plugins = {
      conform-nvim = {
	enable = true;
        formatOnSave = {
          timeoutMs = 500;
          lspFallback = true;
        };
        formattersByFt = {
          javascript = [ "prettier" ];
          nix = [ "alejandra" ];
          rust = [ "rustfmt" ];
        };
      };
      todo-comments.enable = true;
      illuminate.enable = true;
      which-key.enable = true;
      gitsigns.enable = true;
      nvim-colorizer.enable = true;
      fugitive.enable = true;
      indent-blankline = {
        enable = true;
        scope.enabled = true;
      };
      telescope = {
        enable = true;
        extraOptions = {
          pickers.find_files = {
            hidden = true;
          };
        };
        keymaps = {
          "<leader>ff" = "find_files";
          "<leader>fg" = "live_grep";
          "<leader>fb" = "buffers";
          "<leader>fh" = "help_tags";
        };
      };
      neo-tree = {
        enable = true;
        closeIfLastWindow = true;
      };
      treesitter = {
        enable = true;
        nixvimInjections = true;
        folding = true;
        indent = true;
        nixGrammars = true;
        ensureInstalled = "all";
        incrementalSelection.enable = true;
      };
      treesitter-refactor = {
        enable = true;
      };
      lsp = {
        enable = true;
        servers = {
          nil_ls.enable = true;

          ccls.enable = true;
          gopls.enable = true;
          pyright.enable = true;



          html.enable = true;
          cssls.enable = true;
          tsserver.enable = true;
          svelte.enable = true;
          tailwindcss = {
            enable = true;
            filetypes = [
              "html"
              "js"
              "ts"
              "jsx"
              "tsx"
              "mdx"
              "svelte"
            ];
          };
        };
      };
      lspkind = {
        enable = true;
        cmp = {
          enable = true;
          menu = {
            nvim_lsp = "[LSP]";
            nvim_lua = "[api]";
            path = "[path]";
            luasnip = "[snip]";
            buffer = "[buffer]";
          };
        };
      };
      lsp-lines.enable = true;
      lsp-format.enable = true;
      luasnip.enable = true;
      cmp-nvim-lsp.enable = true;
      cmp-buffer.enable = true;
      cmp-latex-symbols.enable = true;
      cmp = {
        enable = true;
        settings = {
          snippet.expand = "function(args) require('luasnip').lsp_expand(args.body) end";
          sources = [
            { name = "nvim_lsp"; }
            { name = "luasnip"; }
            { name = "path"; }
            { name = "latex-symbols"; }
            { name = "buffer"; }
          ];
          mapping = {
            "<C-j>" = "cmp.mapping.scroll_docs(-4)";
            "<C-k>" = "cmp.mapping.scroll_docs(4)";
            "<C-Space>" = "cmp.mapping.complete()";
            "<C-e>" = "cmp.mapping.close()";
            "<C-n>" = "cmp.mapping(cmp.mapping.select_next_item(), {'i', 's'})";
            "<C-p>" = "cmp.mapping(cmp.mapping.select_prev_item(), {'i', 's'})";
            "<C-y>" = "cmp.mapping.confirm({ select = true })";
          };
        };
      };
    };
    extraPlugins = with pkgs.vimPlugins; [
      friendly-snippets
      luasnip
      vim-sleuth
    ];
    keymaps = [
      {
        key = "<C-s>";
        action = "<CMD>w<CR>";
        options.desc = "Save";
      }
      {
        mode = "n";
        key = "<C-/>";
        action = "<Plug>(comment_toggle_linewise_current)";
        options.desc = "(Un)comment in Normal Mode";
      }
      {
        mode = "v";
        key = "<C-/>";
        action = "<Plug>(comment_toggle_blockwise_current)";
        options.desc = "(Un)comment in Visual Mode";
      }

    ];
  };
}
