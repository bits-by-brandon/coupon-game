extends Control

@onready var timer : Timer = %ItemTimer
@onready var label : Label = %TimerLabel

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta) -> void:
	label.text = str(ceil(timer.time_left)) + " seconds"
