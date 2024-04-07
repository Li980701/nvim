local lsp = require('lsp-zero')
require('lspconfig').intelephense.setup({})
local lsp_zero = require('lsp-zero')

-- command mapping configuration
local cmp = require('cmp')
local cmp_select = {behavior = cmp.SelectBehavior.select}
local cmp_mappings = lsp.defaults.cmp_mappings ({
    ['<C-p>'] = cmp.mapping.select_prev_item(cmp_select),
    ['<C-n>'] = cmp.mapping.select_next_item(cmp_select),
    ['<C-y>'] = cmp.mapping.confirm({ select = true }),
    ['<C-Space>'] = cmp.mapping.complete(),
})

cmp.setup({

    window = {
        completion = cmp.config.window.bordered(),
        documentation = cmp.config.window.bordered(),
    },
    mapping = cmp_mappings
})

-- language server setup
-- key mappings
lsp_zero.on_attach(function(client, bufnr)
    local opts = {buffer = bufnr, remap = false}

    vim.keymap.set("n", "gd", function() vim.lsp.buf.definition() end, opts)
    vim.keymap.set("n", "K", function() vim.lsp.buf.hover() end, opts)
    vim.keymap.set("n", "<leader>vws", function() vim.lsp.buf.workspace_symbol() end, opts)
    vim.keymap.set("n", "<leader>vd", function() vim.diagnostic.open_float() end, opts)
    vim.keymap.set("n", "[d", function() vim.diagnostic.goto_next() end, opts)
    vim.keymap.set("n", "]d", function() vim.diagnosticb.goto_prev() end, opts)
    vim.keymap.set("n", "<leader>vca", function() vim.lsp.buf.code_action() end, opts)
    vim.keymap.set("n", "<leader>vrr", function() vim.lsp.buf.references() end, opts)
    vim.keymap.set("n", "<leader>vrn", function() vim.lsp.buf.rename() end, opts)
    vim.keymap.set("n", "<C-h>", function() vim.lsp.buf.signature_help() end, opts)
end)
lsp_zero.setup()

-- to learn how to use mason.nvim with lsp-zero
-- read this: https://github.com/VonHeikemen/lsp-zero.nvim/blob/v3.x/doc/md/guide/integrate-with-mason-nvim.md
require('mason').setup({})
require('mason-lspconfig').setup({
    ensure_installed = {
        'tsserver', 'rust_analyzer'
    },
    handlers = {
        lsp_zero.default_setup,
        bashls = function()
            require('lspconfig').bashls.setup({
                -- Add your custom configuration for bash-language-server here
            })
        end,
        lua_ls = function()
            require('lspconfig').lua_ls.setup({
                -- Add your custom configuration for lua-language-server here
                settings = {
                    Lua = {
                        diagnostics = {
                            globals = { 'vim' }
                        }
                    }
                }
            })
        end,
        jdtls = function()
            require('lspconfig').jdtls.setup({
                -- Add your custom configuration for java-language-server here
            })
        end,
    }
})

