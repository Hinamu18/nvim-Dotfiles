return {
  "mfussenegger/nvim-dap",
  dependencies = {
    "rcarriga/nvim-dap-ui",
    "nvim-neotest/nvim-nio", -- Required for dap-ui
    "williamboman/mason.nvim",
    "jay-babu/mason-nvim-dap.nvim",
    "leoluz/nvim-dap-go",
    "theHamsta/nvim-dap-virtual-text",
  },
  config = function()
    local dap = require("dap")
    local dapui = require("dapui")

    -- 1. Setup Mason DAP (Installer)
    require("mason-nvim-dap").setup({
      ensure_installed = {
        "codelldb", -- C, C++, Rust
        "delve",    -- Go
        "python",   -- Python (debugpy)
      },
      automatic_installation = true,
      handlers = {}, -- Automatically configures the debuggers
    })

    -- 2. Setup DAP UI
    dapui.setup()

    -- Open UI automatically when debugging starts
    dap.listeners.after.event_initialized["dapui_config"] = function()
      dapui.open()
    end
    dap.listeners.before.event_terminated["dapui_config"] = function()
      dapui.close()
    end
    dap.listeners.before.event_exited["dapui_config"] = function()
      dapui.close()
    end

    -- 3. Setup Virtual Text (Inline values)
    require("nvim-dap-virtual-text").setup()

    -- 4. Language Specific Extensions
    require("dap-go").setup() -- Auto-config for Go

    -- 5. Manual Config for C/C++/Rust (if Mason doesn't auto-load it perfectly)
    -- This ensures that hitting F5 in a C/C++ file asks for the executable.
    local codelldb_adapter = {
      type = 'server',
      port = "${port}",
      executable = {
        -- Make sure this points to where mason installs it
        command = vim.fn.stdpath("data") .. '/mason/bin/codelldb',
        args = { "--port", "${port}" },
      },
    }

    dap.adapters.codelldb = codelldb_adapter
    dap.adapters.cpp = codelldb_adapter
    dap.adapters.c = codelldb_adapter
    dap.adapters.rust = codelldb_adapter

    local c_config = {
      {
        name = "Launch file",
        type = "codelldb",
        request = "launch",
        program = function()
          return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
        end,
        cwd = '${workspaceFolder}',
        stopOnEntry = false,
      },
    }

    dap.configurations.cpp = c_config
    dap.configurations.c = c_config
    dap.configurations.rust = c_config

    -- 6. Keybindings
    vim.keymap.set("n", "<F5>", dap.continue, { desc = "Debug: Start/Continue" })
    vim.keymap.set("n", "<F10>", dap.step_over, { desc = "Debug: Step Over" })
    vim.keymap.set("n", "<F11>", dap.step_into, { desc = "Debug: Step Into" })
    vim.keymap.set("n", "<F12>", dap.step_out, { desc = "Debug: Step Out" })
    vim.keymap.set("n", "<leader>b", dap.toggle_breakpoint, { desc = "Debug: Toggle Breakpoint" })
    vim.keymap.set("n", "<leader>B", function()
      dap.set_breakpoint(vim.fn.input('Breakpoint condition: '))
    end, { desc = "Debug: Conditional Breakpoint" })
  end,
}
