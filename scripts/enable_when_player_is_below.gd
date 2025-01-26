extends CollisionPolygon2D

var found := false
var playerNode: Node2D;

func _ready() -> void:
	# search for the player
	var player = get_tree().root.find_child("Player", true, false)
	
	if(!player):
		self.visible = false
		self.disabled = true
		return
	
	found = true;
	playerNode = player
	check_collision_status()

func _physics_process(delta: float) -> void:
	if (!found): return;
	check_collision_status()

func check_collision_status() -> void:
	var playerIsBelow = (playerNode.global_position.y > global_position.y)
	self.visible = playerIsBelow
	self.disabled = !self.visible
