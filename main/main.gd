extends Node3D

'''
@onready var world: Node = $World
@onready var player: Node3D = $Player
'''
var current_level: Level

func _ready() -> void:
	# Start the game on the first level
	switch_to_level("test_1")
	
func teleport_player_to_spawn():
	var spawn = current_level.get_spawn_point()
	if spawn:
		var player = %Player
		if player and player.has_method("teleport_to_spawn"):
			player.teleport_to_spawn(spawn.global_transform.origin)
			print("spawned at: %s %s" % [spawn.name, spawn.position])

func switch_to_level(level_id: String, delete: bool = true, keep_running: bool = false):
	if level_id not in LevelRegistry.levels:
		print("level not in registry")
		return
	#elif level_id == "":
	#	LevelRegistry.get_scene(current_level.id)
	if current_level:
		if delete:
			current_level.queue_free()
		elif keep_running:
			current_level.visible = false
		else:
			remove_child(current_level)
	current_level = Level.new()
	current_level.initialize(level_id)
	add_child(current_level)
	print("Current level: %s" % current_level.id)

	await get_tree().process_frame  # Wait for children
	teleport_player_to_spawn()

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("dev_quit"):
		get_tree().quit()
	if event.is_action_pressed("dev_respawn"):
		teleport_player_to_spawn()
	if event.is_action_pressed("dev_switch_level"):
		switch_to_level("test_2")
