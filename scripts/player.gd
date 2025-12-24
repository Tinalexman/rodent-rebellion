extends CharacterBody3D

@export var SPEED = 5.0
@export var camera : Camera3D
@export var world_root_node: Node3D
@export var shooting_position: Node3D


var is_alive = true

func _ready() -> void:
	$Weapon.shooting_position = shooting_position


func _physics_process(delta: float) -> void:
	
	if !is_alive: 
		return
	
	if not is_on_floor():
		velocity += get_gravity() * delta

	var input_dir := Input.get_vector("right", "left", "backward", "forward")
	var direction := Vector3(input_dir.x, 0, input_dir.y).normalized()
	if direction:
		velocity.x = direction.x * SPEED
		velocity.z = direction.z * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.z = move_toward(velocity.z, 0, SPEED)

	move_and_slide()
	
	var mouse_position = get_viewport().get_mouse_position()
	var ray_origin = camera.project_ray_origin(mouse_position)
	var ray_direction = ray_origin + camera.project_ray_normal(mouse_position) * 500
	var ray_query = PhysicsRayQueryParameters3D.create(ray_origin, ray_direction)
	
	ray_query.collide_with_bodies = true
	
	var space_state = get_world_3d().direct_space_state
	var ray_result = space_state.intersect_ray(ray_query)

	if (!ray_result.is_empty()):
		look_at(ray_result.position)


func _on_area_3d_body_entered(body: Node3D) -> void:
	if body.is_in_group("Enemy"):
		is_alive = false
		
		if get_node_or_null("Weapon") != null:
			$Weapon.queue_free()
		if get_node_or_null("SoldierModel") != null:	
			$SoldierModel.queue_free()
