return {
  {
    "Olical/conjure",
    event = "BufEnter *.clj,*.edn,*.lua,*.janet,*.py",
    config = function()
      require('user.clojure').setup()
    end
  },
  {
    "julienvincent/nvim-paredit",
    event = "BufEnter *.clj,*.edn",
    config = function()
      require("nvim-paredit").setup()
    end
  },
  {
    'clojure-vim/vim-jack-in',
    dependencies = {
      'tpope/vim-dispatch',
      'radenling/vim-dispatch-neovim',
    }
  }
}
