require("myplugins.code_runner")
require("myplugins.status_line")
require("myplugins.neovide")

local noremap = require("util.keymap").noremap

noremap("n", "<F22>", "<CMD>lua require('myplugins.code_runner').run()<CR>")
noremap("n", "<S-F10>", "<CMD>lua require('myplugins.code_runner').run()<CR>")

