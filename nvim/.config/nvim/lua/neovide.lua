local hostname = vim.loop.os_gethostname()

if hostname == "HE-workstation" then
    vim.o.guifont = "Iosevka HE7086:h13"
elseif hostname == "HE-TP" then
    vim.o.guifont = "Iosevka HE7086:h9"
else
    vim.o.guifont = "Iosevka HE7086"
end
