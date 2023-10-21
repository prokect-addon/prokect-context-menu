-- Called when the server ask for an update
net.Receive("ProkectContext:UpdateCache", function()

	ProkectContext.Cache = net.ReadTable()
	print("[ProkectContext] Client cache updated!")

end)