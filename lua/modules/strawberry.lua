local M = {}

local function exec(cmd)
  local handle = io.popen(cmd)
  local result = handle:read("*a")
  handle:close()
  return result
end

local function is_strawberry_running()
	result = exec("pgrep -x strawberry")
	return result ~= ""  -- returns true if strawberry is running
end 

function M.play_pause()
	if is_strawberry_running() then
		exec("strawberry -t")
	else 
		vim.notify("Strawberry isn't running. Start it outside of Neovim.", vim.log.levels.WARN)
	end
end

function M.next()
	if is_strawberry_running() then
		exec("strawberry -f")
	else 
		vim.notify("Strawberry isn't running. Start it outside of Neovim.", vim.log.levels.WARN)
	end
end

function M.prev()
	if is_strawberry_running() then
		exec("strawberry -r")
	else 
		vim.notify("Strawberry isn't running. Start it outside of Neovim.", vim.log.levels.WARN)
	end
end

local function get_metadata()
  local cmd = [[
  dbus-send --print-reply --dest=org.mpris.MediaPlayer2.strawberry \
  /org/mpris/MediaPlayer2 org.freedesktop.DBus.Properties.Get \
  string:'org.mpris.MediaPlayer2.Player' string:'Metadata'
  ]]

  local result = exec(cmd)

  local title = result:match('string "xesam:title"%s+variant%s+string "([^"]+)"')
  local artist = result:match('string "xesam:artist"%s+variant%s+array %[%s+string "([^"]+)"')
  local album = result:match('string "xesam:album"%s+variant%s+string "([^"]+)"')
  local url = result:match('string "file://([^"]+%.mp3)"')

  return {
    title = title or "Unknown Title",
    artist = artist or "Unknown Artist",
    album = album or "Unknown Album",
    url = url
  }
end

local function get_playlist()
  local sqlite_path = os.getenv("HOME") .. "/.local/share/strawberry/strawberry/strawberry.db"
  local query = [[SELECT s.title FROM playlist_items AS p JOIN songs AS s ON p.collection_id = s.rowid WHERE p.playlist = 1;]]
  local cmd = string.format([[sqlite3 "%s" "%s"]], sqlite_path, query)

  local handle = io.popen(cmd .. " 2>&1")
  local result = handle:read("*a")
  handle:close()

  local playlist = {}
  for title in result:gmatch("[^\r\n]+") do
    table.insert(playlist, { title = title })
  end
  return playlist
end

local function truncate(text, max_len)
  if #text > max_len then
    return text:sub(1, max_len - 1) .. "…"
  end
  return text
end

function M.show_status()

	if not is_strawberry_running() then 
		vim.notify("Strawberry isn't running. Start it outside of Neovim.", vim.log.levels.WARN)
	end


  local meta = get_metadata()
  local playlist = get_playlist()
  local playlist_lines = {}
  
  table.insert(playlist_lines, "Playlist:")

  local max_width = 35
  for i, track in ipairs(playlist) do
    local marker = (track.title == meta.title) and "> " or "  "
    local title = truncate(track.title, max_width)
    table.insert(playlist_lines, string.format("%s%02d. %s", marker, i, title))
  end

  local info_lines = {
    "Now Playing:",
    "  Track:  " .. meta.title,
    "  Artist: " .. meta.artist,
    "  Album:  " .. meta.album,
  }

  local max_info_width = 40
  local height = math.max(#info_lines, #playlist_lines) + 2
  local width = max_info_width + max_width + 10

  local buf = vim.api.nvim_create_buf(false, true)
  vim.api.nvim_buf_set_option(buf, "modifiable", true)
  vim.api.nvim_buf_set_option(buf, "buftype", "nofile")
  vim.api.nvim_buf_set_option(buf, "filetype", "strawberry_status")
  vim.api.nvim_buf_set_option(buf, "bufhidden", "wipe")
  vim.api.nvim_buf_set_option(buf, "swapfile", false)
  vim.api.nvim_buf_set_option(buf, "foldmethod", "manual")

  local combined_lines = {}
  for i = 1, height - 2 do
    local left = info_lines[i] or ""
    local right = playlist_lines[i] or ""
    table.insert(combined_lines, string.format("%-" .. max_info_width .. "s │ %s", left, right))
  end

  vim.api.nvim_buf_set_lines(buf, 0, -1, false, combined_lines)

  vim.api.nvim_open_win(buf, true, {
    relative = "editor",
    width = width,
    height = height,
    col = (vim.o.columns - width) / 2,
    row = (vim.o.lines - height) / 2,
    style = "minimal",
    border = "rounded",
  })

  vim.api.nvim_buf_set_keymap(buf, "n", "q", ":bd!<CR>", { noremap = true, silent = true })
end

return M

