extends Node

# Dictionary of scenes keyed by level ID
var levels := {
	"test_1": preload("res://levels/test_1.tscn"),
	"test_2": preload("res://levels/test_2.tscn")
}

func get_scene(level_id: String) -> PackedScene:
	return levels.get(level_id)
