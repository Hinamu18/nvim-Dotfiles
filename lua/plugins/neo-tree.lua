return {
  "nvim-neo-tree/neo-tree.nvim",
  branch = "v3.x",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-tree/nvim-web-devicons", -- proper file icons
    "MunifTanjim/nui.nvim",
  },
  keys = {
    { "<C-E>", ":Neotree toggle<CR>", desc = "Toggle Explorer" },
  },
  config = function()
    require("neo-tree").setup({
      close_if_last_window = true,
      
      window = {
        position = "left",
        width = 30,
      },

      filesystem = {
        follow_current_file = { enabled = true },
        hijack_netrw_behavior = "open_default",
      },
    })

    -- Transparency Fix
    vim.api.nvim_set_hl(0, "NeoTreeNormal", { bg = "NONE", ctermbg = "NONE" })
    vim.api.nvim_set_hl(0, "NeoTreeNormalNC", { bg = "NONE", ctermbg = "NONE" })
    vim.api.nvim_set_hl(0, "NeoTreeEndOfBuffer", { bg = "NONE", ctermbg = "NONE" })
  end,
}
