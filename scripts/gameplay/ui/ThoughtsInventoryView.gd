class_name ThoughtsInventoryView extends Control

@export var repository: ThoughtsRepository

@export var grid: GridContainer

@export var itemViewTemplate: PackedScene

var inventory: ThoughtsInventory

func _init() -> void:
	if inventory:
		inventory.on_thought_added.disconnect(_handle_added_thought)
		inventory.on_thought_removed.disconnect(_handle_removed_thought)

	# ensure inventory is never unset
	inventory = ThoughtsInventory.new(repository)

	inventory.on_thought_added.connect(_handle_added_thought)
	inventory.on_thought_removed.connect(_handle_removed_thought)

# TODO: move from here
func _process(delta: float) -> void:
	if Input.is_action_just_pressed("open_inventory"):
		self.visible = !self.visible

func set_inventory(inventory: ThoughtsInventory) -> void:
	self.inventory.on_thought_added.disconnect(_handle_added_thought)
	self.inventory.on_thought_removed.disconnect(_handle_removed_thought)

	self.inventory = inventory

	self.inventory.on_thought_added.connect(_handle_added_thought)
	self.inventory.on_thought_removed.connect(_handle_removed_thought)

func _handle_added_thought(thought: Thought) -> void:
	var view := _instantiate_item_view(thought)
	grid.add_child(view)

func _handle_removed_thought(thought: Thought) -> void:
	for i in range(0, grid.get_child_count()):
		var itemView: ThoughtInventoryItemView = grid.get_child(i)
		if itemView.thought == thought:
			grid.remove_child(itemView)

			return

func _instantiate_item_view(thought: Thought) -> ThoughtInventoryItemView:
	var instance: ThoughtInventoryItemView = itemViewTemplate.instantiate()

	instance.set_thought(thought)

	return instance
