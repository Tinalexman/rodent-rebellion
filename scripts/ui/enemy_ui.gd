extends Control


var camera : Camera3D


func _ready() -> void:
	camera = get_tree().get_first_node_in_group("Camera")


func _process(delta: float) -> void:
	position = camera.unproject_position(get_parent().global_position)
