ProkectContext.Config = {}

ProkectContext.Config.AdminRanks = { -- Ceux qui ont accès en haut à gauche
    ["superadmin"] = true,
    ["admin"] = true 
}

ProkectContext.Config.Font = "Roboto" -- Votre police de caractères que vous souhaitez utiliser, celle de base de Gmod est "Roboto, Arial"

ProkectContext.Config.UseImgur = true -- Si vous utilisez Imgur, mettez "true", sinon "false" pour utiliser le logo de votre contenu

ProkectContext.Config.ImgurImg = "k908jOO.png" -- Mettez l'ID de l'image Imgur, par exemple "k908jOO.png"

ProkectContext.Config.LogoImage = "" -- Chemin de votre image de contenu sur le workshop, par exemple "mon_context/img.png"

ProkectContext.Config.Color = {
    ["Text"] = Color(255, 255, 255), -- Couleur du texte
    ["Background"] = Color(30, 30, 30), -- Couleur de fond
    ["Border"] = Color(19, 19, 19), -- Couleur de bordure
    ["BtnBackground"] = Color(34, 91, 149), -- Couleur de fond du bouton
    ["BtnBorder"] = Color(0, 78, 150), -- Couleur de bordure du bouton
}

ProkectContext.Config.Buttons = {
    {
        ["Name"] = "Boutique", -- Nom du bouton
        ["Function"] = function() -- Fonction
            gui.OpenURL("https://prokect.fr/")
        end
    },
    {
        ["Name"] = "Workshop",
        ["Function"] = function()
            gui.OpenURL("https://steamcommunity.com/")
        end
    },
    {
        ["Name"] = "Discord",
        ["Function"] = function()
            gui.OpenURL("https://discord.gg/")
        end
    },
	{
		["Name"] = "Appeler un staff",
		["Function"] = function()
			ProkectContext:CreateFrameDrop("Appeler un staff", "Vous voulez un appeler un staff ?", "Veuillez saisir la raison du ticket !", "Troll", "Appeler", function(self)
                RunConsoleCommand("say", "@ " .. self:GetValue())
                frameDrop:Remove()
            end)
		end
	},
    {
        ["Name"] = "Changer de Vue",
        ["Function"] = function()
            -- Votre fonction à vous
        end
    },
    {
        ["Name"] = "Jeter de l'argent",
        ["Function"] = function()
            ProkectContext:CreateFrameDrop("Jeter de l'argent", "Combien voulez-vous jeter ?", "Veuillez saisir le montant ici !", "1", "Jeter", function(self)
                RunConsoleCommand("say", "/dropmoney " .. self:GetValue())
                frameDrop:Remove()
            end)
        end
    },
    {
        ["Name"] = "Jeter son arme",
        ["Function"] = function()
            RunConsoleCommand("say", "/drop")
        end
    },
    {
        ["Name"] = "StopSound",
        ["Function"] = function()
            RunConsoleCommand("stopsound")
        end
    },
	{
        ["Name"] = "Body Group",
        ["Function"] = function()
            -- Votre function
        end
    },
}