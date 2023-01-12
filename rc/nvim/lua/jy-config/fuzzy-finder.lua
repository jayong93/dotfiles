return {
    setup = function()
        local m = require('fzf-lua')
        local project_nvim = require('project_nvim')
        local project_nvim_project = require('project_nvim.project')
        vim.keymap.set('n', '<leader>ff', m.files, {})
        vim.keymap.set('n', '<leader>fg', m.live_grep, {})
        vim.keymap.set('n', '<leader>fb', m.buffers, {})
        vim.keymap.set('n', '<leader>fh', m.help_tags, {})
        vim.keymap.set('n', '<leader>fk', m.keymaps, {})
        vim.keymap.set('n', '<leader>fs', m.lsp_workspace_symbols, {})
        vim.keymap.set('n', '<leader>fp', function()
            local projects = project_nvim.get_recent_projects()
            m.fzf_exec(projects, {
                actions = {
                    ['default'] = function(project, opts)
                        vim.cmd("cd "..project[1])
                        m.files{cwd=project[1]}
                    end
                }
            })
        end)
        vim.api.nvim_create_user_command('BD', function ()
            m.buffers({actions = {
                ['default'] = function(buffers, opts)
                    require('fzf-lua.actions').buf_del(buffers, opts)
                end
            }})
        end, {nargs = 0})
    end
}
