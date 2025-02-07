extends Container

var block_hp = 100
var block_live = true
var depth = 0.0
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
	
	$Sprite2D.show()
	$mine_block_animation.play ("mine_block")
	block_hp -= randf_range(1,15)
	if block_hp <= 0:
		block_live = false
		$Sprite2D.hide()
		$CPUParticles2D.emitting = true
		await get_tree().create_timer(0.2).timeout  # Ждём 1 секунду
		$CPUParticles2D.emitting = false
		block_live = true
		$Sprite2D.show()
		$AudioStreamPlayer2D.play()
		
	if block_hp > 100:
		block_hp = 100
	print(block_hp)
	
func _particles_tick():
	pass
	
	
	
