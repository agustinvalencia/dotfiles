local M = {}
function M.basename(path)
	return path and path:gsub("(.*[/\\])(.*)", "%2") or ""
end
return M
