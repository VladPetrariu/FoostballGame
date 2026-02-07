extends Node

# --- Physics ---
const PHYSICS_HZ: int = 120
const PHYSICS_DT: float = 1.0 / 120.0
const FIXED_POINT_SCALE: int = 10000

# --- Table Dimensions (in Godot units ≈ meters) ---
const TABLE_LENGTH: float = 1.20
const TABLE_WIDTH: float = 0.68
const TABLE_HEIGHT: float = 0.09
const TABLE_SURFACE_Y: float = 0.75
const WALL_THICKNESS: float = 0.03
const GOAL_WIDTH: float = 0.20
const GOAL_DEPTH: float = 0.08

# --- Ball ---
const BALL_RADIUS: float = 0.017
const BALL_MAX_SPEED: float = 3.0
const BALL_FRICTION: float = 0.985
const BALL_WALL_RESTITUTION: float = 0.75

# --- Bars ---
# Interleaved bar layout from left to right: [player, bar_type, x_position, figure_count]
# bar_type: 0=goalie, 1=defense, 2=midfield, 3=attack
const BAR_CONFIG: Array = [
	[PLAYER_1, 0, -0.50, 1],  # P1 Goalie
	[PLAYER_1, 1, -0.36, 2],  # P1 Defense
	[PLAYER_2, 3, -0.22, 3],  # P2 Attack
	[PLAYER_1, 2, -0.08, 5],  # P1 Midfield
	[PLAYER_2, 2,  0.08, 5],  # P2 Midfield
	[PLAYER_1, 3,  0.22, 3],  # P1 Attack
	[PLAYER_2, 1,  0.36, 2],  # P2 Defense
	[PLAYER_2, 0,  0.50, 1],  # P2 Goalie
]

const BAR_SLIDE_RANGE: float = 0.10
const BAR_MAX_ROTATION_SPEED: float = 20.0
const BAR_ROTATION_RESET_SPEED: float = 10.0

# --- Scoring ---
const GOALS_TO_WIN: int = 5

# --- Network ---
const INPUT_BUFFER_SIZE: int = 8
const MAX_ROLLBACK_FRAMES: int = 10
const INPUT_DELAY_FRAMES: int = 2

# --- Player IDs ---
const PLAYER_1: int = 0
const PLAYER_2: int = 1
