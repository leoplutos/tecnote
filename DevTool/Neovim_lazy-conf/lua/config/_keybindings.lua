--配置路径为 %LOCALAPPDATA%\nvim\lua
-- 全局快捷键绑定

function default_kb_opts(desc)
  return { desc = desc, noremap = true, silent = true, nowait = true }
end

vim.keymap.set('n', 'J', '10j', default_kb_opts('Down 10 Line'))
vim.keymap.set('n', 'K', '10k', default_kb_opts('Up 10 Line'))
vim.keymap.set('i', '<C-j>', '<down>', default_kb_opts('Down'))
vim.keymap.set('i', '<C-k>', '<up>', default_kb_opts('Up'))
vim.keymap.set('i', '<C-l>', '<right>', default_kb_opts('Right'))
vim.keymap.set('i', '<C-h>', '<left>', default_kb_opts('Left'))
vim.keymap.set({ 'i', 'c' }, '<C-a>', '<home>', default_kb_opts('Home'))
vim.keymap.set({ 'i', 'c' }, '<C-e>', '<end>', default_kb_opts('End'))
vim.keymap.set('n', '<TAB>w', '<C-w>w', default_kb_opts('Move to next Window'))
--在只读和可写之间切换
vim.keymap.set('n', '<leader>rd', '<cmd>setl ma! ma?<cr>', default_kb_opts('Toggle Buffer Readonly'))
