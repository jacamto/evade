-- Wait for game to load
repeat task.wait() until game:IsLoaded();

-- Temp fix for ROBLOX turning off highlights
if setfflag then setfflag("OutlineSelection", "true") end

-- Services
local ReplicatedStorage = game:GetService("ReplicatedStorage");
local CoreGui = game:GetService("CoreGui");
local Players = game:GetService("Players");
local Workspace = game:GetService("Workspace");
local Lighting = game:GetService("Lighting");
local VirtualInputManager = game:GetService("VirtualInputManager");

-- Remote Stuff
local Events = ReplicatedStorage:WaitForChild("Events", 1337)

-- Local Player
local Player = Players.LocalPlayer;

-- UI Lib (Fluxus Lib because I like it)
local lib = loadstring(game:HttpGet("https://raw.githubusercontent.com/jacamto/Lib/main/fluxusLIB.lua"))()

-- ESP support
local ESP = loadstring(game:HttpGet("https://raw.githubusercontent.com/jacamto/esp/main/highlightoutline.lua"))()

-- Main Window
local Window = lib:CreateWindow("Evade ; Made by jacato")

-- Create Pages
local MainPage = Window:NewTab("Main")

-- Create Sections
local CharSection = MainPage:AddSection("Character")
local OtherSection = MainPage:AddSection("Headless and Heart")
local InventorySection = MainPage:AddSection("Dev Emote")
local JacatoSection = MainPage:AddSection("Copy my discord tag :3")

-- GUI Toggles / Settings
local Highlights_Active = false;
local AI_ESP = false;
local No_CamShake = false;

-- Anti AFK
for i,v in pairs(getconnections(game:GetService("Players").LocalPlayer.Idled)) do v:Disable() end

-- Simple Text ESP
function Simple_Create(base, name, trackername, studs)
    local bb = Instance.new('BillboardGui', game.CoreGui)
    bb.Adornee = base
    bb.ExtentsOffset = Vector3.new(0,1,0)
    bb.AlwaysOnTop = true
    bb.Size = UDim2.new(0,6,0,6)
    bb.StudsOffset = Vector3.new(0,1,0)
    bb.Name = trackername

    local frame = Instance.new('Frame', bb)
    frame.ZIndex = 10
    frame.BackgroundTransparency = 0.3
    frame.Size = UDim2.new(1,0,1,0)
    frame.BackgroundColor3 = Color3.fromRGB(255, 0, 0)

    local txtlbl = Instance.new('TextLabel', bb)
    txtlbl.ZIndex = 10
    txtlbl.BackgroundTransparency = 1
    txtlbl.Position = UDim2.new(0,0,0,-48)
    txtlbl.Size = UDim2.new(1,0,10,0)
    txtlbl.Font = 'ArialBold'
    txtlbl.FontSize = 'Size12'
    txtlbl.Text = name
    txtlbl.TextStrokeTransparency = 0.5
    txtlbl.TextColor3 = Color3.fromRGB(255, 0, 0)

    local txtlblstud = Instance.new('TextLabel', bb)
    txtlblstud.ZIndex = 10
    txtlblstud.BackgroundTransparency = 1
    txtlblstud.Position = UDim2.new(0,0,0,-35)
    txtlblstud.Size = UDim2.new(1,0,10,0)
    txtlblstud.Font = 'ArialBold'
    txtlblstud.FontSize = 'Size12'
    txtlblstud.Text = tostring(studs) .. " Studs"
    txtlblstud.TextStrokeTransparency = 0.5
    txtlblstud.TextColor3 = Color3.new(255,255,255)
end

-- Clear ESP
function ClearESP(espname)
    for _,v in pairs(game.CoreGui:GetChildren()) do
        if v.Name == espname and v:isA('BillboardGui') then
            v:Destroy()
        end
    end
end

-- Respawn/Reset
CharSection:AddButton("Respawn", "Free respawn (not 15rbx), use while downed! not dead!", function()
    local Reset = Events:FindFirstChild("Reset")
    local Respawn = Events:FindFirstChild("Respawn")

    if Reset and Respawn then
        Reset:FireServer();
        task.wait(2)
        Respawn:FireServer();
    end
end)

-- MERC outfit
CharSection:AddButton("Merc fit", "Merc", function()
    for i,v in pairs(game.Players.luluuluvrr.Character:GetChildren()) do
		if v:IsA("Accessory") then
			v:Destroy()
		end
    	end
            function l(a, _)
            local b = Instance.new("Weld")
            b.Part0 = a.Parent
            b.Part1 = _.Parent
            b.C0 = a.CFrame
            b.C1 = _.CFrame
            b.Parent = a.Parent
            return b
        end
        local function b(c, b, _, a, d, e)
            local f = Instance.new("Weld")
            f.Name = c
            f.Part0 = _
            f.Part1 = a
            f.C0 = d
            f.C1 = e
            f.Parent = b
            return f
        end
        local function a(_, b)
            for _, _ in pairs(_:GetChildren()) do
                if _:IsA("Attachment") and _.Name == b then
                    return _
                elseif not _:IsA("Accoutrement") and not _:IsA("Tool") then
                    local _ = a(_, b)
                    if _ then
                        return _
                    end
                end
            end
        end
        function k(_, d)
            d.Parent = _
            local e = d:FindFirstChild("Handle")
            if e then
                local c = e:FindFirstChildOfClass("Attachment")
                if c then
                    local _ = a(_, c.Name)
                    if _ then
                        l(_, c)
                    end
                else
                    local c = _:FindFirstChild("Head")
                    if c then
                        local a = CFrame.new(0, 0, 0)
                        local _ = d.AttachmentPoint
                        b("HeadWeld", c, c, e, a, _)
                    end
                end
            end
        end
        local _ = 283749451
        local _ = game:GetObjects("rbxassetid://" .. tostring(_))[1]
        k(game.Players.luluuluvrr.Character, _)
        game.Players.luluuluvrr.Character.Shirt.ShirtTemplate = "rbxassetid://0"
        game.Players.luluuluvrr.Character.Pants.PantsTemplate = "rbxassetid://0"
        game.Players.luluuluvrr.Character['Shirt Graphic'].Graphic = "rbxassetid://11156640644"
        game.Players.luluuluvrr.Character.Head.MeshId = "http://roblox.com/asset/?id=7430070993"
        game.Players.luluuluvrr.Character.Head.face.Texture = "rbxassetid://8560915"
        game.Players.luluuluvrr.Character.LeftLowerLeg.MeshId = "http://www.roblox.com/asset/?id=7430071105"
        game.Players.luluuluvrr.Character.LeftLowerLeg.Transparency = "0"
        game.Players.luluuluvrr.Character.LeftUpperLeg.MeshId = "http://www.roblox.com/asset/?id=7430071119"
        game.Players.luluuluvrr.Character.LeftUpperLeg.TextureID = "http://roblox.com/asset/?id=0"
        game.Players.luluuluvrr.Character.LeftFoot.MeshId = "http://www.roblox.com/asset/?id=7430071082"
        game.Players.luluuluvrr.Character.LeftFoot.Transparency = "0"
        game.Players.luluuluvrr.Character.RightLowerLeg.MeshId = "http://www.roblox.com/asset/?id=7430071105"
        game.Players.luluuluvrr.Character.RightLowerLeg.Transparency = "0"
        game.Players.luluuluvrr.Character.RightUpperLeg.MeshId = "http://www.roblox.com/asset/?id=7430071119"
        game.Players.luluuluvrr.Character.RightUpperLeg.TextureID = "http://roblox.com/asset/?id=0"
        game.Players.luluuluvrr.Character.RightFoot.MeshId = "http://www.roblox.com/asset/?id=7430071082"
        game.Players.luluuluvrr.Character.RightFoot.Transparency = "0"
q = BrickColor.new("Institutional white")
e = BrickColor.new("Really black")
r = BrickColor.new("Dark stone grey")
game.Players.luluuluvrr.Character.Head.BrickColor = q
game.Players.luluuluvrr.Character.UpperTorso.BrickColor = r
game.Players.luluuluvrr.Character["RightLowerArm"].BrickColor = e
game.Players.luluuluvrr.Character["LeftLowerArm"].BrickColor = e
game.Players.luluuluvrr.Character["RightUpperArm"].BrickColor = e
game.Players.luluuluvrr.Character["LeftUpperArm"].BrickColor = e
game.Players.luluuluvrr.Character["LeftLowerLeg"].BrickColor = e
game.Players.luluuluvrr.Character["RightLowerLeg"].BrickColor = e
game.Players.luluuluvrr.Character["RightUpperLeg"].BrickColor = e
game.Players.luluuluvrr.Character["LeftUpperLeg"].BrickColor = e
game.Players.luluuluvrr.Character["RightFoot"].BrickColor = e
game.Players.luluuluvrr.Character["LeftFoot"].BrickColor = e
game.Players.luluuluvrr.Character["RightHand"].BrickColor = e
game.Players.luluuluvrr.Character["LeftHand"].BrickColor = e
game.Players.luluuluvrr.Character.MedivalBikeHelmet.Handle.CanCollide = false
game.Players.luluuluvrr.Character.Animate.idle.Animation1.AnimationId = "http://www.roblox.com/asset/?id=657595757"
game.Players.luluuluvrr.Character.Animate.idle.Animation2.AnimationId = "http://www.roblox.com/asset/?id=657568135"
game.Players.luluuluvrr.Character.Animate.walk.WalkAnim.AnimationId = "http://www.roblox.com/asset/?id=657552124"
game.Players.luluuluvrr.Character.Animate.run.RunAnim.AnimationId = "http://www.roblox.com/asset/?id=707861613"
game.Players.luluuluvrr.Character.Animate.jump.JumpAnim.AnimationId = "http://www.roblox.com/asset/?id=2510197830"
game.Players.luluuluvrr.Character.Animate.climb.ClimbAnim.AnimationId = "http://www.roblox.com/asset/?id=2510192778"
game.Players.luluuluvrr.Character.Animate.fall.FallAnim.AnimationId = "http://www.roblox.com/asset/?id=2510195892"
game.Players.luluuluvrr.Character.Animate.swim.Swim.AnimationId = "http://www.roblox.com/asset/?id=2510199791"
game.Players.luluuluvrr.Character.Animate.swimidle.SwimIdle.AnimationId = "http://www.roblox.com/asset/?id=2510201162"
end)

-- MERC HATS
CharSection:AddButton("Merc rich hats", "Merc", function()
    for i,v in pairs(game.Players.luluuluvrr.Character:GetChildren()) do
		if v:IsA("Accessory") then
			v:Destroy()
		end
    	end
        function l(a, _)
            local b = Instance.new("Weld")
            b.Part0 = a.Parent
            b.Part1 = _.Parent
            b.C0 = a.CFrame
            b.C1 = _.CFrame
            b.Parent = a.Parent
            return b
        end
        local function _(_, a, b, d, c, e)
            local f = Instance.new("Weld")
            f.Name = _
            f.Part0 = b
            f.Part1 = d
            f.C0 = c
            f.C1 = e
            f.Parent = a
            return f
        end
        local function a(_, b)
            for _, _ in pairs(_:GetChildren()) do
                if _:IsA("Attachment") and _.Name == b then
                    return _
                elseif not _:IsA("Accoutrement") and not _:IsA("Tool") then
                    local _ = a(_, b)
                    if _ then
                        return _
                    end
                end
            end
        end
        function k(e, c)
            c.Parent = e
            local d = c:FindFirstChild("Handle")
            if d then
                local b = d:FindFirstChildOfClass("Attachment")
                if b then
                    local _ = a(e, b.Name)
                    if _ then
                        l(_, b)
                    end
                else
                    local e = e:FindFirstChild("Head")
                    if e then
                        local b = CFrame.new(0, 0.5, 0)
                        local a = c.AttachmentPoint
                        _("HeadWeld", e, e, d, b, a)
                    end
                end
            end
        end
        local _ = 215718515
        local _ = game:GetObjects("rbxassetid://" .. tostring(_))[1]
        k(game.Players.luluuluvrr.Character, _)
            function l(a, _)
            local b = Instance.new("Weld")
            b.Part0 = a.Parent
            b.Part1 = _.Parent
            b.C0 = a.CFrame
            b.C1 = _.CFrame
            b.Parent = a.Parent
            return b
        end
        local function b(c, b, _, a, d, e)
            local f = Instance.new("Weld")
            f.Name = c
            f.Part0 = _
            f.Part1 = a
            f.C0 = d
            f.C1 = e
            f.Parent = b
            return f
        end
        local function a(_, b)
            for _, _ in pairs(_:GetChildren()) do
                if _:IsA("Attachment") and _.Name == b then
                    return _
                elseif not _:IsA("Accoutrement") and not _:IsA("Tool") then
                    local _ = a(_, b)
                    if _ then
                        return _
                    end
                end
            end
        end
        function k(_, d)
            d.Parent = _
            local e = d:FindFirstChild("Handle")
            if e then
                local c = e:FindFirstChildOfClass("Attachment")
                if c then
                    local _ = a(_, c.Name)
                    if _ then
                        l(_, c)
                    end
                else
                    local c = _:FindFirstChild("Head")
                    if c then
                        local a = CFrame.new(0, 0, 0)
                        local _ = d.AttachmentPoint
                        b("HeadWeld", c, c, e, a, _)
                    end
                end
            end
        end
        local _ = 283749451
        local _ = game:GetObjects("rbxassetid://" .. tostring(_))[1]
        k(game.Players.luluuluvrr.Character, _)
            function l(a, _)
            local b = Instance.new("Weld")
            b.Part0 = a.Parent
            b.Part1 = _.Parent
            b.C0 = a.CFrame
            b.C1 = _.CFrame
            b.Parent = a.Parent
            return b
        end
        local function b(c, b, _, a, d, e)
            local f = Instance.new("Weld")
            f.Name = c
            f.Part0 = _
            f.Part1 = a
            f.C0 = d
            f.C1 = e
            f.Parent = b
            return f
        end
        local function a(_, b)
            for _, _ in pairs(_:GetChildren()) do
                if _:IsA("Attachment") and _.Name == b then
                    return _
                elseif not _:IsA("Accoutrement") and not _:IsA("Tool") then
                    local _ = a(_, b)
                    if _ then
                        return _
                    end
                end
            end
        end
        function k(_, d)
            d.Parent = _
            local e = d:FindFirstChild("Handle")
            if e then
                local c = e:FindFirstChildOfClass("Attachment")
                if c then
                    local _ = a(_, c.Name)
                    if _ then
                        l(_, c)
                    end
                else
                    local c = _:FindFirstChild("Head")
                    if c then
                        local a = CFrame.new(0, 0, 0)
                        local _ = d.AttachmentPoint
                        b("HeadWeld", c, c, e, a, _)
                    end
                end
            end
        end
        local _ = 1340199684
        local _ = game:GetObjects("rbxassetid://" .. tostring(_))[1]
        k(game.Players.luluuluvrr.Character, _)
	game.Players.luluuluvrr.Character.MedivalBikeHelmet.Handle.CanCollide = false
	game.Players.luluuluvrr.Character.DarkFedration.Handle.CanCollide = false
	game.Players.luluuluvrr.Character.FlamingHorns.Handle.CanCollide = false
	game.Players.luluuluvrr.Character.Animate.idle.Animation1.AnimationId = "http://www.roblox.com/asset/?id=657595757"
	game.Players.luluuluvrr.Character.Animate.idle.Animation2.AnimationId = "http://www.roblox.com/asset/?id=657568135"
	game.Players.luluuluvrr.Character.Animate.walk.WalkAnim.AnimationId = "http://www.roblox.com/asset/?id=657552124"
	game.Players.luluuluvrr.Character.Animate.run.RunAnim.AnimationId = "http://www.roblox.com/asset/?id=707861613"
	game.Players.luluuluvrr.Character.Animate.jump.JumpAnim.AnimationId = "http://www.roblox.com/asset/?id=2510197830"
	game.Players.luluuluvrr.Character.Animate.climb.ClimbAnim.AnimationId = "http://www.roblox.com/asset/?id=2510192778"
	game.Players.luluuluvrr.Character.Animate.fall.FallAnim.AnimationId = "http://www.roblox.com/asset/?id=2510195892"
	game.Players.luluuluvrr.Character.Animate.swim.Swim.AnimationId = "http://www.roblox.com/asset/?id=2510199791"
	game.Players.luluuluvrr.Character.Animate.swimidle.SwimIdle.AnimationId = "http://www.roblox.com/asset/?id=2510201162"
end)

-- noob sign
CharSection:AddButton("Noob sign", "Weed inhaler", function()
    for i,v in pairs(game.Players.luluuluvrr.Character:GetChildren()) do
		if v:IsA("Accessory") then
			v:Destroy()
		end
    	end
        function l(a, _)
            local b = Instance.new("Weld")
            b.Part0 = a.Parent
            b.Part1 = _.Parent
            b.C0 = a.CFrame
            b.C1 = _.CFrame
            b.Parent = a.Parent
            return b
        end
        local function _(_, a, b, d, c, e)
            local f = Instance.new("Weld")
            f.Name = _
            f.Part0 = b
            f.Part1 = d
            f.C0 = c
            f.C1 = e
            f.Parent = a
            return f
        end
        local function a(_, b)
            for _, _ in pairs(_:GetChildren()) do
                if _:IsA("Attachment") and _.Name == b then
                    return _
                elseif not _:IsA("Accoutrement") and not _:IsA("Tool") then
                    local _ = a(_, b)
                    if _ then
                        return _
                    end
                end
            end
        end
        function k(e, c)
            c.Parent = e
            local d = c:FindFirstChild("Handle")
            if d then
                local b = d:FindFirstChildOfClass("Attachment")
                if b then
                    local _ = a(e, b.Name)
                    if _ then
                        l(_, b)
                    end
                else
                    local e = e:FindFirstChild("Head")
                    if e then
                        local b = CFrame.new(0, 0.5, 0)
                        local a = c.AttachmentPoint
                        _("HeadWeld", e, e, d, b, a)
                    end
                end
            end
        end
        local _ = 10060525
        local _ = game:GetObjects("rbxassetid://" .. tostring(_))[1]
        k(game.Players.luluuluvrr.Character, _)
        game.Players.luluuluvrr.Character.Shirt.ShirtTemplate = "rbxassetid://0"
        game.Players.luluuluvrr.Character.Pants.PantsTemplate = "rbxassetid://0"
        game.Players.luluuluvrr.Character['Shirt Graphic'].Graphic = "rbxassetid://8170120076"
        game.Players.luluuluvrr.Character.Head.face.Texture = "rbxassetid://7076053"
        game.Players.luluuluvrr.Character.LeftLowerLeg.MeshId = "http://www.roblox.com/asset/?id=7430071105"
        game.Players.luluuluvrr.Character.LeftLowerLeg.Transparency = "0"
        game.Players.luluuluvrr.Character.LeftUpperLeg.MeshId = "http://www.roblox.com/asset/?id=7430071119"
        game.Players.luluuluvrr.Character.LeftUpperLeg.TextureID = "http://roblox.com/asset/?id=0"
        game.Players.luluuluvrr.Character.LeftFoot.MeshId = "http://www.roblox.com/asset/?id=7430071082"
        game.Players.luluuluvrr.Character.LeftFoot.Transparency = "0"
        game.Players.luluuluvrr.Character.RightLowerLeg.MeshId = "http://www.roblox.com/asset/?id=7430071105"
        game.Players.luluuluvrr.Character.RightLowerLeg.Transparency = "0"
        game.Players.luluuluvrr.Character.RightUpperLeg.MeshId = "http://www.roblox.com/asset/?id=7430071119"
        game.Players.luluuluvrr.Character.RightUpperLeg.TextureID = "http://roblox.com/asset/?id=0"
        game.Players.luluuluvrr.Character.RightFoot.MeshId = "http://www.roblox.com/asset/?id=7430071082"
        game.Players.luluuluvrr.Character.RightFoot.Transparency = "0"
        game.Players.luluuluvrr.Character.Head.MeshId = "http://roblox.com/asset/?id=7430070993"
q = BrickColor.new("Institutional white")
e = BrickColor.new("Dark stone grey")
r = BrickColor.new("Medium stone grey")
game.Players.luluuluvrr.Character.Head.BrickColor = q
game.Players.luluuluvrr.Character.UpperTorso.BrickColor = r
game.Players.luluuluvrr.Character["RightLowerArm"].BrickColor = e
game.Players.luluuluvrr.Character["LeftLowerArm"].BrickColor = e
game.Players.luluuluvrr.Character["RightUpperArm"].BrickColor = e
game.Players.luluuluvrr.Character["LeftUpperArm"].BrickColor = e
game.Players.luluuluvrr.Character["LeftLowerLeg"].BrickColor = e
game.Players.luluuluvrr.Character["RightLowerLeg"].BrickColor = e
game.Players.luluuluvrr.Character["RightUpperLeg"].BrickColor = e
game.Players.luluuluvrr.Character["LeftUpperLeg"].BrickColor = e
game.Players.luluuluvrr.Character["RightFoot"].BrickColor = e
game.Players.luluuluvrr.Character["LeftFoot"].BrickColor = e
game.Players.luluuluvrr.Character["RightHand"].BrickColor = e
game.Players.luluuluvrr.Character["LeftHand"].BrickColor = e
	game.Players.luluuluvrr.Character.NoobSign.Handle.CanCollide = false
    game.Players.luluuluvrr.Character.Animate.idle.Animation1.AnimationId = "http://www.roblox.com/asset/?id=845397899"
    game.Players.luluuluvrr.Character.Animate.idle.Animation2.AnimationId = "http://www.roblox.com/asset/?id=845400520"
	game.Players.luluuluvrr.Character.Animate.walk.WalkAnim.AnimationId = "http://www.roblox.com/asset/?id=657552124"
	game.Players.luluuluvrr.Character.Animate.run.RunAnim.AnimationId = "http://www.roblox.com/asset/?id=707861613"
	game.Players.luluuluvrr.Character.Animate.jump.JumpAnim.AnimationId = "http://www.roblox.com/asset/?id=2510197830"
	game.Players.luluuluvrr.Character.Animate.climb.ClimbAnim.AnimationId = "http://www.roblox.com/asset/?id=2510192778"
	game.Players.luluuluvrr.Character.Animate.fall.FallAnim.AnimationId = "http://www.roblox.com/asset/?id=2510195892"
	game.Players.luluuluvrr.Character.Animate.swim.Swim.AnimationId = "http://www.roblox.com/asset/?id=2510199791"
	game.Players.luluuluvrr.Character.Animate.swimidle.SwimIdle.AnimationId = "http://www.roblox.com/asset/?id=2510201162"
end)

-- noob sign goat
CharSection:AddButton("Noob sign goat hats", "yeah", function()
    for i,v in pairs(game.Players.luluuluvrr.Character:GetChildren()) do
		if v:IsA("Accessory") then
			v:Destroy()
		end
    	end
        function l(a, _)
            local b = Instance.new("Weld")
            b.Part0 = a.Parent
            b.Part1 = _.Parent
            b.C0 = a.CFrame
            b.C1 = _.CFrame
            b.Parent = a.Parent
            return b
        end
        local function _(_, a, b, d, c, e)
            local f = Instance.new("Weld")
            f.Name = _
            f.Part0 = b
            f.Part1 = d
            f.C0 = c
            f.C1 = e
            f.Parent = a
            return f
        end
        local function a(_, b)
            for _, _ in pairs(_:GetChildren()) do
                if _:IsA("Attachment") and _.Name == b then
                    return _
                elseif not _:IsA("Accoutrement") and not _:IsA("Tool") then
                    local _ = a(_, b)
                    if _ then
                        return _
                    end
                end
            end
        end
        function k(e, c)
            c.Parent = e
            local d = c:FindFirstChild("Handle")
            if d then
                local b = d:FindFirstChildOfClass("Attachment")
                if b then
                    local _ = a(e, b.Name)
                    if _ then
                        l(_, b)
                    end
                else
                    local e = e:FindFirstChild("Head")
                    if e then
                        local b = CFrame.new(0, 0.5, 0)
                        local a = c.AttachmentPoint
                        _("HeadWeld", e, e, d, b, a)
                    end
                end
            end
        end
        local _ = 10716153814
        local _ = game:GetObjects("rbxassetid://" .. tostring(_))[1]
        k(game.Players.luluuluvrr.Character, _)
            function l(a, _)
            local b = Instance.new("Weld")
            b.Part0 = a.Parent
            b.Part1 = _.Parent
            b.C0 = a.CFrame
            b.C1 = _.CFrame
            b.Parent = a.Parent
            return b
        end
        local function b(c, b, _, a, d, e)
            local f = Instance.new("Weld")
            f.Name = c
            f.Part0 = _
            f.Part1 = a
            f.C0 = d
            f.C1 = e
            f.Parent = b
            return f
        end
        local function a(_, b)
            for _, _ in pairs(_:GetChildren()) do
                if _:IsA("Attachment") and _.Name == b then
                    return _
                elseif not _:IsA("Accoutrement") and not _:IsA("Tool") then
                    local _ = a(_, b)
                    if _ then
                        return _
                    end
                end
            end
        end
        function k(_, d)
            d.Parent = _
            local e = d:FindFirstChild("Handle")
            if e then
                local c = e:FindFirstChildOfClass("Attachment")
                if c then
                    local _ = a(_, c.Name)
                    if _ then
                        l(_, c)
                    end
                else
                    local c = _:FindFirstChild("Head")
                    if c then
                        local a = CFrame.new(0, 0, 0)
                        local _ = d.AttachmentPoint
                        b("HeadWeld", c, c, e, a, _)
                    end
                end
            end
        end
        local _ = 6202902166
        local _ = game:GetObjects("rbxassetid://" .. tostring(_))[1]
        k(game.Players.luluuluvrr.Character, _)
            function l(a, _)
            local b = Instance.new("Weld")
            b.Part0 = a.Parent
            b.Part1 = _.Parent
            b.C0 = a.CFrame
            b.C1 = _.CFrame
            b.Parent = a.Parent
            return b
        end
        local function b(c, b, _, a, d, e)
            local f = Instance.new("Weld")
            f.Name = c
            f.Part0 = _
            f.Part1 = a
            f.C0 = d
            f.C1 = e
            f.Parent = b
            return f
        end
        local function a(_, b)
            for _, _ in pairs(_:GetChildren()) do
                if _:IsA("Attachment") and _.Name == b then
                    return _
                elseif not _:IsA("Accoutrement") and not _:IsA("Tool") then
                    local _ = a(_, b)
                    if _ then
                        return _
                    end
                end
            end
        end
        function k(_, d)
            d.Parent = _
            local e = d:FindFirstChild("Handle")
            if e then
                local c = e:FindFirstChildOfClass("Attachment")
                if c then
                    local _ = a(_, c.Name)
                    if _ then
                        l(_, c)
                    end
                else
                    local c = _:FindFirstChild("Head")
                    if c then
                        local a = CFrame.new(0, 0, 0)
                        local _ = d.AttachmentPoint
                        b("HeadWeld", c, c, e, a, _)
                    end
                end
            end
        end
        local _ = 10008494389
        local _ = game:GetObjects("rbxassetid://" .. tostring(_))[1]
        k(game.Players.luluuluvrr.Character, _)
        function l(a, _)
            local b = Instance.new("Weld")
            b.Part0 = a.Parent
            b.Part1 = _.Parent
            b.C0 = a.CFrame
            b.C1 = _.CFrame
            b.Parent = a.Parent
            return b
        end
        local function b(c, b, _, a, d, e)
            local f = Instance.new("Weld")
            f.Name = c
            f.Part0 = _
            f.Part1 = a
            f.C0 = d
            f.C1 = e
            f.Parent = b
            return f
        end
        local function a(_, b)
            for _, _ in pairs(_:GetChildren()) do
                if _:IsA("Attachment") and _.Name == b then
                    return _
                elseif not _:IsA("Accoutrement") and not _:IsA("Tool") then
                    local _ = a(_, b)
                    if _ then
                        return _
                    end
                end
            end
        end
        function k(_, d)
            d.Parent = _
            local e = d:FindFirstChild("Handle")
            if e then
                local c = e:FindFirstChildOfClass("Attachment")
                if c then
                    local _ = a(_, c.Name)
                    if _ then
                        l(_, c)
                    end
                else
                    local c = _:FindFirstChild("Head")
                    if c then
                        local a = CFrame.new(0, 0, 0)
                        local _ = d.AttachmentPoint
                        b("HeadWeld", c, c, e, a, _)
                    end
                end
            end
        end
        local _ = 7100481883
        local _ = game:GetObjects("rbxassetid://" .. tostring(_))[1]
        k(game.Players.luluuluvrr.Character, _)
        function l(a, _)
            local b = Instance.new("Weld")
            b.Part0 = a.Parent
            b.Part1 = _.Parent
            b.C0 = a.CFrame
            b.C1 = _.CFrame
            b.Parent = a.Parent
            return b
        end
        local function b(c, b, _, a, d, e)
            local f = Instance.new("Weld")
            f.Name = c
            f.Part0 = _
            f.Part1 = a
            f.C0 = d
            f.C1 = e
            f.Parent = b
            return f
        end
        local function a(_, b)
            for _, _ in pairs(_:GetChildren()) do
                if _:IsA("Attachment") and _.Name == b then
                    return _
                elseif not _:IsA("Accoutrement") and not _:IsA("Tool") then
                    local _ = a(_, b)
                    if _ then
                        return _
                    end
                end
            end
        end
        function k(_, d)
            d.Parent = _
            local e = d:FindFirstChild("Handle")
            if e then
                local c = e:FindFirstChildOfClass("Attachment")
                if c then
                    local _ = a(_, c.Name)
                    if _ then
                        l(_, c)
                    end
                else
                    local c = _:FindFirstChild("Head")
                    if c then
                        local a = CFrame.new(0, 0, 0)
                        local _ = d.AttachmentPoint
                        b("HeadWeld", c, c, e, a, _)
                    end
                end
            end
        end
        local _ = 10933512086
        local _ = game:GetObjects("rbxassetid://" .. tostring(_))[1]
        k(game.Players.luluuluvrr.Character, _)
        function l(a, _)
            local b = Instance.new("Weld")
            b.Part0 = a.Parent
            b.Part1 = _.Parent
            b.C0 = a.CFrame
            b.C1 = _.CFrame
            b.Parent = a.Parent
            return b
        end
        local function b(c, b, _, a, d, e)
            local f = Instance.new("Weld")
            f.Name = c
            f.Part0 = _
            f.Part1 = a
            f.C0 = d
            f.C1 = e
            f.Parent = b
            return f
        end
        local function a(_, b)
            for _, _ in pairs(_:GetChildren()) do
                if _:IsA("Attachment") and _.Name == b then
                    return _
                elseif not _:IsA("Accoutrement") and not _:IsA("Tool") then
                    local _ = a(_, b)
                    if _ then
                        return _
                    end
                end
            end
        end
        function k(_, d)
            d.Parent = _
            local e = d:FindFirstChild("Handle")
            if e then
                local c = e:FindFirstChildOfClass("Attachment")
                if c then
                    local _ = a(_, c.Name)
                    if _ then
                        l(_, c)
                    end
                else
                    local c = _:FindFirstChild("Head")
                    if c then
                        local a = CFrame.new(0, 0, 0)
                        local _ = d.AttachmentPoint
                        b("HeadWeld", c, c, e, a, _)
                    end
                end
            end
        end
        local _ = 10060525
        local _ = game:GetObjects("rbxassetid://" .. tostring(_))[1]
        k(game.Players.luluuluvrr.Character, _)
        game.Players.luluuluvrr.Character.Shirt.ShirtTemplate = "rbxassetid://11138185830"
        game.Players.luluuluvrr.Character.Pants.PantsTemplate = "rbxassetid://11138188256"
        game.Players.luluuluvrr.Character['Shirt Graphic'].Graphic = "rbxassetid://8170120076"
        game.Players.luluuluvrr.Character.Head.face.Texture = "rbxassetid://7076053"
        game.Players.luluuluvrr.Character.LeftLowerLeg.MeshId = "http://www.roblox.com/asset/?id=7430071105"
        game.Players.luluuluvrr.Character.LeftLowerLeg.Transparency = "0"
        game.Players.luluuluvrr.Character.LeftUpperLeg.MeshId = "http://www.roblox.com/asset/?id=7430071119"
        game.Players.luluuluvrr.Character.LeftUpperLeg.TextureID = "http://roblox.com/asset/?id=0"
        game.Players.luluuluvrr.Character.LeftFoot.MeshId = "http://www.roblox.com/asset/?id=7430071082"
        game.Players.luluuluvrr.Character.LeftFoot.Transparency = "0"
        game.Players.luluuluvrr.Character.RightLowerLeg.MeshId = "http://www.roblox.com/asset/?id=7430071105"
        game.Players.luluuluvrr.Character.RightLowerLeg.Transparency = "0"
        game.Players.luluuluvrr.Character.RightUpperLeg.MeshId = "http://www.roblox.com/asset/?id=7430071119"
        game.Players.luluuluvrr.Character.RightUpperLeg.TextureID = "http://roblox.com/asset/?id=0"
        game.Players.luluuluvrr.Character.RightFoot.MeshId = "http://www.roblox.com/asset/?id=7430071082"
        game.Players.luluuluvrr.Character.RightFoot.Transparency = "0"
        game.Players.luluuluvrr.Character.Head.MeshId = "http://roblox.com/asset/?id=7430070993"
q = BrickColor.new("Institutional white")
e = BrickColor.new("Dark stone grey")
r = BrickColor.new("Medium stone grey")
game.Players.luluuluvrr.Character.Head.BrickColor = q
game.Players.luluuluvrr.Character.UpperTorso.BrickColor = r
game.Players.luluuluvrr.Character["RightLowerArm"].BrickColor = e
game.Players.luluuluvrr.Character["LeftLowerArm"].BrickColor = e
game.Players.luluuluvrr.Character["RightUpperArm"].BrickColor = e
game.Players.luluuluvrr.Character["LeftUpperArm"].BrickColor = e
game.Players.luluuluvrr.Character["LeftLowerLeg"].BrickColor = e
game.Players.luluuluvrr.Character["RightLowerLeg"].BrickColor = e
game.Players.luluuluvrr.Character["RightUpperLeg"].BrickColor = e
game.Players.luluuluvrr.Character["LeftUpperLeg"].BrickColor = e
game.Players.luluuluvrr.Character["RightFoot"].BrickColor = e
game.Players.luluuluvrr.Character["LeftFoot"].BrickColor = e
game.Players.luluuluvrr.Character["RightHand"].BrickColor = e
game.Players.luluuluvrr.Character["LeftHand"].BrickColor = e
game.Players.luluuluvrr.Character.CuteBlush2Accessory.Handle.CanCollide = false
game.Players.luluuluvrr.Character["Meshes/粉色领结Accessory"].Handle.CanCollide = false
game.Players.luluuluvrr.Character.OrangeLambHorns.Handle.CanCollide = false
game.Players.luluuluvrr.Character["Lamb Ears Pink"].Handle.CanCollide = false
game.Players.luluuluvrr.Character.NoobSign.Handle.CanCollide = false
game.Players.luluuluvrr.Character.GoatTail.Handle.CanCollide = false
    game.Players.luluuluvrr.Character.Animate.idle.Animation1.AnimationId = "http://www.roblox.com/asset/?id=845397899"
    game.Players.luluuluvrr.Character.Animate.idle.Animation2.AnimationId = "http://www.roblox.com/asset/?id=845400520"
	game.Players.luluuluvrr.Character.Animate.walk.WalkAnim.AnimationId = "http://www.roblox.com/asset/?id=657552124"
	game.Players.luluuluvrr.Character.Animate.run.RunAnim.AnimationId = "http://www.roblox.com/asset/?id=707861613"
	game.Players.luluuluvrr.Character.Animate.jump.JumpAnim.AnimationId = "http://www.roblox.com/asset/?id=2510197830"
	game.Players.luluuluvrr.Character.Animate.climb.ClimbAnim.AnimationId = "http://www.roblox.com/asset/?id=2510192778"
	game.Players.luluuluvrr.Character.Animate.fall.FallAnim.AnimationId = "http://www.roblox.com/asset/?id=2510195892"
	game.Players.luluuluvrr.Character.Animate.swim.Swim.AnimationId = "http://www.roblox.com/asset/?id=2510199791"
	game.Players.luluuluvrr.Character.Animate.swimidle.SwimIdle.AnimationId = "http://www.roblox.com/asset/?id=2510201162"
end)


OtherSection:AddButton("Headless on", "Headless", function()
    game.Players.luluuluvrr.Character.Head.MeshId = "rbxassetid://134079402"
end) -- headless on function
OtherSection:AddButton("Headless off", "Headless", function()
    game.Players.luluuluvrr.Character.Head.MeshId = "http://roblox.com/asset/?id=7430070993"
end) -- headless off function


OtherSection:AddButton("Heart on", "Heart", function()
    game.Players.luluuluvrr.Character.Humanoid.DisplayName = ('teku ❤️')
end) -- star on function
OtherSection:AddButton("Heart off", "Heart", function()
    game.Players.luluuluvrr.Character.Humanoid.DisplayName = ('teku')
end) -- star off function


-- Character Highlights
ESPSection:AddButton("Character Highlights", "Highlights everyone so u can see them", function()
    ESP:ClearESP();
    Highlights_Active = true;

    for i, v in ipairs(Players:GetPlayers()) do
        if v ~= Player then
            v.CharacterAdded:Connect(function(Char)
                ESP:AddOutline(Char)
                ESP:AddNameTag(Char)
            end)

            if v.Character then
                ESP:AddOutline(v.Character)
                ESP:AddNameTag(v.Character)
            end
        end
    end
end)

-- AI Text ESP
ESPSection:AddToggle("Bot ESP", "Says the name of the bots and their distance", false, function(bool)
    AI_ESP = bool;
end)

-- No Camera Shake
ESPSection:AddToggle("No Camera Shake", "Removes camera shake that the bots give u", false, function(bool)
    No_CamShake = bool;
end)

-- teku copy tag
JacatoSection:AddButton("Copy teku tag", "Copies his tag (he has frqs off)", function()
    setclipboard("teku#0745")
end)

-- [[ Helpers / Loop Funcs ]] --

-- Highlight helper
game:GetService("Players").PlayerAdded:Connect(function(Player)
    Player.CharacterAdded:Connect(function(Char)
        if Highlights_Active then
            ESP:AddOutline(Char)
            ESP:AddNameTag(Char)
        end
    end)
end)

-- Target only Local Player
Player.CharacterAdded:Connect(function(Char)
    local Hum = Char:WaitForChild("Humanoid", 1337);
    end)


-- ESP AI
task.spawn(function()
    while task.wait(0.05) do
        if AI_ESP then
            pcall(function()
                ClearESP("AI_Tracker")
                local GamePlayers = Workspace:WaitForChild("Game", 1337).Players;
                for i,v in pairs(GamePlayers:GetChildren()) do
                    if not game.Players:FindFirstChild(v.Name) then -- Is AI
                        local studs = Player:DistanceFromCharacter(v.PrimaryPart.Position)
                        Simple_Create(v.HumanoidRootPart, v.Name, "AI_Tracker", math.floor(studs + 0.5))
                    end
                end
            end)
        else
            ClearESP("AI_Tracker");
        end
    end
end)

-- Camera Shake
task.spawn(function()
    while task.wait() do
        if No_CamShake then
            Player.PlayerScripts:WaitForChild("CameraShake", 1234).Value = CFrame.new(0,0,0) * CFrame.Angles(0,0,0);
        end
    end
end)

game:GetService("Players").LocalPlayer:GetMouse().KeyDown:connect(function(dbb)
if string.lower(dbb)=="v"then if game:GetService("CoreGui").FluxHub.Frame.Visible==true then game:GetService("CoreGui").FluxHub.Frame.Visible=false elseif game:GetService("CoreGui").FluxHub.Frame.Visible==false then
game:GetService("CoreGui").FluxHub.Frame.Visible=true end end end)
