extends Node3D

@export var bullet_prefab : PackedScene
@export var player : Node3D
@export var shooting_position : Node3D
@export var bullets_per_second : int

var shoot_timer : float


func _process(delta: float) -> void:
	
	var shoot_rate = 1.0 / bullets_per_second
	if shoot_timer < shoot_rate:
		shoot_timer += delta
	
	if Input.is_action_pressed("shoot") and shoot_timer >= shoot_rate:
		shoot_timer = 0
		var bullet = bullet_prefab.instantiate()
		player.world_root_node.add_child(bullet)
		bullet.position = shooting_position.global_position
		bullet.bullet_direction = -shooting_position.global_transform.basis.z;
		 
	pass
