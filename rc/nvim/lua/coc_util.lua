local M = {
  show_document = function()
    local allowed_types = {vim = true, help = true}
    if allowed_types[vim.o.filetype] then
      vim.cmd [[
        execute 'h' expand("<cword>")
      ]]
    else
      vim.fn['CocAction']('doHover')
    end
  end
}

return M
