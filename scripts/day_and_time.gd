extends Control

@onready var daysLabel: Label = $DayControl/day
@onready var hoursLabel: Label = $TimeControl/hours
@onready var minutesLabel: Label = $TimeControl/minutes

var initialHour: int = 9
var lastHour: int = 21
var passedHour: int

func _on_day_cycle_update_time(currentTime: int) -> void:
	var currentHour: int = initialHour + passedHour
	hoursLabel.text = str(currentHour)
	
	if currentHour > 21:
		hoursLabel.text = str(21)
	
	passedHour += 1
