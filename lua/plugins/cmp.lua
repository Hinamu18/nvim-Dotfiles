return {
  "hrsh7th/nvim-cmp",
  event = "InsertEnter", -- Load only when you start typing
  dependencies = {
    "hrsh7th/cmp-nvim-lsp", -- LSP source
    "hrsh7th/cmp-buffer", -- Buffer source (words in file)
    "hrsh7th/cmp-path", -- Path source (file paths)
    "L3MON4D3/LuaSnip", -- Snippet engine
    "saadparwaiz1/cmp_luasnip", -- Bridge for snippets
    "rafamadriz/friendly-snippets", -- Collection of snippets (like "for" loops)
    "onsails/lspkind.nvim", -- Icons (vscode-like pictograms)
  },
  config = function()
    local cmp = require("cmp")
    local luasnip = require("luasnip")

    -- Load VSCode-style snippets (from friendly-snippets)
    require("luasnip.loaders.from_vscode").lazy_load()

    cmp.setup({
      snippet = {
        expand = function(args)
          luasnip.lsp_expand(args.body)
        end,
      },

      -- Window styling (optional, makes it look cleaner)
      window = {
        completion = cmp.config.window.bordered(),
        documentation = cmp.config.window.bordered(),
      },

      -- Mappings (Keybindings)
      mapping = cmp.mapping.preset.insert({
        ["<C-b>"] = cmp.mapping.scroll_docs(-4),
        ["<C-f>"] = cmp.mapping.scroll_docs(4),
        ["<C-Space>"] = cmp.mapping.complete(), -- Manually trigger completion
        ["<C-e>"] = cmp.mapping.abort(), -- Close menu

        -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
        ["<CR>"] = cmp.mapping.confirm({ select = true }),

        -- "Super-Tab" behavior
        ["<Tab>"] = cmp.mapping(function(fallback)
          if cmp.visible() then
            cmp.select_next_item()
          elseif luasnip.expand_or_jumpable() then
            luasnip.expand_or_jump()
          else
            fallback()
          end
        end, { "i", "s" }),

        ["<S-Tab>"] = cmp.mapping(function(fallback)
          if cmp.visible() then
            cmp.select_prev_item()
          elseif luasnip.jumpable(-1) then
            luasnip.jump(-1)
          else
            fallback()
          end
        end, { "i", "s" }),
      }),

      -- Sources (Order matters: LSP first, then Snippets, then Buffer)
      sources = cmp.config.sources({
        { name = "nvim_lsp" },
        { name = "luasnip" },
        { name = "path" },
      }, {
        { name = "buffer" },
      }),

      -- Formatting (Icons)
      formatting = {
        format = require("lspkind").cmp_format({
          mode = "symbol_text", -- show symbol + text
          maxwidth = 50,
          ellipsis_char = "...",
        }),
      },
    })
  end,
}
