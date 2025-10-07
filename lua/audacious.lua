-- A simple Neovim plugin to control the Audacious music player.
--
local M = {}

local function run_audtool(args)
	-- Build the full command by concatenating "audtool" with the argument.
	local cmd = "audtool " .. args

	-- vim.fn.system() executes a shell command and returns the output.
	local output = vim.fn.system(cmd)

	-- If anything other than a success occurs:
	if vim.v.shell_error ~= 0 then
		-- vim.notify shows a message to the user.
		vim.notify("Audtool failed: " .. cmd, vim.log.levels.ERROR)

		return nil
	end

	-- This removes trailing whitespaces/newlines from the output.
	return vim.trim(output)
end

-- Now to make the public functions. 
--
function M.play_pause()
	run_audtool("playback-playpause")
	-- After toggling, show the user what is happening.
	local status = run_audtool("playback-status")
	if status then 
		vim.notify("Audacious: " .. status, vim.log.levels.INFO)
	end 
end 

-- Public function: Stop playback
function M.stop()
  run_audtool("playback-stop")
  vim.notify("Audacious: Stopped", vim.log.levels.INFO)
end

-- Public function: Go to next track
function M.next()
  run_audtool("playlist-advance")
  -- Small delay to let Audacious update, then show the new song
  -- vim.defer_fn() runs a function after a delay (in milliseconds)
  vim.defer_fn(function()
    M.current_song()
  end, 100)
end

-- Public function: Go to previous track
function M.previous()
  run_audtool("playlist-reverse")
  vim.defer_fn(function()
    M.current_song()
  end, 100)
end

-- Public function: Display current song information
function M.current_song()
  local title = run_audtool("current-song")
  local length = run_audtool("current-song-length")
  local position = run_audtool("current-song-output-length")
  
  if title then
    local info = string.format("%s [%s / %s]", title, position or "?", length or "?")
    vim.notify(info, vim.log.levels.INFO)
  end
end

-- Setup function - this is a common pattern in Neovim plugins
-- It allows users to initialize the plugin and pass configuration options
function M.setup(opts)
  -- opts would contain user configuration, we'll use it later
  opts = opts or {} -- If no opts provided, use an empty table
  
  -- Create user commands
  -- vim.api.nvim_create_user_command() creates a new ex command (like :PluginName)
  -- Arguments: command_name, function_to_call, options_table
  vim.api.nvim_create_user_command("AudaciousPlayPause", M.play_pause, {})
  vim.api.nvim_create_user_command("AudaciousStop", M.stop, {})
  vim.api.nvim_create_user_command("AudaciousNext", M.next, {})
  vim.api.nvim_create_user_command("AudaciousPrevious", M.previous, {})
  vim.api.nvim_create_user_command("AudaciousCurrent", M.current_song, {})
  
  vim.notify("Audacious plugin loaded!", vim.log.levels.INFO)
end

-- Return the module table so other code can use it
return M
