class_name ThoughtsInventoryView extends Control

@export var repository: ThoughtsRepository

@export var grid: GridContainer

var inventory: ThoughtsInventory

func _init() -> void:
	# ensure inventory is never unset
	inventory = ThoughtsInventory.new(repository)

func set_inventory(inventory: ThoughtsInventory) -> void:
	self.inventory = inventory

