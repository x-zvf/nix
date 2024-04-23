{
  pkgs,
  inputs,
  ...
}: {
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
    colorschemes.tokyonight.enable = true;

    clipboard = {
      register = "unnamedplus";
      providers.wl-copy.enable = true;
    };
    globals.mapleader = " ";
    opts = {
      autoindent = true;
      colorcolumn = [81 101];
      fileencoding = "utf-8";
      foldlevel = 99;
      number = true;
      relativenumber = true;
      scrolloff = 5;
      shiftwidth = 4;
      softtabstop = 4;
      spell = true;
      spelllang = "en_us"; # 'Murican, because programming...
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
          javascript = ["prettier"];
          nix = ["alejandra"];
          rust = ["rustfmt"];
        };
      };
      ltex-extra = {
        enable = true;
        settings.load_langs = [
          "en-US"
          "en-GB"
          "de-DE"
          # "hu-HU" -> safly, not supported yet
        ];
      };
      todo-comments.enable = true;
      comment.enable = true;
      illuminate.enable = true;
      which-key.enable = true;
      gitsigns.enable = true;
      nvim-colorizer.enable = true;
      fugitive.enable = true;
      indent-blankline = {
        enable = true;
        settings.scope.enabled = true;
      };
      telescope = {
        enable = true;
        extensions.fzf-native.enable = true;
        keymaps = {
          "<leader>fff" = "find_files"; # ffh is defined below as a cmd
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
      treesitter-textobjects = {
        enable = true;
        lspInterop.enable = true;
        select = {
          enable = true;
          lookahead = true;
          keymaps = {
            "aa" = "@parameter.outer";
            "ia" = "@parameter.inner";
            "af" = "@function.outer";
            "if" = "@function.inner";
            "ac" = "@class.outer";
            "ic" = "@class.inner";
            "ii" = "@conditional.inner";
            "ai" = "@conditional.outer";
            "il" = "@loop.inner";
            "al" = "@loop.outer";
            "at" = "@comment.outer";
          };
        };
        move = {
          enable = true;
          gotoNextStart = {
            "]m" = "@function.outer";
            "]]" = "@class.outer";
          };
          gotoNextEnd = {
            "]M" = "@function.outer";
            "][" = "@class.outer";
          };
          gotoPreviousStart = {
            "[m" = "@function.outer";
            "[[" = "@class.outer";
          };
          gotoPreviousEnd = {
            "[M" = "@function.outer";
            "[]" = "@class.outer";
          };
        };
      };
      treesitter-refactor = {
        enable = true;
      };
      lsp = {
        enable = true;
        servers = {
          ltex.enable = true;

          nil_ls.enable = true;

          ccls.enable = true;
          gopls.enable = true;
          hls.enable = true;
          java-language-server.enable = true;
          prolog-ls.enable = true;
          pyright.enable = true;
          rust-analyzer = {
            enable = true;
            # these are managed by devshell
            installRustc = false;
            installCargo = false;
          };
          zls.enable = true;

          html.enable = true;
          jsonls.enable = true;
          emmet_ls.enable = true;
          elmls.enable = true;
          htmx.enable = true;
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
            spell = "[spell]";
          };
        };
      };
      #lsp-lines.enable = true;
      trouble.enable = true;
      lsp-format.enable = true;
      luasnip.enable = true;

      cmp-buffer.enable = true;
      cmp-latex-symbols.enable = true;
      cmp-nvim-lsp.enable = true;
      cmp-spell.enable = true;

      cmp = {
        enable = true;
        settings = {
          snippet.expand = "function(args) require('luasnip').lsp_expand(args.body) end";
          sources = [
            {name = "nvim_lsp";}
            {name = "luasnip";}
            {name = "path";}
            {name = "latex-symbols";}
            {name = "buffer";}
            {name = "spell";}
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
        mode = ["n"];
        key = "<leader>cc";
        action = "<Plug>(comment_toggle_linewise_current)";
        options.desc = "(Un)comment in Normal Mode";
      }
      {
        mode = ["v"];
        key = "<leader>cb";
        action = "<Plug>(comment_toggle_blockwise_visual)";
        options.desc = "(Un)comment in Visual Mode";
      }
      {
        mode = "n";
        key = "<C-n>";
        action = "<CMD>Neotree toggle<CR>";
        options.desc = "Toggle Neotree";
      }
      {
        mode = "n";
        key = "<leader>ffh";
        action = "<CMD>Telescope find_files hidden=true<CR>";
        options.desc = "Find files, including hidden ones";
      }
      {
        mode = "n";
        key = "]e";
        action = "<CMD>Lspsaga diagnostic_jump_next<CR>";
        options.desc = "Show next diagnostic";
      }
      {
        mode = "n";
        key = "[e";
        action = "<CMD>Lspsaga diagnostic_jump_prev<CR>";
        options.desc = "Show previous diagnostic";
      }
      {
        mode = "n";
        key = "<leader>e";
        action = "<CMD>Lspsaga show_line_diagnostics<CR>";
        options.desc = "Show previous diagnostic";
      }
      {
        mode = "n";
        key = "<leader>ca";
        action = "<CMD>Lspsaga code_action<CR>";
        options.desc = "Code Action";
      }
    ];
  };
}
