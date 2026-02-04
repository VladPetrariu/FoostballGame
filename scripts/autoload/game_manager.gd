extends Node

enum GameState { NONE, MENU, PLAYING, PAUSED, MATCH_END }

var current_state: int = GameState.NONE
var score: Array = [0, 0]
var is_online: bool = false

signal on_goal_scored(player: int)
signal on_match_end(winner: int)

func start_local_match() -> void:
	score = [0, 0]
	current_state = GameState.PLAYING
	get_tree().change_scene_to_file("res://scenes/game/game.tscn")

func goal_scored(player: int) -> void:
	score[player] += 1
	on_goal_scored.emit(player)
	if score[player] >= Constants.GOALS_TO_WIN:
		current_state = GameState.MATCH_END
		on_match_end.emit(player)
