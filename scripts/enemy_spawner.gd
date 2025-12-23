extends Node3D

@export var enemy_prefab : PackedScene
@export var root_node : Node3D

@export var max_enemies : int
@export var spawn_rate : int

var current_enemies : int

func _ready() -> void:
	current_enemies = 0
	
func on_enemy_killed() -> void:
	current_enemies -= 1

func _process(delta: float) -> void:
	if(current_enemies >= max_enemies):
		return
	
	for i in range(spawn_rate):
		if current_enemies >= max_enemies:
			break
		
		var enemy = enemy_prefab.instantiate()
		enemy.enemy_died.connect(on_enemy_killed)
		var rand_angle = randf_range(0, PI * 2)
		enemy.position = global_position + ((Vector3.RIGHT * sin(rand_angle) + Vector3.FORWARD * cos(rand_angle))) * 20
		root_node.add_child(enemy)
		current_enemies += 1
