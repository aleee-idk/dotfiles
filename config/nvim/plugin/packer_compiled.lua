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
  ["aw-watcher-vim"] = {
    loaded = true,
    path = "/home/aleidk/.local/share/nvim/site/pack/packer/start/aw-watcher-vim"
  },
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
  ["formatter.nvim"] = {
    loaded = true,
    path = "/home/aleidk/.local/share/nvim/site/pack/packer/start/formatter.nvim"
  },
  ["fzf-gitignore"] = {
    loaded = true,
    path = "/home/aleidk/.local/share/nvim/site/pack/packer/start/fzf-gitignore"
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
  ["lualine.nvim"] = {
    loaded = true,
    path = "/home/aleidk/.local/share/nvim/site/pack/packer/start/lualine.nvim"
  },
  ["markdown-preview.nvim"] = {
    loaded = true,
    path = "/home/aleidk/.local/share/nvim/site/pack/packer/start/markdown-preview.nvim"
  },
  ["moonlight.nvim"] = {
    loaded = true,
    path = "/home/aleidk/.local/share/nvim/site/pack/packer/start/moonlight.nvim"
  },
  neon = {
    loaded = true,
    path = "/home/aleidk/.local/share/nvim/site/pack/packer/start/neon"
  },
  ["numb.nvim"] = {
    loaded = true,
    path = "/home/aleidk/.local/share/nvim/site/pack/packer/start/numb.nvim"
  },
  ["nvim-colorizer.lua"] = {
    loaded = true,
    path = "/home/aleidk/.local/share/nvim/site/pack/packer/start/nvim-colorizer.lua"
  },
  ["nvim-compe"] = {
    loaded = true,
    path = "/home/aleidk/.local/share/nvim/site/pack/packer/start/nvim-compe"
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
  ["nvim-ts-rainbow"] = {
    loaded = true,
    path = "/home/aleidk/.local/share/nvim/site/pack/packer/start/nvim-ts-rainbow"
  },
  ["nvim-web-devicons"] = {
    loaded = true,
    path = "/home/aleidk/.local/share/nvim/site/pack/packer/start/nvim-web-devicons"
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
  ["suda.vim"] = {
    loaded = true,
    path = "/home/aleidk/.local/share/nvim/site/pack/packer/start/suda.vim"
  },
  ["surround.nvim"] = {
    loaded = true,
    path = "/home/aleidk/.local/share/nvim/site/pack/packer/start/surround.nvim"
  },
  ["telescope-media-files.nvim"] = {
    loaded = true,
    path = "/home/aleidk/.local/share/nvim/site/pack/packer/start/telescope-media-files.nvim"
  },
  ["telescope-project.nvim"] = {
    loaded = true,
    path = "/home/aleidk/.local/share/nvim/site/pack/packer/start/telescope-project.nvim"
  },
  ["telescope.nvim"] = {
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
  winresizer = {
    loaded = true,
    path = "/home/aleidk/.local/share/nvim/site/pack/packer/start/winresizer"
  },
  ["xresources-nvim"] = {
    loaded = true,
    path = "/home/aleidk/.local/share/nvim/site/pack/packer/start/xresources-nvim"
  }
}

time([[Defining packer_plugins]], false)
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
if should_profile then save_profiles() end

end)

if not no_errors then
  vim.api.nvim_command('echohl ErrorMsg | echom "Error in packer_compiled: '..error_msg..'" | echom "Please check your config for correctness" | echohl None')
end
