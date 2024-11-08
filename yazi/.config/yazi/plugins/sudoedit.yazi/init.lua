--- @sync entry
return {
	entry = function(_, _)
		local h = cx.active.current.hovered
		if h and h.cha.is_dir then
			ya.manager_emit("enter", {})
		else 
			ya.manager_emit("shell", {
				'sudoedit "$@"',
				block = true,
				confirm = true,
			})
		end
	end
}
