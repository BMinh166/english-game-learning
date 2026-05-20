extends Control

var pause_menu = null


func _ready():

	# chỉ khi mở từ pause mới cần process lúc paused
	if get_tree().paused:
		process_mode = Node.PROCESS_MODE_WHEN_PAUSED


func _on_back_button_pressed() -> void:

	print("PREVIOUS:", GameManager.previous_scene_path)

	# =====================
	# OPENED FROM PAUSE
	# =====================

	if pause_menu != null:

		pause_menu.show()

		queue_free()

		return

	# =====================
	# OPENED FROM MAIN MENU
	# =====================

	if GameManager.previous_scene_path != "":

		get_tree().change_scene_to_file(
			GameManager.previous_scene_path
		)
