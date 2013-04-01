//DarkRP Public HUD
//Version 2.0
//Made by [IЯAF]Alberto

surface.CreateFont( "DarkRPPublicHUD1", {
font = "Coolvetica",
size = 25,
weight = 500,
blursize = 0,
scanlines = 0,
antialias = true,
underline = false,
italic = false,
strikeout = false,
symbol = false,
rotary = false,
shadow = false,
additive = true,
outline = false
})

surface.CreateFont( "DarkRPPublicHUD2", {
font = "Coolvetica",
size = 25,
weight = 500,
blursize = 0,
scanlines = 0,
antialias = true,
underline = false,
italic = false,
strikeout = false,
symbol = false,
rotary = false,
shadow = false,
additive = false,
outline = false
})

surface.CreateFont( "DarkRPPublicHUD3", {
font = "Coolvetica",
size = 50,
weight = 500,
blursize = 0,
scanlines = 0,
antialias = true,
underline = false,
italic = false,
strikeout = false,
symbol = false,
rotary = false,
shadow = false,
additive = false,
outline = false
})


surface.CreateFont( "DarkRPPublicHUD4", {
font = "Coolvetica",
size = 28,
weight = 500,
blursize = 0,
scanlines = 0,
antialias = true,
underline = false,
italic = false,
strikeout = false,
symbol = false,
rotary = false,
shadow = false,
additive = true,
outline = false
})

local function darkrphud()

--Maybe if you want you can use the DarkRP HUD values, or they can be useless.
local enabletopmessage = false --Enable(true)or disable(false) the message at the top right of the screen. Disabled by default.

local topmessage = "insert you desired text here" --A message at the top right of the screen, to indicate the server/clan name or the server/clan webpage. Whatever you want.
local topmsgbgcolor = Color(0,50,255,255)--Top message background color
local topmsgcolor = Color(255,255,255,255)--Top message text color

local Hpfrac = math.Clamp(LocalPlayer():Health(),0,100) / 100-- This is the thing to make the HUD go from green to red

local mainbgcolor = Color(0,0,0,150) --The color of the background of the main group of HUD(health, etc)
local ammobgcolor = Color(0,0,0,150) --The color of the background of the ammo group of HUD(ammo clip, etc)

local healthbg = Color(0,0,0,150) --Health bar background color
local healthcolor = Color(180*(1 - Hpfrac),180*Hpfrac,0,255)--The health bar foreground color
local hptextcolor = Color(255*(1 - Hpfrac),255*Hpfrac,0,255)--The health text color
local hpiconcolor = Color(255*(1 - Hpfrac),255*Hpfrac,0,255)--The health icon color

local extrabg = Color(0,0,0,150) --Extra bar background color
local hpextracolor = Color(0,180,180,255) -- the health bar color when it's over 100HP
local hptxtextracolor = Color(0,255,255,255) -- the health text color when it's over 100HP

local extravalue = LocalPlayer():Armor()--The extra bar value, armor bar by default
local extracolor = Color(100,100,100,255)--The extra bar color, grey by default
local extratextcolor = Color(200,200,200,255)--The extra value text color, light grey by default

local moneycolor = Color(0,255,0,255)--The color of the money indicator
local salarycolor = Color(0,255,0,255)--The color of the salary indicator

local jobcolor = Color(255,255,255,255)--The color of the job indicator
local jobbg = team.GetColor(LocalPlayer():Team())--The color of the job indicator background

local namecolor = Color(255,255,255,255)--The color of the name indicator

local ammocolor = Color(255,255,0,255)
if LocalPlayer():GetActiveWeapon().Primary != nil then
    if (LocalPlayer():GetActiveWeapon():Clip1()*100)/LocalPlayer():GetActiveWeapon().Primary.ClipSize > 25 then
        ammocolor = Color(255,255,0,255)--Ammo clip text color
    else
        ammocolor = Color(255,0,0,255)--Ammo clip text color when is less that 25% of clip capacity
    end
end

local ammocolor2 = Color(255,255,0,255)--Extra ammo text color

local hptexture = surface.GetTextureID("gui/silkicons/heart")--Health icon
local extratexture = surface.GetTextureID("gui/silkicons/shield")--Extra bar icon, armor bar by default
local moneytexture = surface.GetTextureID("gui/silkicons/money")--Money icon
local salarytexture = surface.GetTextureID("gui/silkicons/money_add")--Salary icon
local jobtexture = surface.GetTextureID("gui/silkicons/user_suit")--Job icon
local nametexture = surface.GetTextureID("gui/silkicons/user")--Job icon

local mainposx = 10 --The X position of the main group of HUD (health, etc)
local mainposy = ScrH() - 70 --The Y position of the main group of HUD (health, etc)

local ammoposx = ScrW() - 210 --The X position of the ammo group of HUD (ammo clip, etc)
local ammoposy = ScrH() - 70 --The Y position of the ammo group of HUD (ammo clip, etc)

/*-------------------------------------------------------------------------
    
    Here begins the HUD function, just edit if you're advanced!
    
--------------------------------------------------------------------------*/

local client = LocalPlayer()

	if enabletopmessage == true then
        --Top message
        surface.SetFont("DarkRPPublicHUD2")
        local tmsgspace = surface.GetTextSize(topmessage)
        draw.RoundedBox(8, ScrW() - tmsgspace - 13, 5, tmsgspace + 8, 25, topmsgbgcolor)
        draw.SimpleText(topmessage,"DarkRPPublicHUD2", ScrW() - tmsgspace - 10, 5, topmsgcolor)
	end

    --Main background
    if extravalue > 0 then
        draw.RoundedBox(8, mainposx, mainposy, 240, 51, mainbgcolor)
    else
        draw.RoundedBox(8, mainposx, mainposy, 240, 30, mainbgcolor)
    end
        --Health bar
       draw.RoundedBox(6, mainposx + 30, mainposy + 5, 200, 20, healthbg)--health bar background
    
        if client:Health() > 100 then
            draw.RoundedBox(6, mainposx + 30, mainposy + 5, 200, 20, hpextracolor)--health bar color
            draw.RoundedBox(4, mainposx + 30, mainposy + 5, 200, 8, Color(255,255,255,40))--Health bar bright
            draw.SimpleText(client:Health(), "DarkRPPublicHUD4", mainposx + 127, mainposy + 3, hptxtextracolor, 1, 0)
        elseif client:Health() > 0 then
            draw.RoundedBox(6, mainposx + 30, mainposy + 5, (client:Health()*200)/100, 20, healthcolor)--health bar color
            draw.RoundedBox(4, mainposx + 30, mainposy + 5, (client:Health()*200)/100, 8, Color(255,255,255,40))--Health bar bright
            draw.SimpleText(client:Health(), "DarkRPPublicHUD4", mainposx + 127, mainposy + 3, hptextcolor, 1, 0)
        else
            draw.SimpleText("0", "DarkRPPublicHUD4", mainposx + 127, mainposy + 3, hptextcolor, 1, 0)
        end
        --Health icon
        surface.SetTexture(hptexture)
    
        if client:Health() > 100 then
            surface.SetDrawColor(hptxtextracolor)
        else
            surface.SetDrawColor(hpiconcolor)
        end
    
        surface.DrawTexturedRect(mainposx+7,mainposy+7,18,18)
        
        --Extra bar
        if extravalue > 0 then
            draw.RoundedBox(8, mainposx + 30, mainposy + 28, 200, 18, healthbg)--extra bar bar background
    
            if extravalue > 100 then
                draw.RoundedBox(6, mainposx + 30, mainposy + 28, 200, 18, extracolor)--extra bar foreground
                draw.RoundedBox(4, mainposx + 30, mainposy + 28, 200, 8, Color(255,255,255,40))--extra bar bright
                draw.SimpleText(extravalue, "DarkRPPublicHUD1", mainposx + 127, mainposy + 34, extratextcolor, 1, 0)--extra text
            elseif extravalue > 0 then
                draw.RoundedBox(6, mainposx + 30, mainposy + 28, (extravalue*200)/100, 18, extracolor)--extra bar foreground
                draw.RoundedBox(4, mainposx + 30, mainposy + 28, (extravalue*200)/100, 8, Color(255,255,255,40))--extra bar bright
                draw.SimpleText(extravalue, "DarkRPPublicHUD1", mainposx + 127, mainposy + 26, extratextcolor, 1, 0)--extra value text
            end
            --Extra icon
            surface.SetTexture(extratexture)
            surface.SetDrawColor(255,255,255,255)
            surface.DrawTexturedRect(mainposx+8,mainposy+29,16,16)
        end
    --Money 'n stuff
	if client.DarkRPVars.job != nil and client.DarkRPVars.rpname != nil and client.DarkRPVars.salary != nil then
        --Money
        surface.SetFont("DarkRPPublicHUD2")
        draw.RoundedBox(8,mainposx, mainposy - 28, surface.GetTextSize("$"..client.DarkRPVars.money)+34, 26, mainbgcolor)
            
            draw.SimpleText("$"..client.DarkRPVars.money, "DarkRPPublicHUD2", mainposx + 26, mainposy - 25, moneycolor)
            surface.SetTexture(moneytexture)
            surface.SetDrawColor(255,255,255,255)
            surface.DrawTexturedRect(mainposx + 6,mainposy - 23, 16, 16)
            
            --Salary
            draw.RoundedBox(8,mainposx + surface.GetTextSize(client.DarkRPVars.money) + 46, mainposy - 28, surface.GetTextSize(client.DarkRPVars.salary)+50, 26, mainbgcolor)
            
                draw.SimpleText("$"..client.DarkRPVars.salary, "DarkRPPublicHUD2", mainposx + surface.GetTextSize(client.DarkRPVars.money) + 75, mainposy - 26, salarycolor)
                surface.SetTexture(salarytexture)
                surface.SetDrawColor(255,255,255,255)
                surface.DrawTexturedRect(mainposx + surface.GetTextSize(client.DarkRPVars.money) + 54,mainposy - 24, 16, 16)
        --Job background
        surface.SetFont("DarkRPPublicHUD2")
        draw.RoundedBox(8,mainposx, mainposy - 56, surface.GetTextSize(client.DarkRPVars.job)+40, 26, jobbg)
        
            draw.SimpleText(client.DarkRPVars.job, "DarkRPPublicHUD2", mainposx + 30, mainposy - 55, jobcolor)
            surface.SetTexture(jobtexture)
            surface.SetDrawColor(255,255,255,255)
            surface.DrawTexturedRect(mainposx + 6,mainposy - 52, 16, 16)
        
        --Name background
        draw.RoundedBox(8,mainposx, mainposy - 84, surface.GetTextSize(client.DarkRPVars.rpname)+40, 26, mainbgcolor)
        
            draw.SimpleText(client.DarkRPVars.rpname, "DarkRPPublicHUD2", mainposx + 30, mainposy - 82, namecolor)
            surface.SetTexture(nametexture)
            surface.SetDrawColor(255,255,255,255)
            surface.DrawTexturedRect(mainposx + 6,mainposy - 80, 16, 16)
	else
		draw.SimpleText("Loading...", "DarkRPPublicHUD2", mainposx + 30, mainposy - 30, Color(255,0,0,255))
    end
    --Weapons and stuff
    if client:GetActiveWeapon() != NULL then
        if client:GetActiveWeapon():Clip1() != -1 then
            if client:GetActiveWeapon():GetPrintName() != "#HL2_GravityGun" then
                draw.RoundedBox(8, ammoposx, ammoposy, 200, 50, ammobgcolor)
        
              --Clip
              draw.SimpleText(client:GetActiveWeapon():Clip1(),"DarkRPPublicHUD3",ammoposx + 80, ammoposy + 3, ammocolor,2,0)
        
                --Extra
                draw.SimpleText(client:GetAmmoCount(client:GetActiveWeapon():GetPrimaryAmmoType()),"DarkRPPublicHUD1",ammoposx + 90, ammoposy, ammocolor2,0,0)
                --Ammo bar
                if client:GetActiveWeapon().Primary != nil then
                    draw.RoundedBox(6, ammoposx + 85, ammoposy + 25, 105, 15, ammobgcolor)
                    if client:GetActiveWeapon():Clip1() > 0 then
                        draw.RoundedBox(6, ammoposx + 85, ammoposy + 25, (client:GetActiveWeapon():Clip1()*105)/client:GetActiveWeapon().Primary.ClipSize, 15, ammocolor)
                    end
                end
            end
        else
            if client:GetAmmoCount(client:GetActiveWeapon():GetPrimaryAmmoType()) != 0 then
                draw.RoundedBox(8, ammoposx, ammoposy, 60, 50, ammobgcolor)
                draw.SimpleText(client:GetAmmoCount(client:GetActiveWeapon():GetPrimaryAmmoType()),"DarkRPPublicHUD3",ammoposx + 50, ammoposy, ammocolor,2,0)
            end
        end
    end
end
hook.Add("HUDPaint", "darkrphud", darkrphud)

local tohide = { -- This is a table where the keys are the HUD items to hide
["CHudHealth"] = true,
["CHudBattery"] = true,
["CHudAmmo"] = true,
["CHudSecondaryAmmo"] = true
}
local function HUDShouldDraw(name) -- This is a local function because all functions should be local unless another file needs to run it
if (tohide[name]) then     -- If the HUD name is a key in the table
return false;      -- Return false.
end
end
hook.Add("HUDShouldDraw", "darkrphudShouldDraw", HUDShouldDraw)

--Copyright © 2013 [IЯAF] Alberto.
