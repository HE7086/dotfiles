local path = require("plenary.path")
local term = require("toggleterm")

local M = {}

M.runners = setmetatable({
  ["c"] = function(dir, file, exe)
    local cc = os.getenv("CC") or "cc"
    local cflags = os.getenv("CFLAGS") or ""
    local p = path.new(dir, exe)
    return string.format("%s -std=c23 %s %s -o %s && %s; rm -f %s", cc, cflags, file, exe, p, p)
  end,
  ["cpp"] = function(dir, file, exe)
    local cxx = os.getenv("CXX") or "c++"
    local cxxflags = os.getenv("CXXFLAGS") or ""
    local p = path.new(dir, exe)
    return string.format("%s -std=c++23 %s -lfmt %s -o %s && %s; rm -f %s", cxx, cxxflags, file, exe, p, p)
  end,
  ["rust"] = function(dir, file, exe)
    local p = path.new(dir, exe)
    return string.format("rustc %s -o %s && %s; rm -f %s", file, exe, p, p)
  end,
  ["python"] = "python",
  ["haskell"] = "runhaskell",
  ["sh"] = "bash",
}, { __index = nil })

function M.run()
  local dir = vim.fn.expand("%:h")
  local file = vim.fn.expand("%")
  local exe = vim.fn.expand("%:r")
  local filetype = vim.bo.filetype
  local runner = M.runners[filetype]
  local command = nil

  if type(runner) == "string" then
    command = runner .. " " .. vim.fn.expand("%:p")
  elseif type(runner) == "function" then
    command = runner(dir, file, exe)
  else
    return
  end

  -- vim.api.nvim_command("tabnew | terminal " .. command)
  term.exec(command, nil, nil, dir, nil, "Code Runner")
end

return M
