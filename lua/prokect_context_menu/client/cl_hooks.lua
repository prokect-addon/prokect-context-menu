hook.Add("InitPostEntity", "ProkectContext::DownloadImgur", function()
    ProkectContext.PrepareDownloadImgur()
end)

hook.Add("OnContextMenuOpen", "ProkectContext::Open", function()
	ProkectContext:Open()
	if not ProkectContext.Config.AdminRanks[LocalPlayer():GetUserGroup()] then
		return false
	end
end)

hook.Add("OnContextMenuClose", "ProkectContext::Close", function()
	ProkectContext:Close()
end)

hook.Add("PopulateMenuBar", "IncanCMenuRemoveMenuBar", function(menubar)
	menubar.Paint = nil
end)