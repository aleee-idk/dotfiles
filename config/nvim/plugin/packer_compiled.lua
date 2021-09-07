-- Automatically generated packer.nvim plugin loader code

if vim.api.nvim_call_function('has', {'nvim-0.5'}) ~= 1 then
  vim.api.nvim_command('echohl WarningMsg | echom "Invalid Neovim version for packer.nvim! | echohl None"')
  return
end

vim.api.nvim_command('packadd packer.nvim')

local no_errors, error_msg = pcall(function()

  local time
  local profile_info
  local should_profile = false
  if should_profile then
    local hrtime = vim.loop.hrtime
    profile_info = {}
    time = function(chunk, start)
      if start then
        profile_info[chunk] = hrtime()
      else
        profile_info[chunk] = (hrtime() - profile_info[chunk]) / 1e6
      end
    end
  else
    time = function(chunk, start) end
  end
  
local function save_profiles(threshold)
  local sorted_times = {}
  for chunk_name, time_taken in pairs(profile_info) do
    sorted_times[#sorted_times + 1] = {chunk_name, time_taken}
  end
  table.sort(sorted_times, function(a, b) return a[2] > b[2] end)
  local results = {}
  for i, elem in ipairs(sorted_times) do
    if not threshold or threshold and elem[2] > threshold then
      results[i] = elem[1] .. ' took ' .. elem[2] .. 'ms'
    end
  end

  _G._packer = _G._packer or {}
  _G._packer.profile_output = results
end

time([[Luarocks path setup]], true)
local package_path_str = "/home/aleidk/.cache/nvim/packer_hererocks/2.0.5/share/lua/5.1/?.lua;/home/aleidk/.cache/nvim/packer_hererocks/2.0.5/share/lua/5.1/?/init.lua;/home/aleidk/.cache/nvim/packer_hererocks/2.0.5/lib/luarocks/rocks-5.1/?.lua;/home/aleidk/.cache/nvim/packer_hererocks/2.0.5/lib/luarocks/rocks-5.1/?/init.lua"
local install_cpath_pattern = "/home/aleidk/.cache/nvim/packer_hererocks/2.0.5/lib/lua/5.1/?.so"
if not string.find(package.path, package_path_str, 1, true) then
  package.path = package.path .. ';' .. package_path_str
end

if not string.find(package.cpath, install_cpath_pattern, 1, true) then
  package.cpath = package.cpath .. ';' .. install_cpath_pattern
end

time([[Luarocks path setup]], false)
time([[try_loadstring definition]], true)
local function try_loadstring(s, component, name)
  local success, result = pcall(loadstring(s))
  if not success then
    vim.schedule(function()
      vim.api.nvim_notify('packer.nvim: Error running ' .. component .. ' for ' .. name .. ': ' .. result, vim.log.levels.ERROR, {})
    end)
  end
  return result
end

time([[try_loadstring definition]], false)
time([[Defining packer_plugins]], true)
_G.packer_plugins = {
  ["cheatsheet.nvim"] = {
    loaded = true,
    path = "/home/aleidk/.local/share/nvim/site/pack/packer/start/cheatsheet.nvim"
  },
  ["dashboard-nvim"] = {
    loaded = false,
    needs_bufread = false,
    path = "/home/aleidk/.local/share/nvim/site/pack/packer/opt/dashboard-nvim"
  },
  ["dracula.nvim"] = {
    loaded = true,
    path = "/home/aleidk/.local/share/nvim/site/pack/packer/start/dracula.nvim"
  },
  ["focus.nvim"] = {
    config = { "\27LJ\1\2-\0\0\2\0\2\0\0044\0\0\0%\1\1\0>\0\2\1G\0\1\0\18plugins.focus\frequire\0" },
    loaded = true,
    path = "/home/aleidk/.local/share/nvim/site/pack/packer/start/focus.nvim"
  },
  ["formatter.nvim"] = {
    loaded = true,
    path = "/home/aleidk/.local/share/nvim/site/pack/packer/start/formatter.nvim"
  },
  ["fzf-gitignore"] = {
    loaded = true,
    path = "/home/aleidk/.local/share/nvim/site/pack/packer/start/fzf-gitignore"
  },
  ["gitsigns.nvim"] = {
    config = { 'require("plugins.gitsigns")' },
    loaded = true,
    path = "/home/aleidk/.local/share/nvim/site/pack/packer/start/gitsigns.nvim"
  },
  ["glow.nvim"] = {
    loaded = true,
    path = "/home/aleidk/.local/share/nvim/site/pack/packer/start/glow.nvim"
  },
  harpoon = {
    loaded = true,
    path = "/home/aleidk/.local/share/nvim/site/pack/packer/start/harpoon"
  },
  ["indent-blankline.nvim"] = {
    loaded = true,
    path = "/home/aleidk/.local/share/nvim/site/pack/packer/start/indent-blankline.nvim"
  },
  kommentary = {
    loaded = true,
    path = "/home/aleidk/.local/share/nvim/site/pack/packer/start/kommentary"
  },
  ["lsp_signature.nvim"] = {
    loaded = true,
    path = "/home/aleidk/.local/share/nvim/site/pack/packer/start/lsp_signature.nvim"
  },
  ["lspkind-nvim"] = {
    loaded = true,
    path = "/home/aleidk/.local/share/nvim/site/pack/packer/start/lspkind-nvim"
  },
  ["lspsaga.nvim"] = {
    config = { "\27LJ\1\2/\0\0\2\0\2\0\0044\0\0\0%\1\1\0>\0\2\1G\0\1\0\20plugins.lspsaga\frequire\0" },
    loaded = true,
    path = "/home/aleidk/.local/share/nvim/site/pack/packer/start/lspsaga.nvim"
  },
  ["lualine.nvim"] = {
    loaded = true,
    path = "/home/aleidk/.local/share/nvim/site/pack/packer/start/lualine.nvim"
  },
  ["moonlight.nvim"] = {
    loaded = true,
    path = "/home/aleidk/.local/share/nvim/site/pack/packer/start/moonlight.nvim"
  },
  neogit = {
    commands = { "Neogit" },
    loaded = false,
    needs_bufread = true,
    path = "/home/aleidk/.local/share/nvim/site/pack/packer/opt/neogit"
  },
  neon = {
    loaded = true,
    path = "/home/aleidk/.local/share/nvim/site/pack/packer/start/neon"
  },
  ["numb.nvim"] = {
    config = { "\27LJ\1\0022\0\0\2\0\3\0\0064\0\0\0%\1\1\0>\0\2\0027\0\2\0>\0\1\1G\0\1\0\nsetup\tnumb\frequire\0" },
    loaded = true,
    path = "/home/aleidk/.local/share/nvim/site/pack/packer/start/numb.nvim"
  },
  ["nvim-autopairs"] = {
    loaded = true,
    path = "/home/aleidk/.local/share/nvim/site/pack/packer/start/nvim-autopairs"
  },
  ["nvim-base16"] = {
    loaded = true,
    path = "/home/aleidk/.local/share/nvim/site/pack/packer/start/nvim-base16"
  },
  ["nvim-colorizer.lua"] = {
    config = { "\27LJ\1\2]\0\0\2\0\6\0\n4\0\0\0007\0\1\0)\1\2\0:\1\2\0004\0\3\0%\1\4\0>\0\2\0027\0\5\0>\0\1\1G\0\1\0\nsetup\14colorizer\frequire\18termguicolors\bopt\bvim\0" },
    loaded = true,
    path = "/home/aleidk/.local/share/nvim/site/pack/packer/start/nvim-colorizer.lua"
  },
  ["nvim-comment-frame"] = {
    loaded = true,
    path = "/home/aleidk/.local/share/nvim/site/pack/packer/start/nvim-comment-frame"
  },
  ["nvim-compe"] = {
    loaded = true,
    path = "/home/aleidk/.local/share/nvim/site/pack/packer/start/nvim-compe"
  },
  ["nvim-cursorword"] = {
    loaded = true,
    path = "/home/aleidk/.local/share/nvim/site/pack/packer/start/nvim-cursorword"
  },
  ["nvim-lightbulb"] = {
    loaded = true,
    path = "/home/aleidk/.local/share/nvim/site/pack/packer/start/nvim-lightbulb"
  },
  ["nvim-lspconfig"] = {
    loaded = true,
    path = "/home/aleidk/.local/share/nvim/site/pack/packer/start/nvim-lspconfig"
  },
  ["nvim-lspinstall"] = {
    loaded = true,
    path = "/home/aleidk/.local/share/nvim/site/pack/packer/start/nvim-lspinstall"
  },
  ["nvim-mapper"] = {
    loaded = true,
    path = "/home/aleidk/.local/share/nvim/site/pack/packer/start/nvim-mapper"
  },
  ["nvim-toggleterm.lua"] = {
    loaded = true,
    path = "/home/aleidk/.local/share/nvim/site/pack/packer/start/nvim-toggleterm.lua"
  },
  ["nvim-tree.lua"] = {
    loaded = true,
    path = "/home/aleidk/.local/share/nvim/site/pack/packer/start/nvim-tree.lua"
  },
  ["nvim-treesitter"] = {
    loaded = true,
    path = "/home/aleidk/.local/share/nvim/site/pack/packer/start/nvim-treesitter"
  },
  ["nvim-treesitter-context"] = {
    loaded = true,
    path = "/home/aleidk/.local/share/nvim/site/pack/packer/start/nvim-treesitter-context"
  },
  ["nvim-ts-autotag"] = {
    config = { "\27LJ\1\2g\0\0\3\0\6\0\t4\0\0\0%\1\1\0>\0\2\0027\0\2\0003\1\4\0003\2\3\0:\2\5\1>\0\2\1G\0\1\0\fautotag\1\0\0\1\0\1\venable\2\nsetup\28nvim-treesitter.configs\frequire\0" },
    loaded = false,
    needs_bufread = false,
    path = "/home/aleidk/.local/share/nvim/site/pack/packer/opt/nvim-ts-autotag"
  },
  ["nvim-ts-rainbow"] = {
    loaded = true,
    path = "/home/aleidk/.local/share/nvim/site/pack/packer/start/nvim-ts-rainbow"
  },
  ["nvim-web-devicons"] = {
    loaded = true,
    path = "/home/aleidk/.local/share/nvim/site/pack/packer/start/nvim-web-devicons"
  },
  nvim_context_vt = {
    loaded = true,
    path = "/home/aleidk/.local/share/nvim/site/pack/packer/start/nvim_context_vt"
  },
  ["omni.vim"] = {
    loaded = true,
    path = "/home/aleidk/.local/share/nvim/site/pack/packer/start/omni.vim"
  },
  ["onedark.nvim"] = {
    loaded = true,
    path = "/home/aleidk/.local/share/nvim/site/pack/packer/start/onedark.nvim"
  },
  ["packer.nvim"] = {
    loaded = true,
    path = "/home/aleidk/.local/share/nvim/site/pack/packer/start/packer.nvim"
  },
  playground = {
    loaded = true,
    path = "/home/aleidk/.local/share/nvim/site/pack/packer/start/playground"
  },
  ["plenary.nvim"] = {
    loaded = true,
    path = "/home/aleidk/.local/share/nvim/site/pack/packer/start/plenary.nvim"
  },
  ["popup.nvim"] = {
    loaded = true,
    path = "/home/aleidk/.local/share/nvim/site/pack/packer/start/popup.nvim"
  },
  ["project.nvim"] = {
    config = { ' require("plugins.projects") ' },
    loaded = true,
    path = "/home/aleidk/.local/share/nvim/site/pack/packer/start/project.nvim"
  },
  ["rest.nvim"] = {
    config = { "\27LJ\1\2,\0\0\2\0\2\0\0044\0\0\0%\1\1\0>\0\2\1G\0\1\0\17plugins.rest\frequire\0" },
    loaded = true,
    path = "/home/aleidk/.local/share/nvim/site/pack/packer/start/rest.nvim"
  },
  ["suda.vim"] = {
    loaded = true,
    path = "/home/aleidk/.local/share/nvim/site/pack/packer/start/suda.vim"
  },
  ["surround.nvim"] = {
    config = { "\27LJ\1\2U\0\0\2\0\4\0\a4\0\0\0%\1\1\0>\0\2\0027\0\2\0003\1\3\0>\0\2\1G\0\1\0\1\0\1\19mappings_style\rsandwich\nsetup\rsurround\frequire\0" },
    loaded = true,
    path = "/home/aleidk/.local/share/nvim/site/pack/packer/start/surround.nvim"
  },
  ["telescope-media-files.nvim"] = {
    loaded = true,
    path = "/home/aleidk/.local/share/nvim/site/pack/packer/start/telescope-media-files.nvim"
  },
  ["telescope.nvim"] = {
    config = { 'require("plugins.telescope") ' },
    loaded = true,
    path = "/home/aleidk/.local/share/nvim/site/pack/packer/start/telescope.nvim"
  },
  ["tokyodark.nvim"] = {
    loaded = true,
    path = "/home/aleidk/.local/share/nvim/site/pack/packer/start/tokyodark.nvim"
  },
  ["tokyonight.nvim"] = {
    loaded = true,
    path = "/home/aleidk/.local/share/nvim/site/pack/packer/start/tokyonight.nvim"
  },
  ["twilight.nvim"] = {
    loaded = true,
    path = "/home/aleidk/.local/share/nvim/site/pack/packer/start/twilight.nvim"
  },
  ultisnips = {
    loaded = true,
    path = "/home/aleidk/.local/share/nvim/site/pack/packer/start/ultisnips"
  },
  ["vim-easy-align"] = {
    loaded = true,
    path = "/home/aleidk/.local/share/nvim/site/pack/packer/start/vim-easy-align"
  },
  ["vim-snippets"] = {
    loaded = true,
    path = "/home/aleidk/.local/share/nvim/site/pack/packer/start/vim-snippets"
  },
  ["vim-transparent"] = {
    loaded = true,
    path = "/home/aleidk/.local/share/nvim/site/pack/packer/start/vim-transparent"
  },
  ["vim-wordmotion"] = {
    loaded = true,
    path = "/home/aleidk/.local/share/nvim/site/pack/packer/start/vim-wordmotion"
  },
  ["which-key.nvim"] = {
    loaded = true,
    path = "/home/aleidk/.local/share/nvim/site/pack/packer/start/which-key.nvim"
  },
  ["xresources-nvim"] = {
    loaded = true,
    path = "/home/aleidk/.local/share/nvim/site/pack/packer/start/xresources-nvim"
  },
  ["zen-mode.nvim"] = {
    loaded = true,
    path = "/home/aleidk/.local/share/nvim/site/pack/packer/start/zen-mode.nvim"
  }
}

time([[Defining packer_plugins]], false)
-- Config for: surround.nvim
time([[Config for surround.nvim]], true)
try_loadstring("\27LJ\1\2U\0\0\2\0\4\0\a4\0\0\0%\1\1\0>\0\2\0027\0\2\0003\1\3\0>\0\2\1G\0\1\0\1\0\1\19mappings_style\rsandwich\nsetup\rsurround\frequire\0", "config", "surround.nvim")
time([[Config for surround.nvim]], false)
-- Config for: telescope.nvim
time([[Config for telescope.nvim]], true)
require("plugins.telescope") 
time([[Config for telescope.nvim]], false)
-- Config for: focus.nvim
time([[Config for focus.nvim]], true)
try_loadstring("\27LJ\1\2-\0\0\2\0\2\0\0044\0\0\0%\1\1\0>\0\2\1G\0\1\0\18plugins.focus\frequire\0", "config", "focus.nvim")
time([[Config for focus.nvim]], false)
-- Config for: rest.nvim
time([[Config for rest.nvim]], true)
try_loadstring("\27LJ\1\2,\0\0\2\0\2\0\0044\0\0\0%\1\1\0>\0\2\1G\0\1\0\17plugins.rest\frequire\0", "config", "rest.nvim")
time([[Config for rest.nvim]], false)
-- Config for: numb.nvim
time([[Config for numb.nvim]], true)
try_loadstring("\27LJ\1\0022\0\0\2\0\3\0\0064\0\0\0%\1\1\0>\0\2\0027\0\2\0>\0\1\1G\0\1\0\nsetup\tnumb\frequire\0", "config", "numb.nvim")
time([[Config for numb.nvim]], false)
-- Config for: gitsigns.nvim
time([[Config for gitsigns.nvim]], true)
require("plugins.gitsigns")
time([[Config for gitsigns.nvim]], false)
-- Config for: lspsaga.nvim
time([[Config for lspsaga.nvim]], true)
try_loadstring("\27LJ\1\2/\0\0\2\0\2\0\0044\0\0\0%\1\1\0>\0\2\1G\0\1\0\20plugins.lspsaga\frequire\0", "config", "lspsaga.nvim")
time([[Config for lspsaga.nvim]], false)
-- Config for: nvim-colorizer.lua
time([[Config for nvim-colorizer.lua]], true)
try_loadstring("\27LJ\1\2]\0\0\2\0\6\0\n4\0\0\0007\0\1\0)\1\2\0:\1\2\0004\0\3\0%\1\4\0>\0\2\0027\0\5\0>\0\1\1G\0\1\0\nsetup\14colorizer\frequire\18termguicolors\bopt\bvim\0", "config", "nvim-colorizer.lua")
time([[Config for nvim-colorizer.lua]], false)
-- Config for: project.nvim
time([[Config for project.nvim]], true)
 require("plugins.projects") 
time([[Config for project.nvim]], false)
-- Conditional loads
time("Condition for { 'dashboard-nvim' }", true)
if
try_loadstring("\27LJ\1\2I\0\0\2\0\4\0\f4\0\0\0007\0\1\0%\1\2\0>\0\2\2\a\0\3\0T\0\4€)\0\1\0T\1\3€)\0\1\0T\1\1€)\0\2\0H\0\2\0\ano\tPLUG\vgetenv\aos\0", "condition", '{ "dashboard-nvim" }')
then
time("Condition for { 'dashboard-nvim' }", false)
time([[packadd for dashboard-nvim]], true)
		vim.cmd [[packadd dashboard-nvim]]
	time([[packadd for dashboard-nvim]], false)
else
time("Condition for { 'dashboard-nvim' }", false)
end

-- Command lazy-loads
time([[Defining lazy-load commands]], true)
pcall(vim.cmd, [[command -nargs=* -range -bang -complete=file Neogit lua require("packer.load")({'neogit'}, { cmd = "Neogit", l1 = <line1>, l2 = <line2>, bang = <q-bang>, args = <q-args> }, _G.packer_plugins)]])
time([[Defining lazy-load commands]], false)

vim.cmd [[augroup packer_load_aucmds]]
vim.cmd [[au!]]
  -- Filetype lazy-loads
time([[Defining lazy-load filetype autocommands]], true)
vim.cmd [[au FileType javascript ++once lua require("packer.load")({'nvim-ts-autotag'}, { ft = "javascript" }, _G.packer_plugins)]]
vim.cmd [[au FileType typescript ++once lua require("packer.load")({'nvim-ts-autotag'}, { ft = "typescript" }, _G.packer_plugins)]]
vim.cmd [[au FileType html ++once lua require("packer.load")({'nvim-ts-autotag'}, { ft = "html" }, _G.packer_plugins)]]
time([[Defining lazy-load filetype autocommands]], false)
vim.cmd("augroup END")
if should_profile then save_profiles() end

end)

if not no_errors then
  vim.api.nvim_command('echohl ErrorMsg | echom "Error in packer_compiled: '..error_msg..'" | echom "Please check your config for correctness" | echohl None')
end
