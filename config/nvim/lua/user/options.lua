vim.g.better_whitespace_enabled = 1
vim.g.html_number_lines = 0
vim.g.neoterm_autoscroll = 1
vim.g.neoterm_default_mod = 'botright vertical' -- botright
vim.g.neoterm_size = 100
vim.g.ruby_indent_assignment_style = 'variable'
vim.g.strip_whitespace_confirm = 0
vim.g.strip_whitespace_on_save = 1
vim.g.strip_only_modified_lines = 1
vim.g['test#ruby#rspec#options'] = { all = '--format progress' }
vim.g['test#ruby#use_binstubs'] = 0
vim.g['test#strategy'] = 'neoterm'
vim.o.autoread = true
vim.o.clipboard = 'unnamed'
vim.o.completeopt = 'menu,menuone,noselect'
vim.o.cursorline = true
vim.o.expandtab = true
vim.o.foldexpr = "nvim_treesitter#foldexpr()"
vim.o.foldlevel = 15
vim.o.foldmethod = "expr"
vim.o.ignorecase = true
vim.o.inccommand = 'nosplit'
vim.o.mouse = 'a'
vim.o.shiftwidth = 2
vim.o.showtabline = 1
vim.o.smartcase = true
vim.o.smartindent = true
vim.o.softtabstop = 2
vim.opt.spell = true
vim.opt.spelloptions = 'camel'
vim.opt.spelllang = 'en_us'
vim.o.swapfile = false
vim.o.tabstop = 2
vim.o.termguicolors = true
vim.o.wrap = false
vim.wo.number = true
