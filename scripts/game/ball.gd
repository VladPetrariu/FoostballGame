extends Node3D

# Ball visual representation. Physics handled by PhysicsWorld.

func update_position(pos: Vector3) -> void:
	global_transform.origin = pos
