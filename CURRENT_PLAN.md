# Foosball Game - Phase 02 Implementation Plan

## Project Status

**Completed:** Phase 01 - Project Scaffold and Table
- Godot 4.6 project structure established
- 3D foosball table with proper dimensions (1.20m x 0.68m)
- Ball visual object created
- Physics world class (stub for Phase 03)
- Game manager with score tracking
- HUD with score display
- Constants defined for all game parameters
- Camera and lighting configured

**Current Phase:** Phase 02 - Bars, Figures, and Controls

**Goal:** Implement 8 foosball bars (4 per player) with attached figures, player controls (keyboard bar selection + mouse rotation/sliding), and reset-to-vertical mechanic.

---

## Existing Files to Modify

### 1. `scripts/game/bar.gd`
**Current state:** Placeholder with just 4 variables
**Required changes:** Complete rewrite with full bar logic

### 2. `scripts/game/game.gd`
**Current state:** Basic game loop with ball/physics
**Required changes:** Add bar spawning, input handling, state management

---

## New Files to Create

### 1. `scenes/game/bar.tscn`
Bar scene with Rod, Figures container, SelectionIndicator

### 2. `scripts/game/input_handler.gd`
Input handler for keyboard bar selection and mouse control

---

## Implementation Steps

### Step 1: Create `scenes/game/bar.tscn`

```
Bar (Node3D) [script: bar.gd]
├── Rod (MeshInstance3D)
│   - CylinderMesh, radius 0.004, height 0.78 (TABLE_WIDTH + 0.10)
│   - Rotated 90° on X to lie along Z-axis
│   - StandardMaterial3D: metallic=0.8, roughness=0.3, silver color
├── Figures (Node3D)
│   - Empty container, figures added dynamically
└── SelectionIndicator (MeshInstance3D)
    - Small sphere or torus mesh
    - Emissive yellow material
    - Initially hidden
```

### Step 2: Rewrite `scripts/game/bar.gd`

**Properties:**
- player: int (0=P1, 1=P2)
- bar_index: int (0-3: goalie, defense, midfield, attack)
- z_offset: float (slide position)
- rotation_angle: float (radians, 0=vertical)
- rotation_speed: float (angular velocity)
- figure_count: int (1, 2, 5, or 3)
- figure_base_positions: Array[float]
- is_selected: bool

**Methods:**
- `setup(p_player, p_bar_index, p_x_pos, p_fig_count)` - Initialize bar
- `_create_figures()` - Spawn figure meshes evenly spaced
- `_make_figure_mesh()` - Create single figure (BoxMesh 0.015x0.05x0.02)
- `_setup_rod()` - Configure rod mesh and material
- `_setup_selection_indicator()` - Configure indicator mesh
- `apply_state(z_offset, rotation, rot_speed)` - Update transforms
- `get_figure_world_positions()` - Return Array of Vector2 (x,z)
- `get_figure_collision_rect(fig_index)` - Return Rect2 for collision
- `update_selection_visual()` - Toggle indicator visibility

**Figure spacing calculation:**
- usable_range = 0.60m
- spacing = usable_range / (figure_count + 1)
- Each figure Z = -usable_range/2 + spacing * (i + 1)

**Materials:**
- Rod: Silver metallic (Color(0.75, 0.75, 0.78))
- P1 Figures: Red (#CC2200)
- P2 Figures: Blue (#0044CC)
- Selection: Emissive yellow

### Step 3: Create `scripts/game/input_handler.gd`

**Signals:**
- `bar_selected(player: int, bar_index: int)`
- `bar_input(player: int, rotation_delta: float, slide_delta: float)`
- `bar_released(player: int)`

**Properties:**
- active_bar_index: int = 0
- is_mouse_held: bool = false
- mouse_sensitivity_rotation: float = 0.005
- mouse_sensitivity_slide: float = 0.0003

**Input handling:**
- `_ready()`: Set mouse mode to MOUSE_MODE_CAPTURED
- `_unhandled_input(event)`:
  - KEY_1 through KEY_4: Select bar 0-3, emit bar_selected
  - KEY_ESCAPE: Release mouse (MOUSE_MODE_VISIBLE)
  - MOUSE_BUTTON_LEFT press/release: Toggle is_mouse_held, emit bar_released
  - InputEventMouseMotion while held: Calculate deltas, emit bar_input

### Step 4: Update `scripts/game/game.gd`

**New properties:**
- bars: Array = [] (all 8 bar nodes)
- p1_bars: Array = []
- p2_bars: Array = []
- bar_states: Array = [] (8 state dictionaries)
- input_handler: InputHandler

**Bar state structure:**
```gdscript
{
    "z_offset": 0.0,
    "rotation": 0.0,
    "rotation_speed": 0.0
}
```

**New methods:**
- `_setup_bars()` - Spawn 8 bars into P1Bars/P2Bars nodes
- `_init_bar_states()` - Initialize state array
- `_on_bar_input(player, rot_delta, slide_delta)` - Update state from input
- `_on_bar_released(player)` - (empty, reset handled in update)
- `_update_bar_resets(dt)` - Smooth return-to-vertical for inactive bars
- `_update_bar_visuals()` - Sync bar node transforms from state

**Bar positions:**
- P1 bars: Use BAR_POSITIONS_P1 directly [-0.50, -0.38, -0.15, 0.05]
- P2 bars: Mirror P1 positions [0.50, 0.38, 0.15, -0.05] (negate and reverse order)

**Modified _ready():**
```gdscript
func _ready() -> void:
    _setup_input_handler()
    _setup_bars()
    _init_bar_states()
    physics_world.initialize(table)
    reset_ball()
```

**Modified _physics_process():**
```gdscript
func _physics_process(delta: float) -> void:
    _update_bar_resets(delta)
    _update_bar_visuals()
    physics_world.step()
    ball.update_position(physics_world.get_ball_3d_position())
```

---

## Constants Already Defined (in constants.gd)

```gdscript
const BAR_POSITIONS_P1: Array = [-0.50, -0.38, -0.15, 0.05]
const BAR_FIGURE_COUNTS: Array = [1, 2, 5, 3]
const BAR_SLIDE_RANGE: float = 0.10
const BAR_MAX_ROTATION_SPEED: float = 20.0
const BAR_ROTATION_RESET_SPEED: float = 10.0
const TABLE_SURFACE_Y: float = 0.75
const TABLE_WIDTH: float = 0.68
const PLAYER_1: int = 0
const PLAYER_2: int = 1
```

---

## Verification Checklist

After implementation, verify:
- [ ] All 8 bars visible on table with correct figure counts (1,2,5,3 per side)
- [ ] P1 figures are red, P2 figures are blue
- [ ] Keys 1-4 switch active bar (visual indicator shows which)
- [ ] Hold left mouse + move left/right: bar rotates
- [ ] Hold left mouse + move up/down: bar slides along its axis
- [ ] Release mouse: bar smoothly returns to vertical
- [ ] Bar slide is clamped (can't go off table)
- [ ] Rods are visible spanning the table width
- [ ] P2 bars don't respond to input (correct for local P1 testing)

---

## File Change Summary

| File | Action | Lines (approx) |
|------|--------|----------------|
| `scripts/game/bar.gd` | Rewrite | ~120 |
| `scenes/game/bar.tscn` | Create | ~40 |
| `scripts/game/input_handler.gd` | Create | ~50 |
| `scripts/game/game.gd` | Modify | +80 |

---

## Notes

- Figure meshes are placeholder boxes (proper 3D models in Phase 08)
- Mouse sensitivity values may need tuning through playtesting
- Rotation is unclamped (360° spinning allowed - common foosball technique)
- rotation_speed tracked for shot power calculation in Phase 03
- Input structure designed to be network-friendly for Phase 06
