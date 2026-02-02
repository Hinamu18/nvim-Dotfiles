return {
  "nvimtools/none-ls.nvim",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "jay-babu/mason-null-ls.nvim",
  },
  config = function()
    require("mason-null-ls").setup({
      ensure_installed = { "stylua", "prettier", "black", "shfmt" },
      automatic_installation = true,
    })

    local null_ls = require("null-ls")

    null_ls.setup({
      sources = {
        -- Force 2 spaces
        null_ls.builtins.formatting.stylua.with({
          extra_args = { "--indent-type", "Spaces", "--indent-width", "2" },
        }),

        null_ls.builtins.formatting.prettier.with({
          extra_args = { "--tab-width", "2" },
        }),

        null_ls.builtins.formatting.shfmt.with({
          extra_args = { "-i", "2" },
        }),

        null_ls.builtins.formatting.black,
      },
    })

    vim.keymap.set("n", "<leader>gf", vim.lsp.buf.format, { desc = "Format File" })
  end,
}
