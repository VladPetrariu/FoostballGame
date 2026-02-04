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
const BAR_POSITIONS_P1: Array = [
	-0.50,  # Goalie (1 figure)
	-0.38,  # Defense (2 figures)
	-0.15,  # Midfield (5 figures)
	 0.05,  # Attack (3 figures)
]
const BAR_FIGURE_COUNTS: Array = [1, 2, 5, 3]

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
