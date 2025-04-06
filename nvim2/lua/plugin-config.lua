-- HTML, JSX
vim.g.closetag_filenames = '*.html,*.js,*.jsx,*.ts,*.tsx'

-- Lightline
vim.g.lightline = {
  active = {
    left = { {'mode', 'paste'}, {}, {'relativepath', 'modified'} },
    right = { {'kitestatus'}, {'filetype', 'percent', 'lineinfo'}, {'gitbranch'} },
  },
  inactive = {
    left = { {'inactive'}, {'relativepath'} },
    right = { {'bufnum'} },
  },
  component = {
    bufnum = '%n',
    inactive = 'inactive',
  },
  component_function = {
    gitbranch = 'fugitive#head',
    kitestatus = 'kite#statusline',
  },
  colorscheme = 'gruvbox',
  subseparator = { left = '', right = '' }
}

-- NERDTree
vim.g.NERDTreeShowHidden = 1
vim.g.NERDTreeQuitOnOpen = 1
vim.g.NERDTreeAutoDeleteBuffer = 1
vim.g.NERDTreeMinimalUI = 1
vim.g.NERDTreeDirArrows = 1
vim.g.NERDTreeShowLineNumbers = 1
vim.g.NERDTreeMapOpenInTab = '\t'

-- Trigger configuration (UltiSnips)
vim.g.UltiSnipsSnippetDirectories = { os.getenv("HOME") .. '/configs/.vim/UltiSnips' }
vim.g.UltiSnipsExpandTrigger = "<tab>"
vim.g.UltiSnipsListSnippets = "<C-_>"
vim.g.UltiSnipsJumpForwardTrigger = "<tab>"
vim.g.UltiSnipsJumpBackwardTrigger = "<S-tab>"

-- Kite
-- vim.g.kite_supported_languages = {'*'}
vim.g.coc_global_extensions = { 'coc-tsserver' }

-- tmux navigator
vim.g.tmux_navigator_no_mappings = 1

-- coc
vim.cmd([[autocmd FileType scss setl iskeyword+=@-@]])

-- vim fugitive
vim.cmd([[
command! -bang -nargs=? -complete=dir GFiles
  \ call fzf#vim#gitfiles(<q-args>, fzf#vim#with_preview(), <bang>0)

command! -bang -nargs=* Ag
  \ call fzf#vim#ag(<q-args>, fzf#vim#with_preview(), <bang>0)

command! -bang -nargs=? -complete=dir Files
  \ call fzf#vim#files(<q-args>, fzf#vim#with_preview(), <bang>0)
]])

-- General settings
vim.opt.hidden = true
vim.opt.backup = false
vim.opt.writebackup = false
vim.opt.cmdheight = 1
vim.opt.updatetime = 300
vim.opt.shortmess:append('c')
vim.opt.signcolumn = 'yes'
vim.opt.diffopt:append('vertical')

-- FZF options
vim.g.FZF_DEFAULT_OPTS = '--layout=reverse'

-- function to create floating window for fzf (optional)
--[[
function! FloatingFZF()
  let buf = nvim_create_buf(v:false, v:true)
  call setbufvar(buf, '&signcolumn', 'no')
  let height = float2nr((&lines - 3) / 2)
  let width = float2nr(&columns - (&columns * 2 / 10))
  let col = float2nr((&columns - width) / 2)
  let row = float2nr((&lines - height) / 2)
  let opts = {
    \ 'relative': 'editor',
    \ 'row': row,
    \ 'col': col,
    \ 'width': width,
    \ 'height': height
    \ }
  call nvim_open_win(buf, v:true, opts)
endfunction
]]--
