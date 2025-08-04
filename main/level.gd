class_name Level
extends Node3D


@export var level_name: String ## Text displayed in the transition mananager.

var id: String
var scene_instance: Node3D
var spawn_points: Dictionary = {}


""" the init function was working but causing errors
func _init(level_id: String) -> void:
	if level_id.is_empty():
		push_error("Level ID cannot be empty")
		return
	
	id = level_id
	var scene = LevelRegistry.get_scene(level_id)
	if scene:
		scene_instance = scene.instantiate()
		add_child(scene_instance)
		
		_collect_spawn_points()
	else:
		push_error("Scene for '%s' not found in registry" % level_id)
		"""

func initialize(level_id: String) -> void:
	if level_id.is_empty():
		push_error("Level ID cannot be empty")
		return
	
	id = level_id
	var scene = LevelRegistry.get_scene(level_id)
	if scene:
		scene_instance = scene.instantiate()
		add_child(scene_instance)
		_collect_spawn_points()
	else:
		push_error("Scene for '%s' not found in registry" % level_id)

func _collect_spawn_points() -> void:
	var container := scene_instance.get_node_or_null("SpawnPoints")
	if container:
		for child in container.get_children():
			if child is Node3D:
				spawn_points[child.name] = child
	else:
		push_warning("No 'SpawnPoints' node found in scene.")

func get_spawn_point(spawn_name: String = "Default") -> Node3D:
	return spawn_points.get(spawn_name)
