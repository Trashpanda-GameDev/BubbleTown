extends CanvasModulate
class_name DayCycle

signal changeDayTime(dayTime: DAY_STATE)
signal updateTime

@onready var animationPlayer: AnimationPlayer = $AnimationPlayer

var animationLengthInSeconds = 360
@export var hourInterval = 30
var lastTriggeredTime = -1

var dayTime: DAY_STATE = DAY_STATE.MORNING

enum DAY_STATE{DAWN, MORNING, AFTERNOON, EVENING, NIGHT}

func _ready() -> void:
	add_to_group("DayCycle")
	
func _process(delta: float) -> void:
	var currentAnimationPosition = animationPlayer.current_animation_position
	
	if currentAnimationPosition < 50 && dayTime != DAY_STATE.DAWN:
		dayTime = DAY_STATE.DAWN
		changeDayTime.emit(dayTime)
	elif currentAnimationPosition > 50 && currentAnimationPosition < 180 && dayTime != DAY_STATE.MORNING:
		dayTime = DAY_STATE.MORNING
		changeDayTime.emit(dayTime)
	elif currentAnimationPosition > 180 && currentAnimationPosition < 300 && dayTime != DAY_STATE.AFTERNOON: 
		dayTime = DAY_STATE.AFTERNOON
		changeDayTime.emit(dayTime)
	elif currentAnimationPosition > 300 && currentAnimationPosition < 360 && dayTime != DAY_STATE.EVENING: 
		dayTime = DAY_STATE.EVENING
		changeDayTime.emit(dayTime)
	else:
		dayTime = DAY_STATE.NIGHT
		changeDayTime.emit(dayTime)
	
	if animationPlayer.is_playing():
		check_and_trigger_signal(animationPlayer.current_animation_position)


func check_and_trigger_signal(currentTime):
	var timeAsInt = int(currentTime)

	if timeAsInt % hourInterval == 0 && timeAsInt != lastTriggeredTime:
		lastTriggeredTime = timeAsInt
		updateTime.emit(currentTime)
		
