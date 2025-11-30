return {
  "mfussenegger/nvim-dap",
  enabled = vim.g.vscode == nil,
  dependencies = {
    "nvim-neotest/nvim-nio",
    "theHamsta/nvim-dap-virtual-text",
    -- 'rcarriga/nvim-dap-ui',
    {
      "igorlfs/nvim-dap-view",
      opts = {
        windows = {
          terminal = {
            hide = { "dart" },
            start_hidden = true,
          },
        },
      },
    },
    "nvim-telescope/telescope-dap.nvim",
    "Weissle/persistent-breakpoints.nvim",
  },
  event = "LspAttach",
  config = function()
    require("persistent-breakpoints").setup({
      load_breakpoints_event = { "BufReadPost" },
    })
    local function keymap_opts(desc)
      return {
        noremap = true,
        silent = true,
        desc = desc,
      }
    end
    vim.keymap.set(
      "n",
      "<Leader>b",
      "<cmd>lua require('persistent-breakpoints.api').toggle_breakpoint()<CR>",
      keymap_opts("Toggle Breakpoint")
    )
    vim.keymap.set(
      "n",
      "<Leader>B",
      "<cmd>lua require('persistent-breakpoints.api').clear_all_breakpoints()<CR>",
      keymap_opts("Clear All Breakpoints")
    )
    vim.keymap.set(
      "n",
      "<Leader>bb",
      "<cmd>lua require('persistent-breakpoints.api').set_conditional_breakpoint()<CR>",
      keymap_opts("Set Conditional Breakpoint")
    )
    vim.keymap.set(
      "n",
      "<Leader>bl",
      "<cmd>lua require('persistent-breakpoints.api').set_log_point()<CR>",
      keymap_opts("Set Log Point")
    )
    vim.keymap.set("n", "<Leader>bc", "<cmd>lua require('dap').continue()<CR>", keymap_opts("Dap Continue"))
    vim.keymap.set("n", "<Leader>bi", "<cmd>lua require('dap').step_into()<CR>", keymap_opts("Dap Step Into"))
    vim.keymap.set("n", "<Leader>bo", "<cmd>lua require('dap').step_out()<CR>", keymap_opts("Dap Step Out"))
    vim.keymap.set("n", "<Leader>bn", "<cmd>lua require('dap').step_over()<CR>", keymap_opts("Dap Step Over"))
    -- vim.keymap.set(
    --   'n',
    --   '<Leader>bw',
    --   "<cmd>lua require('dapui').elements.watches.add()<CR>",
    --   keymap_opts 'Dap Add Watch'
    -- )
    -- vim.keymap.set('n', '<Leader>bu', "<cmd>lua require('dapui').toggle()<CR>", keymap_opts 'Dap Toggle UI')
    vim.keymap.set("n", "<Leader>bu", "<cmd>DapViewToggle<CR>", keymap_opts("Dap Toggle UI"))

    local repl = require("dap.repl")
    repl.commands = vim.tbl_extend("force", repl.commands, {
      continue = { ".continue", "continue", "c" },
      next_ = { ".next", "next", "n" },
      step_back = { ".back", "back", "b" },
      reverse_continue = { ".reverse-continue", "reverse-continue", "rc" },
      into = { ".into", "into", "i" },
      into_targets = { ".into-targets", "into-targets", "it" },
      out = { ".out", "out", "o" },
      scopes = { ".scopes", "scopes", "s" },
      threads = { ".threads", "threads", "t" },
      frames = { ".frames", "frames", "f" },
      exit = { ".exit", "exit", "e", "q" },
      up = { ".up", "up", "u" },
      down = { ".down", "down", "d" },
      goto_ = { ".goto", "goto", "g" },
      pause = { ".pause", "pause", "p" },
      clear = { ".clear", "clear", "cr" },
      capabilities = { ".capabilities", "capabilities", "cap" },
      help = { ".help", "help", "h" },
      custom_commands = {},
    })

    vim.api.nvim_create_autocmd("FileType", { -- add completion in DAP Repl
      group = vim.api.nvim_create_augroup("dap", { clear = true }),
      pattern = "dap-repl",
      callback = function()
        require("dap.ext.autocompl").attach()
      end,
    })

    -- dap-repl の dap> プロンプトの色を変更
    vim.cmd([[
          hi DapReplPrompt guifg=#f9c859 gui=NONE
          augroup dapui_highlights
            autocmd!
            autocmd FileType dap-repl syntax match DapReplPrompt '^dap>'
          augroup END
        ]])

    -- Breakpoint の現在行をハイライト
    vim.cmd("hi DapCurrentLine  guibg=#304577")

    vim.api.nvim_set_hl(0, "white", { fg = "#ffffff" })
    vim.api.nvim_set_hl(0, "green", { fg = "#3fc56b" })
    vim.api.nvim_set_hl(0, "yellow", { fg = "#f9c859" })
    vim.fn.sign_define("DapBreakpoint", { text = " ", texthl = "white" })
    vim.fn.sign_define("DapBreakpointCondition", { text = " ", texthl = "white" })
    vim.fn.sign_define("DapBreakpointRejected", { text = " ", texthl = "white" })
    vim.fn.sign_define("DapStopped", { text = "󰁕 ", texthl = "green", linehl = "DapCurrentLine" })
    vim.fn.sign_define("DapLogPoint", { text = " ", texthl = "yellow" })

    require("nvim-dap-virtual-text").setup({
      virt_text_pos = "eol",
    })
    -- require('dapui').setup {
    --   icons = { collapsed = '', current_frame = '', expanded = '' },
    --   floating = { border = 'rounded', mappings = { close = { 'q', '<Esc>' } } },
    --   controls = {
    --     element = 'repl',
    --     enabled = true,
    --     icons = {
    --       disconnect = '',
    --       pause = '',
    --       play = '',
    --       run_last = '',
    --       step_back = '',
    --       step_into = '',
    --       step_out = '',
    --       step_over = '',
    --       terminate = '',
    --     },
    --   },
    --   layouts = {
    --     {
    --       elements = {
    --         { id = 'watches', size = 0.25 },
    --         { id = 'scopes', size = 0.25 },
    --         { id = 'breakpoints', size = 0.25 },
    --         { id = 'stacks', size = 0.25 },
    --       },
    --       size = 15,
    --       position = 'bottom',
    --     },
    --     {
    --       elements = {
    --         'repl',
    --       },
    --       size = 50,
    --       position = 'right',
    --     },
    --   },
    -- }

    local dap, dv = require("dap"), require("dap-view")
    dap.listeners.after.event_initialized["dap-view-config"] = function()
      -- Inlay hints を非表示にする
      -- vim.cmd 'lua vim.lsp.inlay_hint.enable(false)'
      -- dv.open()
    end
    dap.listeners.after.event_terminated["dap-view-config"] = function()
      -- Inlay hints を表示にする
      -- vim.cmd 'lua vim.lsp.inlay_hint.enable(true)'
      -- dv.close()
    end
    require("telescope").load_extension("dap")
  end,
}
