class_name InputHandler
extends Node

signal bar_selected(player: int, bar_index: int)
signal bar_input(player: int, rotation_delta: float, slide_delta: float)
signal bar_released(player: int)

var active_bar_index: int = 0
var is_mouse_held: bool = false
var mouse_sensitivity_rotation: float = 0.005
var mouse_sensitivity_slide: float = 0.0003


func _ready() -> void:
	active_bar_index = 0
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED


func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventKey and event.pressed:
		match event.keycode:
			KEY_1:
				active_bar_index = 0
				bar_selected.emit(Constants.PLAYER_1, 0)
			KEY_2:
				active_bar_index = 1
				bar_selected.emit(Constants.PLAYER_1, 1)
			KEY_3:
				active_bar_index = 2
				bar_selected.emit(Constants.PLAYER_1, 2)
			KEY_4:
				active_bar_index = 3
				bar_selected.emit(Constants.PLAYER_1, 3)
			KEY_ESCAPE:
				Input.mouse_mode = Input.MOUSE_MODE_VISIBLE

	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT:
			if Input.mouse_mode == Input.MOUSE_MODE_VISIBLE and event.pressed:
				Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
			else:
				is_mouse_held = event.pressed
				if not event.pressed:
					bar_released.emit(Constants.PLAYER_1)

	if event is InputEventMouseMotion:
		var slide_delta: float = event.relative.y * mouse_sensitivity_slide
		var rot_delta: float = 0.0
		if is_mouse_held:
			rot_delta = event.relative.x * mouse_sensitivity_rotation
		bar_input.emit(Constants.PLAYER_1, rot_delta, slide_delta)
