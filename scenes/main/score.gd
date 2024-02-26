extends Control

@onready var score_label: Label = %TotalScore
@onready var multiplier_label: Label = %Multiplier
@onready var animation_player: AnimationPlayer = %ScoreAnimationPlayer

# Called when the node enters the scene tree for the first time.
func _ready():
	Events.streak_lost.connect(_on_streak_lost)
	Events.streak_increased.connect(_on_streak_increased)
	Events.score_updated.connect(_on_score_updated)
	Events.reset.connect(_on_reset)

func _on_reset():
	multiplier_label.text = "1x"
	score_label.text = "0"

func _on_streak_lost():
	await get_tree().create_timer(.9).timeout
	multiplier_label.text = "1x"

func _on_streak_increased(streak: int):
	await get_tree().create_timer(.9).timeout
	multiplier_label.text = "%sx" % [streak]
	animation_player.play("multiplier_increased")

func _on_score_updated(score: int):
	await get_tree().create_timer(1.0).timeout
	score_label.text = str(score)