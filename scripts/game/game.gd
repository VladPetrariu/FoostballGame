extends Node3D

@onready var table: Node3D = $Table
@onready var ball: Node3D = $Ball

var physics_world: PhysicsWorld = PhysicsWorld.new()

func _ready() -> void:
	physics_world.initialize(table)
	reset_ball()

func _physics_process(_delta: float) -> void:
	physics_world.step()
	ball.update_position(physics_world.get_ball_3d_position())

func reset_ball() -> void:
	physics_world.ball_pos = Vector2.ZERO
	physics_world.ball_vel = Vector2.ZERO
	ball.update_position(physics_world.get_ball_3d_position())
