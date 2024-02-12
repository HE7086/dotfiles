-- show number of children for folders and size for files
function Folder:linemode(area)
	local lines = {}
	for _, f in ipairs(self:by_kind(self.CURRENT).window) do
		local spans = { ui.Span(" ") }

        -- if f.cha.is_dir then
        --     spans[#spans + 1] = ui.Span(f:size() or "")
        --     -- TODO: number of child files
        -- else
            local size = f:size()
            if f.cha.is_link then
                spans[#spans + 1] = ui.Span("-> ")
            elseif f.cha.is_orphan then
                spans[#spans + 1] = ui.Span("-x ")
            end
            spans[#spans + 1] = ui.Span(size and ya.readable_size(size) or "")
            spans[#spans + 1] = ui.Span(" ")
        -- end

		lines[#lines + 1] = ui.Line(spans)
	end
	return ui.Paragraph(area, lines):align(ui.Paragraph.RIGHT)
end

-- increase the width of `size` to prevent wobbling
function Status:size()
	local h = cx.active.current.hovered
	if h == nil then
		return ui.Line {}
	end

	local style = self.style()
    local file_size = string.format("%8s ", ya.readable_size(h:size() or h.cha.length))
	return ui.Line {
		ui.Span(file_size):fg(style.bg):bg(THEME.status.separator_style.bg),
		ui.Span(THEME.status.separator_close):fg(THEME.status.separator_style.fg),
	}
end

-- show symlink in status bar
function Status:name()
	local h = cx.active.current.hovered
	if h == nil then
		return ui.Span("")
	end

 	local linked = ""
 	if h.link_to ~= nil then
 		linked = " -> " .. tostring(h.link_to)
 	end
 	return ui.Span(" " .. h.name .. linked)
end
