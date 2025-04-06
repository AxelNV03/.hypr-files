-- Definición de plugins usando lazy.nvim
local plug = require('lazy').setup

return plug({
  -- syntax
  { 'sheerun/vim-polyglot' },
  { 'styled-components/vim-styled-components', branch = 'main' },
  { 'norcalli/nvim-colorizer.lua' },

  -- status bar
  { 'maximbaz/lightline-ale' },
  { 'itchyny/lightline.vim' },

  -- Themes
  { 'morhetz/gruvbox' },
  { 'shinchu/lightline-gruvbox.vim' },

  -- Tree
  { 'scrooloose/nerdtree' },

  -- typing
  { 'alvan/vim-closetag' },
  { 'tpope/vim-surround' },

  -- tmux
  { 'benmills/vimux' },
  { 'christoomey/vim-tmux-navigator' },

  -- autocomplete
  { 'sirver/ultisnips' },
  { 'neoclide/coc.nvim', branch = 'release' },

  -- test
  { 'tyewang/vimux-jest-test' },
  { 'janko-m/vim-test' },

  -- IDE
  { 'editorconfig/editorconfig-vim' },
  { 'junegunn/fzf' },
  { 'junegunn/fzf.vim' },
  { 'terryma/vim-multiple-cursors' },
  { 'easymotion/vim-easymotion' },
  { 'mhinz/vim-signify' },
  { 'yggdroot/indentline' },
  { 'scrooloose/nerdcommenter' },

  -- git
  { 'tpope/vim-fugitive' },

  { 'tpope/vim-repeat' }
})
