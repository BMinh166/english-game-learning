extends Label

func play(content, color := Color.WHITE):
	self.text = content
	self.modulate = color
	print("FT_---- PLAY START ----")
	print("FT_TEXT:", content)

	await get_tree().process_frame
	print("FT_SIZE AFTER SET TEXT:", size)
	print("FT_POS BEFORE CENTER FIX:", position)

	# 👇 CĂN GIỮA TẠI ĐÂY (QUAN TRỌNG)
	position.x -= size.x / 2
	
	print("FT_POS AFTER CENTER FIX:", position)

	scale = Vector2(0.8, 0.8)

	var start_y = position.y

	print("FT_FINAL START POS:", position)

	var tween = create_tween()

	tween.tween_property(self, "scale", Vector2(1.2,1.2), 0.1)
	tween.tween_property(self, "scale", Vector2(1,1), 0.1)

	tween.parallel().tween_property(self, "position:y", start_y - 30, 0.4)
	tween.parallel().tween_property(self, "modulate:a", 0, 0.4)

	await tween.finished
	queue_free()
