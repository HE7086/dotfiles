return {
	entry = function(_, _)
		ya.manager_emit("shell", {
			'sudoedit "$@"',
			block = true,
			confirm = true,
		})
	end
}
