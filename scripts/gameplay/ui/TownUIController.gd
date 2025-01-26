class_name TownUIController extends Node

@export var thoughtsRepository: ThoughtsRepository

@export var player: PlayerController

@export_group("UI")
@export var thoughts_inventory_view: ThoughtsInventoryView

func _ready() -> void:
	player.inventory = ThoughtsInventory.new(thoughtsRepository)
	thoughts_inventory_view.set_inventory(player.inventory)
