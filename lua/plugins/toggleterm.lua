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
      -- Explicitly set the correct directions
      direction = "float", -- Default direction
    })

    -- Function to set terminal keymaps
    local function set_terminal_keymaps()
      vim.keymap.set("t", "<Esc>", "<C-\\><C-n>", { noremap = true, silent = true, nowait = true })
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
      -- Set current working directory
      cwd = vim.fn.getcwd(),
    })

    -- Horizontal terminal (F2)
    local term_horizontal = Terminal:new({
      cmd = vim.o.shell,
      direction = "horizontal",
      size = function(term)
        return math.floor(vim.o.lines * 0.3)
      end,
      hidden = true,
      count = 2,
      -- Set current working directory
      cwd = vim.fn.getcwd(),
    })

    -- Additional horizontal terminal (F3)
    local term_horizontal2 = Terminal:new({
      cmd = vim.o.shell,
      direction = "horizontal",
      size = function(term)
        return math.floor(vim.o.lines * 0.3)
      end,
      hidden = true,
      count = 3,
      -- Set current working directory
      cwd = vim.fn.getcwd(),
    })

    -- Key mappings
    vim.keymap.set({ "n", "t" }, "<F1>", function()
      float_term:toggle()
    end, { noremap = true, silent = true })

    vim.keymap.set({ "n", "t" }, "<F2>", function()
      term_horizontal:toggle()
    end, { noremap = true, silent = true })

    vim.keymap.set({ "n", "t" }, "<F3>", function()
      term_horizontal2:toggle()
    end, { noremap = true, silent = true })
  end,
}
