class_name ThoughtResource extends Resource

@export var texture: Texture2D

func get_sprite() -> Sprite2D:
	var sprite: Sprite2D = Sprite2D.new()
	sprite.texture = self.texture

	return sprite

func add_sprite(parent: Node) -> void:
	var sprite: Sprite2D = self.get_sprite()

	parent.add_child(sprite) 
