local map = vim.api.nvim_set_keymap
local opts = { noremap = true, silent = true }

-- Testing
map('n', '<Leader>t', ':TestNearest<CR>', opts)
map('n', '<Leader>T', ':TestFile<CR>', opts)
map('n', '<Leader>TT', ':TestSuite<CR>', opts)

-- Split resize
map('n', '<Leader>>', '10<C-w>>', opts)
map('n', '<Leader><', '10<C-w><', opts)

-- Quick semi
map('n', '<Leader>;', '$a;<Esc>', opts)

map('n', '<Leader>w', ':w<CR>', opts)
map('n', '<Leader>q', ':q<CR>', opts)
map('n', '<Leader>Q', ':q!<CR>', opts)

-- Shorter commands
vim.cmd('cnoreabbrev tree NERDTreeToggle')
vim.cmd('cnoreabbrev blame Gblame')
vim.cmd('cnoreabbrev find NERDTreeFind')
vim.cmd('cnoreabbrev diff Gdiff')

-- Plugs
map('n', '<Leader>nt', ':NERDTreeFind<CR>', opts)
map('n', '<Leader>p', ':Files<CR>', opts)
map('n', '<Leader>ag', ':Ag<CR>', opts)

-- Tmux navigator
map('n', '<Leader><C-h>', ':TmuxNavigateLeft<cr>', opts)
map('n', '<Leader><C-j>', ':TmuxNavigateDown<cr>', opts)
map('n', '<Leader><C-k>', ':TmuxNavigateUp<cr>', opts)
map('n', '<Leader><C-l>', ':TmuxNavigateRight<cr>', opts)

-- Remap keys for gotos
map('n', 'gd', '<Plug>(coc-definition)', opts)
map('n', 'gy', '<Plug>(coc-type-definition)', opts)
map('n', 'gi', '<Plug>(coc-implementation)', opts)
map('n', 'gr', '<Plug>(coc-references)', opts)

-- Remap surround to lowercase s so it does not add an empty space
vim.api.nvim_set_keymap('x', 's', '<Plug>VSurround', opts)

-- Diagnostics
map('n', '<Leader>P', ':let @*=expand("%")<CR>', opts)

-- Tabs navigation
map('n', '<Leader>h', ':tabprevious<cr>', opts)
map('n', '<Leader>l', ':tabnext<cr>', opts)

-- Buffers
map('n', '<Leader>ob', ':Buffers<cr>', opts)

-- Keeping it centered
map('n', 'n', 'nzzzv', opts)
map('n', 'N', 'Nzzzv', opts)
map('n', 'J', 'mzJ`z', opts)

-- Moving text
map('v', 'J', ':m \'>+1<CR>gv=gv', opts)
map('v', 'K', ':m \'<-2<CR>gv=gv', opts)
map('n', '<Leader>k', ':m .-2<CR>==', opts)
map('n', '<Leader>j', ':m .+1<CR>==', opts)

-- Faster scrolling
map('n', '<C-j>', '10<C-e>', opts)
map('n', '<C-k>', '10<C-y>', opts)
map('n', '<Leader>s', '<Plug>(easymotion-s2)', opts)

-- Git
map('n', '<Leader>G', ':G<cr>', opts)
map('n', '<Leader>gp', ':Gpush<cr>', opts)
map('n', '<Leader>gl', ':Gpull<cr>', opts)

-- Run current file
map('n', '<Leader>x', ':!node %<cr>', opts)

-- Terminal
vim.api.nvim_set_keymap('n', '<C-t>', ':lua OpenTerminal()<CR>', opts)

function OpenTerminal()
  -- Move to right most buffer
  vim.cmd("normal \<C-l>")
  vim.cmd("normal \<C-l>")
  vim.cmd("normal \<C-l>")
  vim.cmd("normal \<C-l>")

  local bufNum = vim.fn.bufnr("%")
  local bufType = vim.fn.getbufvar(bufNum, "&buftype", "not found")

  if bufType == "terminal" then
    -- Close existing terminal
    vim.cmd("q")
  else
    -- Open terminal
    vim.cmd("vsp term://zsh")

    -- Turn off numbers
    vim.cmd("set nonu")
    vim.cmd("set nornu")

    -- Toggle insert on enter/exit
    vim.cmd("autocmd BufLeave <buffer> stopinsert!")
    vim.cmd("autocmd BufWinEnter,WinEnter <buffer> startinsert!")

    -- Set mappings inside terminal buffer
    vim.api.nvim_buf_set_keymap(0, 't', '<C-h>', '<C-\\><C-n><C-w><C-h>', opts)
    vim.api.nvim_buf_set_keymap(0, 't', '<C-t>', '<C-\\><C-n>:q<CR>', opts)
    vim.api.nvim_buf_set_keymap(0, 't', '<C-\\><C-\\>', '<C-\\><C-n>', opts)

    vim.cmd("startinsert!")
  end
end

-- Parens and quotes handling
local function parens_indent()
  local prev = vim.fn.col('.') - 1
  local after = vim.fn.col('.')
  local prevChar = vim.fn.matchstr(vim.fn.getline('.'), '\\%' .. prev .. 'c.')
  local afterChar = vim.fn.matchstr(vim.fn.getline('.'), '\\%' .. after .. 'c.')
  if (prevChar == '"' and afterChar == '"') or
     (prevChar == "'" and afterChar == "'") or
     (prevChar == "(" and afterChar == ")") or
     (prevChar == "{" and afterChar == "}") or
     (prevChar == "[" and afterChar == "]") then
    return "<CR><Esc>O"
  end
  return "<CR>"
end
vim.api.nvim_set_keymap('i', '<CR>', 'v:lua.parens_indent()', { noremap = true, expr = true })

local function parens_spacing()
  local prev = vim.fn.col('.') - 1
  local after = vim.fn.col('.')
  local prevChar = vim.fn.matchstr(vim.fn.getline('.'), '\\%' .. prev .. 'c.')
  local afterChar = vim.fn.matchstr(vim.fn.getline('.'), '\\%' .. after .. 'c.')
  if (prevChar == '"' and afterChar == '"') or
     (prevChar == "'" and afterChar == "'") or
     (prevChar == "(" and afterChar == ")") or
     (prevChar == "{" and afterChar == "}") or
     (prevChar == "[" and afterChar == "]") then
    return "<space><space><left>"
  end
  return "<space>"
end
vim.api.nvim_set_keymap('i', '<space>', 'v:lua.parens_spacing()', { noremap = true, expr = true })

local function parens_remove_spacing()
  local prev = vim.fn.col('.') - 1
  local after = vim.fn.col('.')
  local prevChar = vim.fn.matchstr(vim.fn.getline('.'), '\\%' .. prev .. 'c.')
  local afterChar = vim.fn.matchstr(vim.fn.getline('.'), '\\%' .. after .. 'c.')

  if (prevChar == '"' and afterChar == '"') or
     (prevChar == "'" and afterChar == "'") or
     (prevChar == "(" and afterChar == ")") or
     (prevChar == "{" and afterChar == "}") or
     (prevChar == "[" and afterChar == "]") then
    return "<bs><right><bs>"
  end

  if prevChar == ' ' and afterChar == ' ' then
    prev = vim.fn.col('.') - 2
    after = vim.fn.col('.') + 1
    prevChar = vim.fn.matchstr(vim.fn.getline('.'), '\\%' .. prev .. 'c.')
    afterChar = vim.fn.matchstr(vim.fn.getline('.'), '\\%' .. after .. 'c.')
    if (prevChar == '"' and afterChar == '"') or
       (prevChar == "'" and afterChar == "'") or
       (prevChar == "(" and afterChar == ")") or
       (prevChar == "{" and afterChar == "}") or
       (prevChar == "[" and afterChar == "]") then
      return "<bs><right><bs>"
    end
  end

  return "<bs>"
end
vim.api.nvim_set_keymap('i', '<BS>', 'v:lua.parens_remove_spacing()', { noremap = true, expr = true })

-- Handle brackets and parens input
vim.api.nvim_set_keymap('i', '{', '{}<left>', opts)
vim.api.nvim_set_keymap('i', '(', '()<left>', opts)
vim.api.nvim_set_keymap('i', '[', '[]<left>', opts)
vim.api.nvim_set_keymap('i', "'", "''<left>", opts)
vim.api.nvim_set_keymap('i', '"', '""<left>', opts)
