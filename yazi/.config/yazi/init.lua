function Linemode:custom()
  local spans = { ui.Span(" ") }
  if self._file.cha.is_link then
    spans[#spans + 1] = ui.Span("-> ")
  elseif self._file.cha.is_orphan then
    spans[#spans + 1] = ui.Span("-x ")
  end
  if self._file.cha.is_dir then
    -- local test = self._file.cha.length
    spans[#spans + 1] = ui.Span("")
  else
    local size = self._file:size()
    spans[#spans + 1] = ui.Span(size and ya.readable_size(size):gsub(" ", "") or "")
  end
  return ui.Line(spans)
end

-- show user@hostname in header
Header:children_add(function()
  return ui.Line(string.format("%s@%s ", ya.user_name(), ya.host_name()))
end, 0, Header.LEFT)

-- increase the width of `size` to prevent wobbling
function Status:size()
  local h = self._tab.current.hovered
  if not h then
    return ui.Line({})
  end

  local style = self:style()
  local file_size = string.format(" %8s ", ya.readable_size(h:size() or h.cha.length))
  return ui.Line({
    ui.Span(file_size):fg(style.bg):bg(THEME.status.separator_style.bg),
    ui.Span(THEME.status.separator_close):fg(THEME.status.separator_style.fg),
  })
end

-- show symlink in status bar
function Status:name()
  local h = cx.active.current.hovered
  if h == nil then
    return ui.Span("")
  end

  local linked = ""
  if h.link_to then
    linked = " -> " .. tostring(h.link_to)
  end
  return ui.Span(" " .. h.name .. linked)
end

-- modified time
Status:children_add(function(self)
  local h = self._tab.current.hovered
  local time = (h.cha.modified or 0) // 1
	if time == 0 then
		return ui.Line("")
	elseif os.date("%Y", time) == os.date("%Y") then
		return ui.Line(os.date("%m/%d %H:%M", time))
	else
		return ui.Line(os.date("%Y/%m/%d %H:%M", time))
	end
end, 0, Status.RIGHT)

-- show user group next to permissions
Status:children_add(function(self)
  local h = self._tab.current.hovered
  local user = h.cha.uid and ya.user_name(h.cha.uid) or h.cha.uid
  local group = h and h.cha.gid and ya.user_name(h.cha.gid) or h.cha.gid
  return ui.Line({
    ui.Span(string.format(" %s", user)):fg("yellow"),
    ui.Span(":"),
    ui.Span(string.format("%s ", group)):fg("yellow"),
  })
end, 1, Status.RIGHT)

-- remove percentage
Status:children_remove(5, Status.RIGHT)
