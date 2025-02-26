return {
  "akinsho/toggleterm.nvim",
  version = "*",
  config = function()
    require("toggleterm").setup({
      -- Common configuration for all terminals
      shade_terminals = false,
      close_on_exit = true,
      persist_mode = false,
      start_in_insert = true,
      float_opts = {
        border = "curved",
      },
    })

    -- Function to set terminal direction
    local function set_terminal_keymaps()
      vim.keymap.set("t", "<Esc>", "<C-\\><C-n>", { noremap = true, silent = true })
    end

    -- Create an autocmd that will run when the terminal opens
    vim.api.nvim_create_autocmd("TermOpen", {
      pattern = "term://*toggleterm#*",
      callback = function()
        set_terminal_keymaps()
      end,
    })

    -- Define the terminals
    local Terminal = require("toggleterm.terminal").Terminal

    -- Floating terminal (F1)
    local float_term = Terminal:new({
      cmd = vim.o.shell,
      direction = "float",
      hidden = true,
      count = 1,
    })

    -- Left terminal (F2)
    local term_left = Terminal:new({
      cmd = vim.o.shell,
      direction = "horizontal",
      hidden = true,
      count = 2,
    })

    -- Key mappings
    vim.keymap.set({ "n", "t" }, "<F1>", function()
      float_term:toggle()
    end, { noremap = true, silent = true })

    vim.keymap.set({ "n", "t" }, "<F2>", function()
      term_left:toggle()
    end, { noremap = true, silent = true })
  end,
}
