class_name InventorySlot
extends PanelContainer


@export var type: ItemData.Type

# Custom init function so that it doesn't error
func init(t: ItemData.Type, cms: Vector2) -> void:
	type = t
	custom_minimum_size = cms


# _at_position is not used because it doesn't matter where on the panel
# the item is dropped
func _can_drop_data(_at_position: Vector2, data: Variant) -> bool:
	if data is InventoryItem:
		if type == ItemData.Type.MAIN:
			if get_child_count() == 0:
				return true
			else:
				if type == data.get_parent().type:
					return true
				return get_child(0).data.type == data.data.type
		else:
			return data.data.type == type
	return false


# _at_position is not used because it doesn't matter where on the panel
# the item is dropped
func _drop_data(_at_position: Vector2, data: Variant) -> void:
	if get_child_count() > 0:
		var item := get_child(0)
		#remove current item equiped stats
		Game.player_damage -= item.data.item_damage
		Game.player_defense -= item.data.item_defense
		if item == data:
			return
		item.reparent(data.get_parent())
	#add new item equiped stats
	if type != ItemData.Type.MAIN:
		Game.player_damage += data.data.item_damage
		Game.player_defense += data.data.item_defense
	else:
		#taking item out of equip into inventory
		Game.player_damage -= data.data.item_damage
		Game.player_defense -= data.data.item_defense
	data.reparent(self)
