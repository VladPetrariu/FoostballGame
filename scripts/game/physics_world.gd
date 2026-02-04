class_name PhysicsWorld

var ball_pos: Vector2 = Vector2.ZERO
var ball_vel: Vector2 = Vector2.ZERO
var wall_segments: Array = []

func initialize(table: Node) -> void:
	wall_segments = table.get_wall_segments()

func step() -> void:
	# Phase 3 will implement full ball physics simulation
	pass

func get_ball_3d_position() -> Vector3:
	return Vector3(ball_pos.x, Constants.TABLE_SURFACE_Y + Constants.BALL_RADIUS, ball_pos.y)
