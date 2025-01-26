class_name PlayerController extends Node

@export var thoughtsRepository: ThoughtsRepository

@export var movement: PlayerMovement

var inventory: ThoughtsInventory

var _current_villager: VillagerSystem
var _is_near_villager: bool = false

signal show_post_photo_panel
signal toggle_prompt_message

func _init() -> void:
	inventory = ThoughtsInventory.new(thoughtsRepository)

func _process(_delta: float) -> void:
	self._handle_villager_interaction()

func _on_player_house_toggle_end_day_prompt(show_prompt: bool) -> void:
	toggle_prompt_message.emit(show_prompt)

func _handle_villager_interaction() -> void:
	if !_is_near_villager || !Input.is_action_just_pressed("interact"):
		return
	if !_current_villager.thought.has_thought():
		return

	var thought := _current_villager.thought.get_thought()
	_current_villager.thought.clear_thought()
	self.inventory.add_thought(thought)

func _on_villager_nearby(body: Node2D) -> void:
	var parent: Node = body.get_parent()
	if !(parent is VillagerSystem):
		return

	_current_villager = parent
	_is_near_villager = true

func _on_villager_afar(body: Node2D) -> void:
	var parent: Node = body.get_parent()
	if _current_villager != parent:
		return

	_current_villager = null
	_is_near_villager = false

func _on_prompt_message_end_day_cycle() -> void:
	show_post_photo_panel.emit()
	
