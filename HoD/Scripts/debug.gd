extends Node


func _unhandled_key_input(event: InputEvent) -> void:
	var key_event: InputEventKey = event
	if event.is_pressed():
		var key: int = key_event.keycode
		match key:
			KEY_R:
				get_tree().reload_current_scene()
			KEY_Q:
				get_tree().quit()
			KEY_F11:
				var is_fs: bool = DisplayServer.window_get_mode() == DisplayServer.WINDOW_MODE_FULLSCREEN
				var target_mode: int = DisplayServer.WINDOW_MODE_WINDOWED if is_fs else DisplayServer.WINDOW_MODE_FULLSCREEN 
				DisplayServer.window_set_mode(target_mode)
				
