return {
  "HE7086/code-runner.nvim",
  cmd = "CodeRunnerRun",
  opts = {
    runners = {
      {
        ft = "cpp",
        runner = function()
          local cxx = os.getenv("CXX") or "c++"
          local cxxflags = os.getenv("CXXFLAGS") or ""
          return string.format(
            "%s -std=c++23 -lfmt %s %s -o %s && %s; rm -f %s",
            cxx,
            cxxflags,
            vim.fn.expand("%"),
            vim.fn.expand("%:r"),
            vim.fn.expand("%:p:r"),
            vim.fn.expand("%:r")
          )
        end,
      },
    },
    term = function(command)
      Snacks.terminal(command)
    end,
  },
  keys = {
    { "<F22>", "<Cmd>CodeRunnerRun<Cr>", desc = "Run Code" },
  },
}
