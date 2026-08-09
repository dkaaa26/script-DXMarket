--========================================================--
-- THROW A COIN TEST SYSTEM
-- SERVER
--==========================================================

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local DataStoreService = game:GetService("DataStoreService")

local store = DataStoreService:GetDataStore("ThrowCoinMarketData")

------------------------------------------------------------
-- REMOTE FOLDER
------------------------------------------------------------

local folder = ReplicatedStorage:FindFirstChild("ThrowCoinTest")

if not folder then
	folder = Instance.new("Folder")
	folder.Name = "ThrowCoinTest"
	folder.Parent = ReplicatedStorage
end

local remote = folder:FindFirstChild("Action")

if not remote then
	remote = Instance.new("RemoteEvent")
	remote.Name = "Action"
	remote.Parent = folder
end

local getInventory = folder:FindFirstChild("GetInventory")

if not getInventory then
	getInventory = Instance.new("RemoteFunction")
	getInventory.Name = "GetInventory"
	getInventory.Parent = folder
end

local inventoryUpdate = folder:FindFirstChild("InventoryUpdate")

if not inventoryUpdate then
	inventoryUpdate = Instance.new("RemoteEvent")
	inventoryUpdate.Name = "InventoryUpdate"
	inventoryUpdate.Parent = folder
end

------------------------------------------------------------
-- ITEM POOL
------------------------------------------------------------

local Rarities = {
	{ Name = "Common", Weight = 40, Value = 1, Items = {"Soccer Ball", "Rubber Duck", "Alarm Clock", "Apple", "Traffic Cone"} },
	{ Name = "Uncommon", Weight = 25, Value = 5, Items = {"Chair", "Gold Bar", "Ping Pong", "TV", "Trophy"} },
	{ Name = "Rare", Weight = 15, Value = 25, Items = {"Cash Bag", "Treasure Chest", "Wheel", "Guitar", "Piggy Bank", "Magnet"} },
	{ Name = "Epic", Weight = 8, Value = 100, Items = {"Boombox", "Anchor", "Gem", "Cash Register", "Safe"} },
	{ Name = "Legendary", Weight = 4, Value = 500, Items = {"Arcade Machine", "Crown", "Fridge", "Mjolnir", "Grandfather Clock"} },
	{ Name = "Mythic", Weight = 2.5, Value = 2500, Items = {"Azure Hypercar", "Meeps", "Nuke", "Submarine", "Tank"} },
	{ Name = "Cosmic", Weight = 1.5, Value = 10000, Items = {"Crimson Racer", "Prism Shard", "Rocketship", "UFO"} },
	{ Name = "Celestial", Weight = 1, Value = 50000, Items = {"Dragon Egg", "Mona Lisa", "Sailboat"} },
	{ Name = "Eternal", Weight = 0.8, Value = 250000, Items = {"Ornithopter", "Superyacht", "Private Jet"} },
	{ Name = "Godly", Weight = 0.6, Value = 1000000, Items = {"Big Ben", "Eiffel Tower", "Pyramid"} },
	{ Name = "Primordial", Weight = 0.4, Value = 5000000, Items = {"Satellite", "Time Machine"} },
	{ Name = "Quantum", Weight = 0.3, Value = 25000000, Items = {"Quantum Cube", "Impossible Cube"} },
	{ Name = "Universal", Weight = 0.2, Value = 100000000, Items = {"Black Hole", "Singularity"} },
	{ Name = "Omniversal", Weight = 0.15, Value = 500000000, Items = {"Infinity Door", "Reality Core"} },
	{ Name = "Stellar", Weight = 0.1, Value = 2500000000, Items = {"Mars", "Moon"} },
	{ Name = "Nebular", Weight = 0.08, Value = 10000000000, Items = {"Saturn", "Jupiter"} },
	{ Name = "Beyond", Weight = 0.06, Value = 50000000000, Items = {"Reality Throne", "End of Reality"} },
	{ Name = "Solar", Weight = 0.04, Value = 250000000000, Items = {"Sun"} },
	{ Name = "Zenith", Weight = 0.03, Value = 1000000000000, Items = {"Sirius", "Spaceship"} },
	{ Name = "Supernova", Weight = 0.02, Value = 5000000000000, Items = {"Betelgeuse", "Quasar"} },
	{ Name = "Omega", Weight = 0.01, Value = 25000000000000, Items = {"Dyson Sphere"} },
	{ Name = "Galactic", Weight = 0.005, Value = 100000000000000, Items = {"Milky Way"} }
}

local Mutations = {
	{ Name = "Big", Weight = 30, Multiplier = 2 },
	{ Name = "Huge", Weight = 20, Multiplier = 5 },
	{ Name = "Rainbow", Weight = 15, Multiplier = 10 },
	{ Name = "Astral", Weight = 10, Multiplier = 50 },
	{ Name = "Divine", Weight = 5, Multiplier = 100 }
}

local function pickWeighted(list)
	local total = 0
	for _, entry in ipairs(list) do
		total += entry.Weight
	end
	local roll = math.random() * total
	for _, entry in ipairs(list) do
		roll -= entry.Weight
		if roll <= 0 then
			return entry
		end
	end
	return list[#list]
end

------------------------------------------------------------
-- UPGRADE CONFIG
------------------------------------------------------------

local UpgradeConfig = {

	Luck = {
		BasePrice = 100,
		Multiplier = 1.75
	},

	Value = {
		BasePrice = 150,
		Multiplier = 1.8
	},

	ThrowSpeed = {
		BasePrice = 200,
		Multiplier = 1.85
	}

}

------------------------------------------------------------
-- PLAYER DATA
------------------------------------------------------------

local PlayerData = {}

local function createData(player)

	PlayerData[player] = {

		Cash = 100,

		LuckLevel = 0,

		ValueLevel = 0,

		ThrowSpeedLevel = 0,

		Inventory = {},

		Favorited = {}

	}

end

local function getData(player)

	return PlayerData[player]

end

------------------------------------------------------------
-- LEADERSTATS
------------------------------------------------------------

local function createStats(player)

	local leaderstats = Instance.new("Folder")
	leaderstats.Name = "leaderstats"
	leaderstats.Parent = player

	local cash = Instance.new("IntValue")
	cash.Name = "Cash"
	cash.Value = 100
	cash.Parent = leaderstats

	local coins = Instance.new("IntValue")
	coins.Name = "Coins"
	coins.Value = 0
	coins.Parent = leaderstats

end

------------------------------------------------------------
-- SYNC
------------------------------------------------------------

local function sync(player)

	local data = getData(player)

	if not data then
		return
	end

	local stats = player:FindFirstChild("leaderstats")

	if not stats then
		return
	end

	local cash = stats:FindFirstChild("Cash")
	local coins = stats:FindFirstChild("Coins")

	if cash then
		cash.Value = math.floor(data.Cash)
	end

	local total = 0

	for _, amount in pairs(data.Inventory) do
		total += amount
	end

	if coins then
		coins.Value = total
	end

end

------------------------------------------------------------
-- PUSH INVENTORY
------------------------------------------------------------

local function pushInventory(player)

	local data = getData(player)

	if not data then
		return
	end

	inventoryUpdate:FireClient(player, data.Inventory)

end

------------------------------------------------------------
-- THROW COIN
------------------------------------------------------------

local function throwCoin(player)

	local data = getData(player)

	if not data then
		return
	end

	local rarity = pickWeighted(Rarities)

	local itemName = rarity.Items[math.random(1, #rarity.Items)]

	local fullName = itemName
	local value = rarity.Value

	if math.random() < 0.15 then

		local mutation = pickWeighted(Mutations)

		fullName = mutation.Name .. " " .. itemName

		value *= mutation.Multiplier

	end

	local luckMultiplier =
		1 + (data.LuckLevel * 0.25)

	local valueMultiplier =
		1 + (data.ValueLevel * 0.20)

	local reward = value

	local chance = math.random(1, 100)

	if chance <= (5 + data.LuckLevel) then
		reward *= 2
	end

	reward *= luckMultiplier
	reward *= valueMultiplier

	reward = math.max(1, math.floor(reward))

	data.Inventory[fullName] =
		(data.Inventory[fullName] or 0) + reward

	sync(player)

	pushInventory(player)

end

------------------------------------------------------------
-- SELL ALL
------------------------------------------------------------

local function sellAll(player)

	local data = getData(player)

	if not data then
		return
	end

	local total = 0

	for itemName, amount in pairs(data.Inventory) do

		if not data.Favorited[itemName] then

			total += amount

			data.Inventory[itemName] = 0

		end

	end

	data.Cash += total

	sync(player)

	pushInventory(player)

end

------------------------------------------------------------
-- DUPLICATE ITEM
------------------------------------------------------------

local function duplicateItem(player, itemName)

	local data = getData(player)

	if not data then
		return
	end

	if typeof(itemName) ~= "string" then
		return
	end

	if not data.Inventory[itemName] then
		return
	end

	data.Inventory[itemName] += 1

	sync(player)

	pushInventory(player)

end

------------------------------------------------------------
-- UPGRADE PRICE
------------------------------------------------------------

local function upgradePrice(base, level, multiplier)

	return math.floor(
		base * (multiplier ^ level)
	)

end

------------------------------------------------------------
-- LUCK
------------------------------------------------------------

local function upgradeLuck(player)

	local data = getData(player)

	if not data then
		return
	end

	local price = upgradePrice(
		UpgradeConfig.Luck.BasePrice,
		data.LuckLevel,
		UpgradeConfig.Luck.Multiplier
	)

	if data.Cash < price then
		return
	end

	data.Cash -= price

	data.LuckLevel += 1

	sync(player)

end

------------------------------------------------------------
-- VALUE
------------------------------------------------------------

local function upgradeValue(player)

	local data = getData(player)

	if not data then
		return
	end

	local price = upgradePrice(
		UpgradeConfig.Value.BasePrice,
		data.ValueLevel,
		UpgradeConfig.Value.Multiplier
	)

	if data.Cash < price then
		return
	end

	data.Cash -= price

	data.ValueLevel += 1

	sync(player)

end

------------------------------------------------------------
-- THROW SPEED
------------------------------------------------------------

local function upgradeThrowSpeed(player)

	local data = getData(player)

	if not data then
		return
	end

	local price = upgradePrice(
		UpgradeConfig.ThrowSpeed.BasePrice,
		data.ThrowSpeedLevel,
		UpgradeConfig.ThrowSpeed.Multiplier
	)

	if data.Cash < price then
		return
	end

	data.Cash -= price

	data.ThrowSpeedLevel += 1

	sync(player)

end

------------------------------------------------------------
-- REMOTE
------------------------------------------------------------

remote.OnServerEvent:Connect(function(player, action, itemName)

	if typeof(action) ~= "string" then
		return
	end

	if action == "ThrowCoin" then

		throwCoin(player)

	elseif action == "SellAll" then

		sellAll(player)

	elseif action == "Duplicate" then

		duplicateItem(player, itemName)

	elseif action == "UpgradeLuck" then

		upgradeLuck(player)

	elseif action == "UpgradeValue" then

		upgradeValue(player)

	elseif action == "UpgradeThrowSpeed" then

		upgradeThrowSpeed(player)

	end

end)

getInventory.OnServerInvoke = function(player)

	local data = getData(player)

	if not data then
		return {}
	end

	return data.Inventory

end

------------------------------------------------------------
-- SAVE / LOAD
------------------------------------------------------------

local function loadData(player)

	local key = "SavePlayer_" .. player.UserId

	local success, data = pcall(function()
		return store:GetAsync(key)
	end)

	if success and data then

		PlayerData[player] = data

	else

		createData(player)

	end

end

local function saveData(player)

	local data = PlayerData[player]

	if not data then
		return
	end

	local key = "SavePlayer_" .. player.UserId

	pcall(function()
		store:SetAsync(key, data)
	end)

end

------------------------------------------------------------
-- PLAYERS
------------------------------------------------------------

Players.PlayerAdded:Connect(function(player)

	loadData(player)

	createStats(player)

end)

Players.PlayerRemoving:Connect(function(player)

	saveData(player)

	PlayerData[player] = nil

end)

game:BindToClose(function()

	for _, player in ipairs(Players:GetPlayers()) do
		saveData(player)
	end

end)

task.spawn(function()

	while true do

		task.wait(60)

		for _, player in ipairs(Players:GetPlayers()) do
			saveData(player)
		end

	end

end)

for _, player in ipairs(Players:GetPlayers()) do

	loadData(player)

	createStats(player)

end
