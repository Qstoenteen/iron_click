extends Container

var block_hp = 100
var block_live = true

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass




func _process(_delta):
	$Sprite2D/ProgressBar.value = block_hp
	if block_hp <= 0:
		block_live = false
		if block_hp > 100:
			block_hp = 100
	
func _input(event):
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
			$mine_block_animation.play ("mine_block")
			block_hp -= randf_range(10,50)
			#print(block_hp)
