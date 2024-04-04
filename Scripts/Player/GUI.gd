extends CanvasLayer

func _ready():
	$Container.visible = get_tree().paused
	get_node("hp_bar").max_value = Game.player_health
	$Container/Profile.hide()
	$Container/Quests.hide()
	
func _physics_process(delta):
	if Input.is_action_just_pressed("Pause") and (Game.CutSceneCurrent == false):
		get_tree().paused = !get_tree().paused
		$Container.visible = get_tree().paused
	get_node("hp_bar").value = Game.player_health

func _on_inventory_button_pressed():
	$Container/VBoxContainer/InventoryButton.disabled = true
	$Container/VBoxContainer/QuestButton.disabled = false
	$Container/VBoxContainer/Profile.disabled = false
	$Container/Inventory.show()
	$Container/Profile.hide()
	$Container/Quests.hide()

func _on_quest_button_pressed():
	$Container/VBoxContainer/InventoryButton.disabled = false
	$Container/VBoxContainer/QuestButton.disabled = true
	$Container/VBoxContainer/Profile.disabled = false
	$Container/Inventory.hide()
	$Container/Profile.hide()
	$Container/Quests.show()


func _on_profile_pressed():
	$Container/VBoxContainer/InventoryButton.disabled = false
	$Container/VBoxContainer/QuestButton.disabled = false
	$Container/VBoxContainer/Profile.disabled = true
	$Container/Inventory.hide()
	$Container/Profile.show()
	$Container/Quests.hide()
