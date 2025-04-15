extends HBoxContainer


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
func duplicator():
	var miner = $"../CanvasLayer"
	print(miner.miners)
	var original_sprite = $Sprite2D
	var new_sprite = original_sprite.duplicate()
	new_sprite.show()
	new_sprite.position += Vector2(miner.miners *10,0)
	add_child(new_sprite)
	print("DUPLICATED")
