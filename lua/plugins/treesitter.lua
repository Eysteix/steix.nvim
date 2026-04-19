return { 
"nvim-treesitter/nvim-treesitter", 
branch = "main", 
lazy = false,
build = ":TSUpdate" ,
init = function()
  local ensureInstalled =  { "lua", "json", "http", "prisma", "php", "blade", "html", "css", "scss", "cpp", "c" }
  local alreadyInstalled = require('nvim-treesitter.config').get_installed()
  local parsersToInstall = vim.iter(ensureInstalled)
    :filter(function(parser)
      return not vim.tbl_contains(alreadyInstalled, parser)
    end)
    :totable()
  require('nvim-treesitter').install(parsersToInstall)
  vim.api.nvim_create_autocmd('FileType', { 
    callback = function() 
      -- Enable treesitter highlighting and disable regex syntax
      pcall(vim.treesitter.start) 
      vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()" 
    end, 
  }) 
end

}
