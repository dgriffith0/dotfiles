 local ok,snippets = pcall(require, 'luasnip')

if not ok then
  return
end

-- require("luasnip.loaders.from_vscode").lazy_load()
snippets.loaders.from_vscode.lazy_load()
