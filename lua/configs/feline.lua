local M = {}

function M.config()
  local present, feline = pcall(require, "feline")
  if present then
    local C = require "default_theme.colors"
    local hl = require("core.status").hl
    local provider = require("core.status").provider
    local conditional = require("core.status").conditional
    local default_hl = { fg = C.fg, bg = C.bg_1 }
    local disabled = { filetypes = { "^NvimTree$", "^neo%-tree$", "^dashboard$", "^Outline$", "^aerial$" } }
    -- stylua: ignore
    feline.setup(astronvim.user_plugin_opts("plugins.feline.statusline", {
      disable = disabled,
      theme = hl.group("StatusLine", default_hl)(),
      components = {
        active = {
          {
            { provider = provider.spacer(), hl = hl.mode() },
            { provider = provider.spacer(2) },
            { provider = "git_branch", hl = hl.fg("Conditional", { fg = C.purple_1, style = "bold" }), icon = " " },
            { provider = provider.spacer(3), enabled = conditional.git_available },
            { provider = { name = "file_info", opts = { type = "unique-short" } }, enabled = conditional.has_filetype },
            { provider = provider.spacer(2), enabled = conditional.has_filetype },
            { provider = "git_diff_added", hl = hl.fg("GitSignsAdd", { fg = C.green }), icon = "  " },
            { provider = "git_diff_changed", hl = hl.fg("GitSignsChange", { fg = C.orange_1 }), icon = " 柳" },
            { provider = "git_diff_removed", hl = hl.fg("GitSignsDelete", { fg = C.red_1 }), icon = "  " },
            { provider = provider.spacer(2), enabled = conditional.git_changed },
            { provider = "diagnostic_errors", hl = hl.fg("DiagnosticError", { fg = C.red_1 }), icon = "  " },
            { provider = "diagnostic_warnings", hl = hl.fg("DiagnosticWarn", { fg = C.orange_1 }), icon = "  " },
            { provider = "diagnostic_info", hl = hl.fg("DiagnosticInfo", { fg = C.white_2 }), icon = "  " },
            { provider = "diagnostic_hints", hl = hl.fg("DiagnosticHint", { fg = C.yellow_1 }), icon = "  " },
          },
          {
            { provider = provider.lsp_progress, enabled = conditional.bar_width() },
            { provider = provider.lsp_client_names(true), short_provider = provider.lsp_client_names(), enabled = conditional.bar_width(), icon = "   " },
            { provider = provider.spacer(2), enabled = conditional.bar_width() },
            { provider = provider.treesitter_status, enabled = conditional.bar_width(), hl = hl.fg("GitSignsAdd", { fg = C.green }) },
            { provider = provider.spacer(2) },
            { provider = "position" },
            { provider = provider.spacer(2) },
            { provider = "line_percentage" },
            { provider = provider.spacer() },
            { provider = "scroll_bar", hl = hl.fg("TypeDef", { fg = C.yellow }) },
            { provider = provider.spacer(2) },
            { provider = provider.spacer(), hl = hl.mode() },
          },
        },
      },
    }))
    -- stylua: ignore
    feline.winbar.setup(astronvim.user_plugin_opts("plugins.feline.winbar", {
      disable = disabled,
      components = {
        active = {
          {
            { provider = provider.breadcrumbs(), enabled = conditional.aerial_available, hl = hl.group("WinBar", default_hl) },
          },
        },
        inactive = {
          {
            { provider = { name = "file_info", opts = { colored_icon = false, type = "unique-short" } }, hl = hl.group("WinBarNC", default_hl) },
          },
        },
      },
    }))
  end
end

return M
