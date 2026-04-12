extends Control

@export var bag_popup_scene: PackedScene

var popup = null

func _ready():
	GameManager.connect("update_state_ui", _on_game_update)
	
func _on_game_update(_state):
	if popup != null and is_instance_valid(popup):
		popup.show_cards(GameManager.bag)


func _on_button_pressed() -> void:
	print("BAG PRESSED")
	if popup == null or !is_instance_valid(popup):
		popup = bag_popup_scene.instantiate()
		get_tree().current_scene.add_child(popup)
		popup.setup(GameManager.bag)

		popup.closed.connect(func():
			popup = null
		)
