extends Node

var gold = 10000

var items = {
	0: {
		"Name": "Apple",
		"Des": "This is an apple!",
		"Cost": 10,
		"Type": "Miscs",
		"Icon": preload("res://Assets/Items/184_Elite_Apple.png")
	},
	1: {
		"Name": "Wooden Sword",
		"Des": "This is an apple!",
		"Cost": 100,
		"Type": "RightHand",
		"Icon": preload("res://Assets/Items/Wooden_Weapon1.png")
	},
}

var inventory = {
	0: {
		"Name": "Wooden Sword",
		"Des": "This is an apple!",
		"Cost": 100,
		"Type": "RightHand",
		"Count": 1,
		"Icon": preload("res://Assets/Items/Wooden_Weapon1.png")
	},
}
var Equiped = {
	"RightHand": {},
}

func equipItem(itemName):
	var hasItem = false
	var invSlot = 0
	for i in inventory:
		if inventory[i]["Name"] == itemName:
			invSlot = i
	var slotType = inventory[invSlot]["Type"]
	Equiped[str(slotType)] = inventory[invSlot]
	

func addItem(itemName):
	var hasItem = false
	var invSlot = 0
	for i in items:
		if items[i]["Name"] == itemName:
			invSlot = i
	for i in inventory:
		if inventory[i]["Name"] == items[invSlot]["Name"]:
			inventory[i]["Count"] += 1
			hasItem = true
	if hasItem == false:
		var tempDic = items[invSlot]
		tempDic["Count"] = 1
		inventory[inventory.size()] = tempDic

