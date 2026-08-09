local Players = game:GetService("Players")
local UIS = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local player = Players.LocalPlayer

local folder = ReplicatedStorage:WaitForChild("ThrowCoinTest")
local remote = folder:WaitForChild("Action")
local getInventory = folder:WaitForChild("GetInventory")
local inventoryUpdate = folder:WaitForChild("InventoryUpdate")

local Enabled = {
	ThrowCoin = false,
	SellAll = false,
	UpgradeLuck = false,
	UpgradeValue = false,
	UpgradeThrowSpeed = false,
	Speed = false
}

local Delay = {
	ThrowCoin = 0.2,
	SellAll = 3,
	UpgradeLuck = 1,
	UpgradeValue = 1,
	UpgradeThrowSpeed = 1
}

local Multiplier = {
	ThrowCoin = 1
}
local gui = Instance.new("ScreenGui")

gui.Name = "DXMarket"
gui.ResetOnSpawn = false
gui.IgnoreGuiInset = true
gui.Parent = player:WaitForChild("PlayerGui")

local cyan = Color3.fromRGB(0, 220, 255)
local blue = Color3.fromRGB(55, 100, 255)
local purple = Color3.fromRGB(150, 60, 255)
local dark = Color3.fromRGB(10, 12, 20)
local card = Color3.fromRGB(22, 27, 40)
local white = Color3.fromRGB(245, 248, 255)
local gray = Color3.fromRGB(140, 150, 170)

--------------------------------------------------
-- FLOATING LOGO
--------------------------------------------------

local logo = Instance.new("TextButton")
logo.Size = UDim2.fromOffset(72,72)
logo.Position = UDim2.new(0,25,0.5,-36)
logo.BackgroundColor3 = dark
logo.Text = ""
logo.AutoButtonColor = false
logo.Parent = gui

local lc = Instance.new("UICorner")
lc.CornerRadius = UDim.new(0,18)
lc.Parent = logo

local ls = Instance.new("UIStroke")
ls.Thickness = 3
ls.Color = cyan
ls.Parent = logo

local lg = Instance.new("UIGradient")
lg.Color = ColorSequence.new({
	ColorSequenceKeypoint.new(0,Color3.fromRGB(0,90,130)),
	ColorSequenceKeypoint.new(0.5,Color3.fromRGB(30,30,80)),
	ColorSequenceKeypoint.new(1,Color3.fromRGB(90,25,100))
})
lg.Rotation = 45
lg.Parent = logo

local dx = Instance.new("TextLabel")
dx.Size = UDim2.new(1,0,0.6,0)
dx.BackgroundTransparency = 1
dx.Text = "DX"
dx.TextColor3 = white
dx.TextSize = 26
dx.Font = Enum.Font.GothamBlack
dx.Parent = logo

local market = Instance.new("TextLabel")
market.Size = UDim2.new(1,0,0.25,0)
market.Position = UDim2.new(0,0,0.62,0)
market.BackgroundTransparency = 1
market.Text = "MARKET"
market.TextColor3 = cyan
market.TextSize = 8
market.Font = Enum.Font.GothamBold
market.Parent = logo

--------------------------------------------------
-- MAIN PANEL
--------------------------------------------------

local panel = Instance.new("Frame")
panel.Size = UDim2.fromOffset(455,610)
panel.Position = UDim2.new(0,105,0.5,-305)
panel.BackgroundColor3 = dark
panel.Visible = false
panel.Parent = gui

local pc = Instance.new("UICorner")
pc.CornerRadius = UDim.new(0,16)
pc.Parent = panel

local ps = Instance.new("UIStroke")
ps.Thickness = 2
ps.Color = Color3.fromRGB(40,70,110)
ps.Parent = panel

local pg = Instance.new("UIGradient")
pg.Color = ColorSequence.new({
	ColorSequenceKeypoint.new(0,Color3.fromRGB(8,25,45)),
	ColorSequenceKeypoint.new(0.5,Color3.fromRGB(12,12,25)),
	ColorSequenceKeypoint.new(1,Color3.fromRGB(35,10,45))
})
pg.Rotation = 135
pg.Parent = panel

--------------------------------------------------
-- HEADER
--------------------------------------------------

local header = Instance.new("Frame")
header.Size = UDim2.new(1,0,0,82)
header.BackgroundColor3 = Color3.fromRGB(15,20,35)
header.Parent = panel

local hc = Instance.new("UICorner")
hc.CornerRadius = UDim.new(0,16)
hc.Parent = header

local hg = Instance.new("UIGradient")
hg.Color = ColorSequence.new({
	ColorSequenceKeypoint.new(0,Color3.fromRGB(0,70,100)),
	ColorSequenceKeypoint.new(0.5,Color3.fromRGB(25,25,65)),
	ColorSequenceKeypoint.new(1,Color3.fromRGB(75,15,90))
})
hg.Rotation = 20
hg.Parent = header

local title = Instance.new("TextLabel")
title.Size = UDim2.new(1,-120,0,35)
title.Position = UDim2.fromOffset(20,8)
title.BackgroundTransparency = 1
title.Text = "DXMarket"
title.TextColor3 = white
title.TextSize = 24
title.Font = Enum.Font.GothamBlack
title.TextXAlignment = Enum.TextXAlignment.Left
title.Parent = header


local sub = Instance.new("TextLabel")
sub.Size = UDim2.new(1,-120,0,20)
sub.Position = UDim2.fromOffset(22,45)
sub.BackgroundTransparency = 1
sub.Text = "AUTOMATION MODULE"
sub.TextColor3 = cyan
sub.TextSize = 9
sub.Font = Enum.Font.GothamBold
sub.TextXAlignment = Enum.TextXAlignment.Left
sub.Parent = header

local ver = Instance.new("TextLabel")
ver.Size = UDim2.fromOffset(58,25)
ver.Position = UDim2.new(1,-75,0,15)
ver.BackgroundColor3 = Color3.fromRGB(10,35,50)
ver.Text = "V1.0"
ver.TextColor3 = cyan
ver.TextSize = 10
ver.Font = Enum.Font.GothamBold
ver.Parent = header

local vc = Instance.new("UICorner")
vc.CornerRadius = UDim.new(0,7)
vc.Parent = ver

--------------------------------------------------
-- CLOSE
--------------------------------------------------

local close = Instance.new("TextButton")
close.Size = UDim2.fromOffset(35,35)
close.Position = UDim2.new(1,-45,0,45)
close.BackgroundColor3 = Color3.fromRGB(45,25,50)
close.Text = "×"
close.TextColor3 = white
close.TextSize = 23
close.Font = Enum.Font.GothamBold
close.Parent = header

local cc = Instance.new("UICorner")
cc.CornerRadius = UDim.new(0,8)
cc.Parent = close

close.MouseButton1Click:Connect(function()
	panel.Visible = false
end)

--------------------------------------------------
-- SCROLL
--------------------------------------------------

local scroll = Instance.new("ScrollingFrame")
scroll.Size = UDim2.new(1,-20,1,-95)
scroll.Position = UDim2.fromOffset(10,90)
scroll.BackgroundTransparency = 1
scroll.BorderSizePixel = 0
scroll.ScrollBarThickness = 8
scroll.ScrollBarImageColor3 = cyan
scroll.CanvasSize = UDim2.fromOffset(0,0)
scroll.Parent = panel

local layout = Instance.new("UIListLayout")
layout.Padding = UDim.new(0,8)
layout.Parent = scroll

layout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
	scroll.CanvasSize = UDim2.fromOffset(
		0,
		layout.AbsoluteContentSize.Y + 15
	)
end)

--------------------------------------------------
-- SECTION
--------------------------------------------------

local function section(text)

	local s = Instance.new("TextLabel")
	s.Size = UDim2.new(1,-10,0,30)
	s.BackgroundTransparency = 1
	s.Text = "  " .. text
	s.TextColor3 = cyan
	s.TextSize = 12
	s.Font = Enum.Font.GothamBlack
	s.TextXAlignment = Enum.TextXAlignment.Left
	s.Parent = scroll

end

--------------------------------------------------
-- FEATURE CARD
--------------------------------------------------

local function feature(name,description,action,multipliers)

	local c = Instance.new("Frame")
	c.Size = UDim2.new(1,-5,0, multipliers and 100 or 72)
	c.BackgroundColor3 = card
	c.Parent = scroll

	local corner = Instance.new("UICorner")
	corner.CornerRadius = UDim.new(0,10)
	corner.Parent = c

	local stroke = Instance.new("UIStroke")
	stroke.Color = Color3.fromRGB(45,60,90)
	stroke.Parent = c

	local accent = Instance.new("Frame")
	accent.Size = UDim2.new(0,4,1,-20)
	accent.Position = UDim2.fromOffset(10,10)
	accent.BackgroundColor3 = cyan
	accent.Parent = c

	local ac = Instance.new("UICorner")
	ac.CornerRadius = UDim.new(1,0)
	ac.Parent = accent

	local n = Instance.new("TextLabel")
	n.Size = UDim2.new(1,-95,0,26)
	n.Position = UDim2.fromOffset(22,8)
	n.BackgroundTransparency = 1
	n.Text = name
	n.TextColor3 = white
	n.TextSize = 13
	n.Font = Enum.Font.GothamBold
	n.TextXAlignment = Enum.TextXAlignment.Left
	n.Parent = c

	local d = Instance.new("TextLabel")
	d.Size = UDim2.new(1,-95,0,20)
	d.Position = UDim2.fromOffset(22,36)
	d.BackgroundTransparency = 1
	d.Text = description
	d.TextColor3 = gray
	d.TextSize = 10
	d.Font = Enum.Font.Gotham
	d.TextXAlignment = Enum.TextXAlignment.Left
	d.Parent = c

	local toggle = Instance.new("TextButton")
	toggle.Size = UDim2.fromOffset(52,28)
	toggle.Position = UDim2.new(1,-67,0.5,-14)
	toggle.BackgroundColor3 = Color3.fromRGB(40,45,60)
	toggle.Text = ""
	toggle.AutoButtonColor = false
	toggle.Parent = c

	local tc = Instance.new("UICorner")
	tc.CornerRadius = UDim.new(1,0)
	tc.Parent = toggle

	local knob = Instance.new("Frame")
	knob.Size = UDim2.fromOffset(20,20)
	knob.Position = UDim2.fromOffset(4,4)
	knob.BackgroundColor3 = gray
	knob.Parent = toggle

	local kc = Instance.new("UICorner")
	kc.CornerRadius = UDim.new(1,0)
	kc.Parent = knob

	local state = false

	toggle.MouseButton1Click:Connect(function()

		state = not state

		if action then
			Enabled[action] = state
		end

		if state then

			TweenService:Create(
				toggle,
				TweenInfo.new(.2),
				{BackgroundColor3 = cyan}
			):Play()

			TweenService:Create(
				knob,
				TweenInfo.new(.2),
				{
					Position = UDim2.new(1,-24,0,4),
					BackgroundColor3 = white
				}
			):Play()

		else

			TweenService:Create(
				toggle,
				TweenInfo.new(.2),
				{BackgroundColor3 = Color3.fromRGB(40,45,60)}
			):Play()

			TweenService:Create(
				knob,
				TweenInfo.new(.2),
				{
					Position = UDim2.fromOffset(4,4),
					BackgroundColor3 = gray
				}
			):Play()

		end

	end)

	if multipliers then

		Multiplier[action] = multipliers[1]

		local row = Instance.new("Frame")
		row.Size = UDim2.new(1,-90,0,22)
		row.Position = UDim2.fromOffset(22,68)
		row.BackgroundTransparency = 1
		row.Parent = c

		local rowLayout = Instance.new("UIListLayout")
		rowLayout.FillDirection = Enum.FillDirection.Horizontal
		rowLayout.Padding = UDim.new(0,4)
		rowLayout.SortOrder = Enum.SortOrder.LayoutOrder
		rowLayout.Parent = row

		local function refresh()
			for _, child in row:GetChildren() do
				if child:IsA("TextButton") then
					local m = tonumber(child.Name:sub(2))
					if m == Multiplier[action] then
						child.BackgroundColor3 = cyan
						child.TextColor3 = white
					else
						child.BackgroundColor3 = Color3.fromRGB(30,45,60)
						child.TextColor3 = gray
					end
				end
			end
		end

		for i, mult in ipairs(multipliers) do
			local b = Instance.new("TextButton")
			b.Name = "x" .. mult
			b.Size = UDim2.fromOffset(34,20)
			b.BackgroundColor3 = Color3.fromRGB(30,45,60)
			b.Text = "x" .. mult
			b.TextColor3 = gray
			b.TextSize = 10
			b.Font = Enum.Font.GothamBold
			b.AutoButtonColor = false
			b.LayoutOrder = i
			b.Parent = row

			local bc = Instance.new("UICorner")
			bc.CornerRadius = UDim.new(0,5)
			bc.Parent = b

			b.MouseButton1Click:Connect(function()
				Multiplier[action] = mult
				refresh()
			end)
		end

		refresh()

	end

end

--------------------------------------------------
-- INVENTORY
--------------------------------------------------

local getInventory = folder:WaitForChild("GetInventory")
local inventoryUpdate = folder:WaitForChild("InventoryUpdate")

section("INVENTORY")

local inventoryHolder = Instance.new("Frame")
inventoryHolder.Size = UDim2.new(1,-5,0,0)
inventoryHolder.BackgroundTransparency = 1
inventoryHolder.Parent = scroll

local inventoryLayout = Instance.new("UIListLayout")
inventoryLayout.Padding = UDim.new(0,6)
inventoryLayout.Parent = inventoryHolder

local selectedItem = nil

local dupeBtn = Instance.new("TextButton")
dupeBtn.Size = UDim2.new(1,-20,0,50)
dupeBtn.BackgroundColor3 = Color3.fromRGB(30,60,90)
dupeBtn.Text = "SELECT AN ITEM"
dupeBtn.TextColor3 = white
dupeBtn.TextSize = 13
dupeBtn.Font = Enum.Font.GothamBlack
dupeBtn.Parent = scroll

local dupec = Instance.new("UICorner")
dupec.CornerRadius = UDim.new(0,8)
dupec.Parent = dupeBtn

local function refreshInventory(data)

	for _, child in inventoryHolder:GetChildren() do
		if child:IsA("TextButton") then
			child:Destroy()
		end
	end

	local names = {}
	for name in pairs(data) do
		table.insert(names, name)
	end
	table.sort(names)

	for _, name in ipairs(names) do

		local count = data[name]

		local itemCard = Instance.new("TextButton")
		itemCard.Size = UDim2.new(1,0,0,46)
		itemCard.BackgroundColor3 = card
		itemCard.Text = ""
		itemCard.AutoButtonColor = false
		itemCard.Parent = inventoryHolder

		local corner = Instance.new("UICorner")
		corner.CornerRadius = UDim.new(0,8)
		corner.Parent = itemCard

		local stroke = Instance.new("UIStroke")
		stroke.Color = Color3.fromRGB(40,55,80)
		stroke.Parent = itemCard

		local n = Instance.new("TextLabel")
		n.Size = UDim2.new(1,-40,0,46)
		n.Position = UDim2.fromOffset(12,0)
		n.BackgroundTransparency = 1
		n.Text = name
		n.TextColor3 = white
		n.TextSize = 12
		n.Font = Enum.Font.GothamBold
		n.TextXAlignment = Enum.TextXAlignment.Left
		n.Parent = itemCard

		local c = Instance.new("TextLabel")
		c.Size = UDim2.fromOffset(60,46)
		c.Position = UDim2.new(1,-70,0,0)
		c.BackgroundTransparency = 1
		c.Text = "x" .. tostring(count)
		c.TextColor3 = cyan
		c.TextSize = 13
		c.Font = Enum.Font.GothamBlack
		c.Parent = itemCard

		itemCard.MouseButton1Click:Connect(function()
			selectedItem = name
			for _, item in inventoryHolder:GetChildren() do
				if item:IsA("TextButton") then
					item.BackgroundColor3 = card
				end
			end
			itemCard.BackgroundColor3 = cyan
			dupeBtn.Text = "DUPE: " .. name
		end)

	end

	-- re-apply selection highlight after refresh
	for _, item in inventoryHolder:GetChildren() do
		if item:IsA("TextButton") then
			local lbl = item:FindFirstChildOfClass("TextLabel")
			if lbl and lbl.Text == selectedItem then
				item.BackgroundColor3 = cyan
			end
		end
	end

	if selectedItem then
		dupeBtn.Text = "DUPE: " .. selectedItem
	end

end

dupeBtn.MouseButton1Click:Connect(function()
	if selectedItem then
		remote:FireServer("Duplicate", selectedItem)
	end
end)

local pendingUpdate = nil
local refreshRunning = false

local function queueRefresh(data)
	pendingUpdate = data
	if refreshRunning then
		return
	end
	refreshRunning = true
	task.spawn(function()
		while pendingUpdate do
			local d = pendingUpdate
			pendingUpdate = nil
			refreshInventory(d)
			task.wait(0.4)
		end
		refreshRunning = false
	end)
end

inventoryUpdate.OnClientEvent:Connect(function(data)
	if data then
		queueRefresh(data)
	end
end)

task.spawn(function()
	local ok, data = pcall(function()
		return getInventory:InvokeServer()
	end)
	if ok and data then
		queueRefresh(data)
	end
end)

--------------------------------------------------
-- FEATURES
--------------------------------------------------

section("AUTOFARM")

feature(
	"Auto Throw Coin",
	"Throws coins automatically",
	"ThrowCoin",
	{2, 3, 4, 5}
)

feature(
	"Auto Sell All",
	"Sells all items for cash",
	"SellAll"
)

feature(
	"Auto Upgrade Luck",
	"Raises your luck level",
	"UpgradeLuck"
)

feature(
	"Auto Upgrade Value",
	"Boosts item value level",
	"UpgradeValue"
)

feature(
	"Auto Upgrade Throw Speed",
	"Speeds up coin throwing",
	"UpgradeThrowSpeed"
)



section("MOVEMENT")

feature(
	"Speed Boost",
	"Adjust your movement speed",
	"Speed"
)

--------------------------------------------------
-- SPEED INPUT
--------------------------------------------------

local speed = Instance.new("TextBox")
speed.Size = UDim2.new(1,-20,0,42)
speed.BackgroundColor3 = Color3.fromRGB(15,18,28)
speed.Text = "50"
speed.TextColor3 = white
speed.TextSize = 14
speed.Font = Enum.Font.GothamBold
speed.ClearTextOnFocus = false
speed.Parent = scroll

local sc = Instance.new("UICorner")
sc.CornerRadius = UDim.new(0,8)
sc.Parent = speed

--------------------------------------------------


--------------------------------------------------
-- AUTOMATION
--------------------------------------------------

task.spawn(function()
	while true do
		if Enabled.ThrowCoin then
			remote:FireServer("ThrowCoin")
		end
		local mult = Multiplier.ThrowCoin or 1
		task.wait(Delay.ThrowCoin / mult)
	end
end)

task.spawn(function()
	while true do
		if Enabled.SellAll then
			remote:FireServer("SellAll")
		end
		task.wait(Delay.SellAll)
	end
end)

task.spawn(function()
	while true do
		if Enabled.UpgradeLuck then
			remote:FireServer("UpgradeLuck")
		end
		task.wait(Delay.UpgradeLuck)
	end
end)

task.spawn(function()
	while true do
		if Enabled.UpgradeValue then
			remote:FireServer("UpgradeValue")
		end
		task.wait(Delay.UpgradeValue)
	end
end)

task.spawn(function()
	while true do
		if Enabled.UpgradeThrowSpeed then
			remote:FireServer("UpgradeThrowSpeed")
		end
		task.wait(Delay.UpgradeThrowSpeed)
	end
end)



--------------------------------------------------
-- SPEED CONTROL
--------------------------------------------------

local defaultWalkSpeed = 16

local function applySpeed()
	local char = player.Character
	local humanoid = char and char:FindFirstChildOfClass("Humanoid")
	if not humanoid then
		return
	end
	if Enabled.Speed then
		local val = tonumber(speed.Text) or defaultWalkSpeed
		humanoid.WalkSpeed = math.clamp(val, 1, 500)
	else
		humanoid.WalkSpeed = defaultWalkSpeed
	end
end

task.spawn(function()
	while true do
		applySpeed()
		task.wait(0.5)
	end
end)

player.CharacterAdded:Connect(function()
	task.wait(0.5)
	applySpeed()
end)

--------------------------------------------------
-- OPEN
--------------------------------------------------

logo.MouseButton1Click:Connect(function()

	panel.Visible = not panel.Visible

end)

--------------------------------------------------
-- DRAG LOGO
--------------------------------------------------

local dragging = false
local dragStart
local startPos

logo.InputBegan:Connect(function(input)

	if input.UserInputType == Enum.UserInputType.MouseButton1 then

		dragging = true
		dragStart = input.Position
		startPos = logo.Position

	end

end)

UIS.InputChanged:Connect(function(input)

	if not dragging then 
		return
	end

	if input.UserInputType ~= Enum.UserInputType.MouseMovement then
		return
	end

	local delta = input.Position - dragStart

	logo.Position = UDim2.new(
		startPos.X.Scale,
		startPos.X.Offset + delta.X,
		startPos.Y.Scale,
		startPos.Y.Offset + delta.Y
	)

end)

UIS.InputEnded:Connect(function(input)

	if input.UserInputType == Enum.UserInputType.MouseButton1 then
		dragging = false
	end

end)