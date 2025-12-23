extends Node3D

@export var bullet_speed: float

var bullet_direction : Vector3


func _ready() -> void:
	$Timer.connect("timeout", queue_free)
	$Timer.set_wait_time(5)
	$Timer.start()


func _process(delta: float) -> void:
	position += bullet_direction * bullet_speed * delta
