local options = {
    backup = false,                          -- creates a backup file 创建一个备份文件
    clipboard = "unnamedplus",               -- allows neovim to access the system clipboard 允许nvim访问系统剪切板
    cmdheight = 1,                           -- keep status bar position close to bottom 保持状态栏位置靠近底部
    completeopt = { "menuone", "noselect" }, -- mostly just for cmp
    conceallevel = 0,                        -- so that `` is visible in markdown files
    fileencoding = "utf-8",                  -- the encoding written to a file
    hlsearch = true,                         -- highlight all matches on previous search pattern 高亮显示之前搜索模式上的所有匹配项
    ignorecase = true,                       -- ignore case in search patterns
    mouse = "a",                             -- allow the mouse to be used in neovim 允许鼠标的使用
    pumheight = 10,                          -- pop up menu height 弹出菜单的高度
    showmode = false,                        -- we don't need to see things like -- INSERT -- anymore 使用增强状态栏插件后不再需要 vim 的模式提示
    showtabline = 4,                         -- always show tabs 永远显示tabline
    smartcase = true,                        -- smart case
    smartindent = true,                      -- make indenting smarter again 智能缩进
    splitbelow = true,                       -- force all horizontal splits to go below current window 强制水平拆分到当前窗口下方
    splitright = true,                       -- force all vertical splits to go to the right of current window 强制垂直拆分到当前窗口右方
    swapfile = false,                        -- creates a swapfile
    termguicolors = true,                    -- set term gui colors (most terminals support this) 
    timeoutlen = 500,                        -- time to wait for a mapped sequence to complete (in milliseconds) 等待映射序列完成的时间,毫秒
    undofile = true,                         -- enable persistent undo 启用持久撤销
    updatetime = 300,                        -- faster completion (4000ms default)
    writebackup = false,                     -- if a file is being edited by another program (or was written to file while editing with another program), it is not allowed to be edited
    expandtab = true,                        -- convert tabs to spaces 将tab转换为空格
    shiftwidth = 4,                          -- the number of spaces inserted for each indentation 缩进空格数
    tabstop = 4,                             -- insert 4 spaces for a tab 4 个空格为一个tab 
    cursorline = true,                       -- highlight the current line 高亮当前行
    cursorcolumn = false,                     -- cursor column 高亮当前列
    number = true,                           -- set numbered lines
    relativenumber = true,                   -- set relative numbered lines 相对行号
    numberwidth = 4,                         -- set number column width to 2 {default 4}
    signcolumn = "yes",                      -- always show the sign column, otherwise it would shift the text each time 显示左侧图标指示列
    wrap = false,                            -- display lines as one long line
    scrolloff = 8,                           -- keep 8 height offset from above and bottom jkhl 移动时光标周围保留8行
    sidescrolloff = 8,                       -- keep 8 width offset from left and right
    guifont = "monospace:h17",               -- the font used in graphical neovim applications
    foldmethod = "indent",                     -- fold with nvim_treesitter
    -- foldexpr = "nvim_treesitter#foldexpr()",
    foldenable = false,                      -- no fold to be applied when open a file
    foldlevel = 99,                          -- if not set this, fold will be everywhere
    spell = true,                            -- add spell support
    spelllang = { 'en_us' },                 -- support which languages?
    diffopt="vertical,filler,internal,context:4",                      -- vertical diff split view
    cscopequickfix="s-,c-,d-,i-,t-,e-",       -- cscope output to quickfix window
}

vim.opt.shortmess:append "c"

for k, v in pairs(options) do
    vim.opt[k] = v
end

vim.cmd "set whichwrap+=<,>,[,],h,l"
vim.cmd [[set iskeyword+=-]]
vim.cmd [[set formatoptions-=cro]] -- TODO: this doesn't seem to work


-- WSL yank support
vim.cmd [[
let s:clip = '/mnt/c/Windows/System32/clip.exe' 
if executable(s:clip)
    augroup WSLYank
    autocmd!
    autocmd TextYankPost * if v:event.operator ==# 'y' | call system(s:clip, @0) | endif
    augroup END
    endif
    ]]
