return {
  -- 1. Syntax Highlighting via Treesitter
  {
    "nvim-treesitter/nvim-treesitter",
    opts = function(_, opts)
      if type(opts.ensure_installed) == "table" then
        vim.list_extend(opts.ensure_installed, { "arduino", "c", "cpp" })
      end
    end,
  },

  -- 2. Auto-completion and Diagnostics via LSP
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        arduino_language_server = {
          -- The LSP needs to know where your arduino-cli and its config live
          cmd = {
            "arduino-language-server",
            "-cli-config",
            vim.fn.expand("~/.arduino15/arduino-cli.yaml"),
            "-cli",
            "arduino-cli",
            "-clangd",
            "clangd",
          },
        },
      },
    },
  },
}
