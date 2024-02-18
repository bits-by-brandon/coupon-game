extends Control

@onready var timer : Timer = %ItemTimer
@onready var bar : ProgressBar = %ItemTimerBar

func _ready():
	bar.value = 0.0

func _process(_delta) -> void:
	bar.value = timer.time_left / timer.wait_time * 100
