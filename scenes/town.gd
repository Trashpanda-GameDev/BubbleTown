extends Node2D

func _ready():
	print("Starting the day")

# Called when the Timer's `timeout()` signal is triggered
func _on_Timer_timeout():
	new_day()
