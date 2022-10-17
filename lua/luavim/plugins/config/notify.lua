return function()
    local api = vim.api

    require('luavim.core.highlights').plugin('notify', {
        { NotifyERRORBorder = { bg = { from = 'NormalFloat' } } },
        { NotifyWARNBorder = { bg = { from = 'NormalFloat' } } },
        { NotifyINFOBorder = { bg = { from = 'NormalFloat' } } },
        { NotifyDEBUGBorder = { bg = { from = 'NormalFloat' } } },
        { NotifyTRACEBorder = { bg = { from = 'NormalFloat' } } },
        { NotifyERRORBody = { link = 'NormalFloat' } },
        { NotifyWARNBody = { link = 'NormalFloat' } },
        { NotifyINFOBody = { link = 'NormalFloat' } },
        { NotifyDEBUGBody = { link = 'NormalFloat' } },
        { NotifyTRACEBody = { link = 'NormalFloat' } },
    })

    local notify = require('notify')

    notify.setup({
        timeout = 3000,
        stages = 'fade_in_slide_out',
        top_down = true,
        background_colour = 'NormalFloat',
        min_width = function() return math.floor(vim.o.columns * 0.4) end,
        max_width = function() return math.floor(vim.o.columns * 0.4) end,
        max_height = function() return math.floor(vim.o.lines * 0.8) end,
        on_open = function(win)
            if api.nvim_win_is_valid(win) then
                api.nvim_win_set_config(win, { border = core.style.current.border })
            end
        end,
        render = function(...)
            local notif = select(2, ...)
            local style = notif.title[1] == '' and 'minimal' or 'default'
            require('notify.render')[style](...)
        end,
    })
    vim.notify = notify
    core.nnoremap('<leader>nd', notify.dismiss, { desc = 'dismiss notifications' })
end
