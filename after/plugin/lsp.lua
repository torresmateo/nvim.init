local lsp = require("lsp-zero")

local augroup = vim.api.nvim_create_augroup("LspFormatting", {})
lsp.preset("recommended")


-- Fix Undefined global 'vim'
lsp.nvim_workspace()


lsp.on_attach(function(client, bufnr)
    local opts = { buffer = bufnr, remap = false }

    vim.keymap.set("n", "gd", function() vim.lsp.buf.definition() end, opts)
    vim.keymap.set("n", "K", function() vim.lsp.buf.hover() end, opts)
    vim.keymap.set("n", "<leader>vws", function() vim.lsp.buf.workspace_symbol() end, opts)
    vim.keymap.set("n", "<leader>vd", function() vim.diagnostic.open_float() end, opts)
    vim.keymap.set("n", "<leader>vca", function() vim.lsp.buf.code_action() end, opts)
    vim.keymap.set("n", "<leader>vrr", function() vim.lsp.buf.references() end, opts)
    vim.keymap.set("n", "<leader>vrn", function() vim.lsp.buf.rename() end, opts)
    vim.keymap.set("i", "<C-h>", function() vim.lsp.buf.signature_help() end, opts)
    if client.supports_method("textDocument/formatting") then
        vim.api.nvim_clear_autocmds({
            group = augroup,
            buffer = bufnr,
        })
        vim.api.nvim_create_autocmd("BufWritePre", {
            group = augroup,
            buffer = bufnr,
            callback = function()
                vim.lsp.buf.format({ bufnr = bufnr })
            end,
        })
    end
end)

vim.filetype.add({ extension = { templ = "templ" } })

lsp.setup()

local cmp = require('cmp')
cmp.setup({
    mapping = {
        ['<CR>'] = cmp.mapping.confirm({ select = false }),
    }
})
