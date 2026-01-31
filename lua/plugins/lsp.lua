return {
  "neovim/nvim-lspconfig",
  dependencies = {
    "williamboman/mason.nvim",
    "williamboman/mason-lspconfig.nvim",
  },
  config = function()
    require("mason").setup()

    require("mason-lspconfig").setup({
      ensure_installed = {
        -- System & Low Level
        "clangd",        -- C / C++
        "gopls",         -- Go
        "rust_analyzer", -- Rust
        "bashls",        -- Bash / Shell Scripting

        -- Java
        "jdtls",

        -- Web Development
        "html",
        "cssls",
        "ts_ls",         -- JavaScript / TypeScript
        "jsonls",
        "sqlls",         -- SQL (Databases)

        -- Scripting & Config (Very important for you!)
        "pyright",       -- Python
        "lua_ls",        -- Lua (Neovim config)
        "dockerls",      -- Dockerfiles
        "yamlls",        -- YAML (Docker Compose)
      },

      handlers = {
        -- Default handler for most languages
        function(server_name)
          require("lspconfig")[server_name].setup({})
        end,

        -- Special handler for Lua (fixes "undefined global 'vim'" warning)
        ["lua_ls"] = function()
          require("lspconfig").lua_ls.setup({
            settings = {
              Lua = {
                diagnostics = {
                  globals = { "vim" },
                },
              },
            },
          })
        end,
      },
    })

    -- Keybindings
    vim.api.nvim_create_autocmd("LspAttach", {
      group = vim.api.nvim_create_augroup("UserLspConfig", {}),
      callback = function(ev)
        local opts = { buffer = ev.buf }
        vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
        vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
        vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)
        vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, opts)
      end,
    })
  end,
}
