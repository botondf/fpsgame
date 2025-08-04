extends Node3D

func _ready():
	pass

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("dev_quit"):
		get_tree().quit()
