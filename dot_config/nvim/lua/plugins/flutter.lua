return {
  "nvim-flutter/flutter-tools.nvim",
  enabled = vim.g.vscode == nil,
  -- tag = 'v1.14.0',
  dependencies = {
    "nvim-lua/plenary.nvim",
    "stevearc/dressing.nvim",
    "saghen/blink.cmp",
  },
  ft = { "dart" },
  config = function()
    local function keymap_opts(desc)
      return {
        noremap = true,
        silent = true,
        desc = desc,
      }
    end
    vim.keymap.set("n", "<Leader>n", "<cmd>FlutterRename<CR>", keymap_opts("Rename"))
    vim.keymap.set("n", "<Leader>o", "<cmd>FlutterOutlineToggle<CR>", keymap_opts("Toggle Outline UI"))
    vim.keymap.set(
      "n",
      "<Leader>m",
      "<cmd>lua require('telescope').extensions.flutter.commands()<CR>",
      keymap_opts("Flutter Commands")
    )

    require("flutter-tools").setup({
      flutter_path = nil,
      flutter_lookup_cmd = "mise where flutter",
      fvm = false,
      root_patterns = { ".git", "pubspec.yaml" },
      ui = {
        border = "rounded",
        notification_style = "native",
      },
      decorations = {
        statusline = {
          device = false, -- {flutter_tools_decorations.app_version} if use lualine
          app_version = false, -- {flutter_tools_decorations.device} if use lualine
          project_config = false,
        },
      },
      debugger = {
        enabled = true,
        run_via_dap = true,
        exception_breakpoints = {},
        evaluate_to_string_in_debug_views = true,
        register_configurations = function(paths)
          local dap = require("dap")
          dap.adapters.dart = {
            type = "executable",
            command = paths.flutter_bin,
            args = { "debug_adapter" },
          }
          dap.configurations.dart = {}
          require("dap.ext.vscode").load_launchjs()
        end,
      },
      widget_guides = {
        enabled = true,
      },
      closing_tags = {
        enabled = true,
        highlight = "Comment",
        prefix = "  ",
        priority = 0,
      },
      dev_log = {
        enabled = true,
        notify_errors = false,
        open_cmd = "botright 15split",
        filter = function(log_line)
          return not log_line:find("ImpellerValidationBreak")
        end,
      },
      dev_tools = {
        autostart = false,
        auto_open_browser = true,
      },
      outline = {
        open_cmd = "rightbelow 50vnew",
        auto_open = false,
      },
      lsp = {
        color = {
          enabled = false,
        },
        on_attach = function(client, bufnr)
          -- inlay hints
          client.server_capabilities.inlayHintProvider = true
          vim.lsp.inlay_hint.enable(true)

          -- Restore dev log buffer
          local dev_log = "__FLUTTER_DEV_LOG__$"
          local get_win = function(buf)
            for _, win in ipairs(vim.api.nvim_list_wins()) do
              if vim.api.nvim_win_get_buf(win) == buf then
                return win
              end
            end
            return nil
          end

          local find_dev_log = function()
            for _, buf in ipairs(vim.api.nvim_list_bufs()) do
              local bufname = vim.api.nvim_buf_get_name(buf)
              if string.match(bufname, dev_log) then
                local win = get_win(buf)
                return buf, win
              end
            end
            return nil
          end

          vim.keymap.set({ "n" }, "<Leader>bl", function()
            local log = require("flutter-tools.log")
            local buf, win = find_dev_log()

            if not buf then
              vim.notify("Flutter Dev Log not found", "warn")
              return
            end

            if win then
              vim.api.nvim_set_current_win(win)
            else
              vim.api.nvim_command("botright 15split")
              vim.api.nvim_set_current_buf(buf)
              win = vim.api.nvim_get_current_win()

              -- Reset module state
              log.win = win
              log.buf = buf

              -- Move to the end of the buffer
              local line_count = vim.api.nvim_buf_line_count(buf)
              if line_count > 0 then
                vim.api.nvim_win_set_cursor(0, { line_count, 0 })
              else
                vim.api.nvim_win_set_cursor(0, { 1, 0 })
              end
            end
          end, keymap_opts("FLUTTER DEV LOG"))
        end,

        capabilities = require("blink.cmp").get_lsp_capabilities(),
        settings = {
          showTodos = true,
          completeFunctionCalls = true,
          analysisExcludedFolders = {
            vim.fn.expand("$HOME/.pub-cache"),
            -- vim.fn.expand '$HOME/.asdf/installs/flutter',
            -- vim.fn.expand '$HOME/.asdf/installs/dart',
            vim.fn.expand("$HOME/.local/share/mise/installs/flutter"),
            vim.fn.expand("$HOME/.local/share/mise/installs/dart"),
          },
          renameFilesWithClasses = "prompt",
          enableSnippets = false,
          updateImportsOnRename = true,
        },
      },
    })

    -- ログバッファを開いてもフォーカスを移動させない
    local ui = require("flutter-tools.ui")
    local original_open_win = ui.open_win
    ---@diagnostic disable-next-line: duplicate-set-field
    ui.open_win = function(cmd, bufnr, opts)
      local current_win = vim.api.nvim_get_current_win()
      original_open_win(cmd, bufnr, opts)
      vim.api.nvim_set_current_win(current_win)
    end

    require("telescope").load_extension("flutter")
  end,
}
