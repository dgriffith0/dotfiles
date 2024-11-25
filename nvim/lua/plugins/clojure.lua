return {
  { "Olical/conjure",
    event = "BufEnter *.clj,*.edn,*.lua,*.janet",
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
  }
}
