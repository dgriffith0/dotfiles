return {
  'windwp/nvim-autopairs',
  event = "InsertEnter",
  config = function()
    require("user.autopairs").setup()
  end
}
