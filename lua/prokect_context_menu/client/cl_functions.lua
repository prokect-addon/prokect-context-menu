ProkectContext.Fonts = {}

RX = RX or function(x) return x / 1920 * ScrW() end
RY = RY or function(y) return y / 1080 * ScrH() end

function ProkectContext:Font(iSize, iWidth)
	iSize = iSize or 15
	iWidth = iWidth or 500
	local sName = ("ProkectContext:Font:%i:%i"):format(iSize, iWidth)
	if not ProkectContext.Fonts[sName] then
		surface.CreateFont(sName, {
			font = ProkectContext.Config.Font,
			size = RX(iSize),
			width = iWidth,
			extended = false
		})
		ProkectContext.Fonts[sName] = true
	end
	return sName
end

local cacheDownload = {}
function ProkectContext.DownloadImgur(url)
    ProkectContext.CacheImgur = ProkectContext.CacheImgur or {}
    if ProkectContext.CacheImgur[url] then return end
    if cacheDownload[url] then return end
    cacheDownload[url] = true
    http.Fetch('https://i.imgur.com/' .. url, function(body)
        file.CreateDir('prokect_addon/context_menu/')
        file.Write('prokect_addon/context_menu/' .. url, body)
        ProkectContext.CacheImgur[url] = Material('data/prokect_addon/context_menu/' .. url)
        print("[ProkectContext] Downloaded image: " .. url)
    end, function(error)
        print("[ProkectContext] Error downloading image: " .. url)
        print("[ProkectContext] Error: " .. error)
    end)
end

function ProkectContext.PrepareDownloadImgur()
    if type(ProkectContext.Config.ImgurImg) == 'string' then
        ProkectContext.DownloadImgur(ProkectContext.Config.ImgurImg)
    end    
end

function ProkectContext:CreateFrameDrop(name, description, desc2, example, btnText, func)
    if IsValid(frameDrop) then frameDrop:Remove() end

    frameDrop = vgui.Create("DFrame")
    frameDrop:SetSize(RX(553), RY(198))
    frameDrop:Center()
    frameDrop:MakePopup()
    frameDrop:SetTitle("")
    frameDrop:ShowCloseButton(false)
    frameDrop:SetDraggable(false)
    frameDrop.Paint = function(self, w, h)
        draw.RoundedBox(RX(0), RX(0), RY(0), w, h, ProkectContext.Config.Color["Border"])
        draw.RoundedBox(RX(0), RX(3), RY(3), RX(547), RY(192), ProkectContext.Config.Color["Background"])
        draw.RoundedBox(RX(0), RX(3), RY(30), RX(547), RY(2), ProkectContext.Config.Color["Border"])
        draw.SimpleText(name, ProkectContext:Font(21), w / 2, RY(5), ProkectContext.Config.Color["Text"], TEXT_ALIGN_CENTER)
        draw.SimpleText(description, ProkectContext:Font(18), w / 2, RY(52), ProkectContext.Config.Color["Text"], TEXT_ALIGN_CENTER)
        draw.SimpleText(desc2, ProkectContext:Font(18), w / 2, RY(99), ProkectContext.Config.Color["Text"], TEXT_ALIGN_CENTER)
    end

    local textentry = vgui.Create("DTextEntry", frameDrop)
    textentry:SetSize(RX(397), RY(26))
    textentry:SetPos(RX(78), RY(119))
    textentry:SetTextColor(ProkectContext.Config.Color["Text"])
    textentry:SetFont(ProkectContext:Font(15))
    textentry:SetValue(example)
    textentry:SetDrawLanguageID(false)
    textentry.Paint = function(self, w, h)
        draw.RoundedBox(RX(0), RX(0), RY(0), w, h, ProkectContext.Config.Color["Border"])
        draw.RoundedBox(RX(0), RX(2), RY(2), RX(393), RY(22), ProkectContext.Config.Color["Background"])
    
        self:DrawTextEntryText(ProkectContext.Config.Color["Text"], ProkectContext.Config.Color["Text"], ProkectContext.Config.Color["Text"])
    end
    textentry.OnEnter = function(self)
        func(self)
        frameDrop:Remove()
    end

    local dropbtn = vgui.Create("DButton", frameDrop)
    dropbtn:SetSize(RX(211), RY(33))
    dropbtn:SetPos(RX(171), RY(153))
    dropbtn:SetText(btnText)
    dropbtn:SetTextColor(ProkectContext.Config.Color["Text"])
    dropbtn:SetFont(ProkectContext:Font(15))
    dropbtn.Paint = function(self, w, h)
        draw.RoundedBox(RX(5), RX(0), RY(0), w, h, ProkectContext.Config.Color["BtnBorder"])
        draw.RoundedBox(RX(5), RX(1), RY(1), RX(209), RY(31), ProkectContext.Config.Color["BtnBackground"])
    end
    dropbtn.DoClick = function()
        func(textentry)
        frameDrop:Remove()
    end

    local quitbtn = vgui.Create("DButton", frameDrop)
    quitbtn:SetSize(RX(11), RY(19))
    quitbtn:SetPos(RX(530), RY(6))
    quitbtn:SetText("X")
    quitbtn:SetTextColor(ProkectContext.Config.Color["Text"])
    quitbtn:SetFont(ProkectContext:Font(23))
    quitbtn.Paint = nil
    quitbtn.DoClick = function()
        frameDrop:Remove()
    end
end

function ProkectContext:Open()
    if IsValid(frame) then frame:Remove() end
    frame = vgui.Create("DFrame")
    frame:SetSize(RX(498), RY(1080))
    frame:SetPos(RX(1422), RY(0))
    frame:MakePopup()
    frame:SetTitle("")
    frame:ShowCloseButton(false)
    frame:SetDraggable(false)
    frame.Paint = function(self, w, h)
        draw.RoundedBox(RX(0), RX(0), RY(0), w, h, ProkectContext.Config.Color["Border"])
        draw.RoundedBox(RX(0), RX(3), RY(3), RX(492), RY(1074), ProkectContext.Config.Color["Background"])

        local bmat

        if ProkectContext.Config.UseImgur then
            local imgurImg = ProkectContext.Config.ImgurImg
            if ProkectContext.CacheImgur[imgurImg] then
                bmat = ProkectContext.CacheImgur[imgurImg]
            else
                bmat = Material(ProkectContext.Config.LogoImage)
            end            
        else
            bmat = Material(ProkectContext.Config.LogoImage)
        end

        surface.SetDrawColor(color_white)
        surface.SetMaterial(bmat)
        surface.DrawTexturedRect(RX(121), RY(40), RX(256), RY(256))
    end

    local scroll = vgui.Create("DScrollPanel", frame)
    scroll:SetSize(RX(409), RY(727))
    scroll:SetPos(RX(57), RY(310))

    local vbar = scroll:GetVBar()
    vbar:SetHideButtons(true)
    vbar:SetWide(8)
    vbar.Paint = function(self, w, h)
        draw.RoundedBox(RX(5), RX(0), RY(0), w, h, ProkectContext.Config.Color["BtnBorder"])
    end
    function vbar.btnGrip:Paint(w, h)
        draw.RoundedBox(RX(5), RX(1), RY(0), RX(6), h, ProkectContext.Config.Color["BtnBackground"])
    end

    local ypos = RY(0)
    for k, v in pairs(ProkectContext.Config.Buttons) do
        local btn = vgui.Create("DButton", scroll)
        btn:SetSize(RX(378), RY(63))
        btn:SetPos(RX(0), ypos)
        btn:SetText(v.Name)
        btn:SetFont(ProkectContext:Font(15))
        btn:SetTextColor(color_white)
        btn.Paint = function(self, w, h)
            draw.RoundedBox(RX(5), RX(0), RY(0), w, h, ProkectContext.Config.Color["BtnBorder"])
            draw.RoundedBox(RX(5), RX(2), RY(2), RX(374), RY(59), ProkectContext.Config.Color["BtnBackground"])
        end
        btn.DoClick = function()
            v.Function()
        end

        ypos = ypos + RY(83)
    end
end

function ProkectContext:Close()
    if IsValid(frame) then
        frame:Remove()
    end
end