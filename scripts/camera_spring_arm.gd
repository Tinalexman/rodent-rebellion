extends SpringArm3D

@export
var player : Node3D



func _process(delta: float) -> void:
	position = player.position + Vector3.UP * 2
