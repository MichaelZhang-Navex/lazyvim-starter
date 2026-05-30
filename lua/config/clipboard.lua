local M = {}

local function is_wsl()
  if vim.fn.has("wsl") == 1 then
    return true
  end

  local kernel_release = "/proc/sys/kernel/osrelease"
  if vim.fn.filereadable(kernel_release) == 0 then
    return false
  end

  local ok, lines = pcall(vim.fn.readfile, kernel_release)
  if not ok or not lines[1] then
    return false
  end

  return lines[1]:lower():find("microsoft", 1, true) ~= nil
end

local function configure()
  if vim.fn.has("macunix") == 1 then
    vim.g.clipboard = {
      name = "macOS",
      copy = {
        ["+"] = "pbcopy",
        ["*"] = "pbcopy",
      },
      paste = {
        ["+"] = "pbpaste",
        ["*"] = "pbpaste",
      },
      cache_enabled = 0,
    }
  elseif is_wsl() then
    vim.g.clipboard = {
      name = "WslClipboard",
      copy = {
        ["+"] = "clip.exe",
        ["*"] = "clip.exe",
      },
      paste = {
        ["+"] = 'powershell.exe -c [Console]::Out.Write($(Get-Clipboard -Raw).tostring().replace("`r", ""))',
        ["*"] = 'powershell.exe -c [Console]::Out.Write($(Get-Clipboard -Raw).tostring().replace("`r", ""))',
      },
      cache_enabled = 0,
    }
  end
end

function M.setup()
  configure()

  vim.api.nvim_create_autocmd("User", {
    group = vim.api.nvim_create_augroup("config_clipboard", { clear = true }),
    pattern = "LazyVimOptions",
    callback = configure,
  })
end

return M
