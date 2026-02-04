extends CanvasLayer

@onready var score_label: Label = $ScoreLabel

func _ready() -> void:
	update_score(0, 0)
	GameManager.on_goal_scored.connect(_on_goal_scored)

func _on_goal_scored(_player: int) -> void:
	update_score(GameManager.score[0], GameManager.score[1])

func update_score(p1: int, p2: int) -> void:
	score_label.text = str(p1) + " - " + str(p2)
