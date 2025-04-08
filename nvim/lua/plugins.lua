return require('packer').startup(function(use)
    -- Packer se gestiona a sí mismo
    use 'wbthomason/packer.nvim'
    
    -- Tema Gruvbox
    use 'morhetz/gruvbox'  -- Para Vim original

    -- Barra de estado
    use "nvim-lualine/lualine.nvim"

    -- Explorador de archivos
    use "preservim/nerdtree"
    
  end)