extends CanvasModulate
class_name DayCycle

signal changeDayTime(dayTime: DAY_STATE)

@onready var animationPlayer: AnimationPlayer = $AnimationPlayer

enum DAY_STATE{MORNING, AFTERNOON, EVENING}

var dayTime: DAY_STATE = DAY_STATE.MORNING

func _ready() -> void:
	add_to_group("DayCycle")
	
func _process(delta: float) -> void:
	var currentAnimationPosition = animationPlayer.current_animation_position
	var animationLength = animationPlayer.current_animation_length / 3
	
	if currentAnimationPosition < animationLength && dayTime != DAY_STATE.MORNING:
		dayTime = DAY_STATE.MORNING
		changeDayTime.emit(dayTime)
	elif currentAnimationPosition > (animationLength * 2) && dayTime != DAY_STATE.AFTERNOON: 
		dayTime = DAY_STATE.EVENING
		changeDayTime.emit(dayTime)
	else:
		dayTime = DAY_STATE.EVENING
		changeDayTime.emit(dayTime)
