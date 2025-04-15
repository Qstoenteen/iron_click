extends Container

var block_hp = 100
var block_live = true
var depth = 0.0
var pickaxe_damage = 5
@onready var timer = $CPUParticles2D/Timer

# Called when the node enters the scene tree for the first time.
func _ready():
	pass
	#start_timer()



func _process(_delta):
	$Null_sprite/ProgressBar.value = block_hp
	#if block_hp <= 0:
		#block_live = false
		
		#if block_hp > 100:
			#block_hp = 100
		
			
	
#func _input(event):
	#if event is InputEventMouseButton:
		#if event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
			#$mine_block_animation.play ("mine_block")
			#block_hp -= randf_range(10,50)
			#print(block_hp)


	
func _block_tick():
	var frame = "res://Scenes/mine_block.tscn"
	if block_hp > 90:
		$AnimatedSprite2D.set_frame(0)
	if block_hp < 90:
		$AnimatedSprite2D.set_frame(1)
	if block_hp < 70:
		$AnimatedSprite2D.set_frame(2)
	if block_hp < 40:
		$AnimatedSprite2D.set_frame(3)
	if block_hp < 10:
		$AnimatedSprite2D.set_frame(4)
	#$Sprite2D.show()
	#$AnimatedSprite2D.show
	$Block_mine_animation.play("block_mine")
	#$mine_block_animation.play ("mine_block")
	block_hp -= pickaxe_damage
	#print(block_hp)
	#print(pickaxe_damage)
	
	if block_hp <= 0:
		block_live = false
		#$Sprite2D.hide()
		$AnimatedSprite2D.hide()
		$CPUParticles2D.emitting = true
		await get_tree().create_timer(0.2).timeout  # Ждём 1 секунду
		$CPUParticles2D.emitting = false
		
		block_live = true
		$AnimatedSprite2D.set_frame(0)
		$AnimatedSprite2D.show()
		#$Sprite2D.show()
		$AudioStreamPlayer2D.play()
		
	if block_hp > 100:
		block_hp = 100
	#print(block_hp)

	
	
func _particles_tick():
	pass
	
	
	
