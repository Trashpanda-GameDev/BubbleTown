extends Node2D

signal toggleEndDayPrompt

func _on_house_body_entered(body: Node2D) -> void:
	toggleEndDayPrompt.emit(true)

func _on_house_body_exited(body: Node2D) -> void:
	toggleEndDayPrompt.emit(false)
