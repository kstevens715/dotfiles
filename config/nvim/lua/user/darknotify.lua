local M = {
  'cormacrelf/dark-notify'
}

function M.config()
  require('dark_notify').run({
    schemes = {
      dark = 'nightfox',
      light = 'dayfox',
    }
  })
end

return M
