extends CanvasLayer

# Ресурсы
var iron_ore = preload("res://Resource/Ores/Iron_Ore.tres")
var silver_ore = preload("res://Resource/Ores/Silver_Ore.tres")
var gold_ore = preload("res://Resource/Ores/Gold_Ore.tres")
var platinum_ore = preload("res://Resource/Ores/Platinum_Ore.tres")
var stone = preload("res://Resource/Ores/Stone.tres")

# Переменные
var ores = []
var stone_count = 55
var iron_ore_count = 0
var silver_ore_count = 0
var gold_ore_count = 0
var platinum_ore_count = 0
var miners = 0  


var hire_cost = 10 
@onready var mining_timer = $MiningTimer
@onready var generate_button = $GenerateButton

# Новые переменные для управления интервалом
var base_interval = 1.0  # Начальный интервал (1 секунда)
var min_interval = 0.1   # Минимальный интервал
var interval_step = 0.1  # Шаг уменьшения интервала
var test_imer = 0
func _ready():
	var pickaxe = $"../pickaxe"
	var block_tick = $"../mine_block"
	
	# Заполняем список руд
	ores.append(iron_ore)
	ores.append(silver_ore)
	ores.append(gold_ore)
	ores.append(platinum_ore)
	ores.append(stone)
	
	# Настройка кнопки добычи
	generate_button.text = "КЛИК"
	generate_button.pressed.connect(pickaxe._pickaxe_tick)
	generate_button.pressed.connect(block_tick._block_tick)
	generate_button.pressed.connect(Callable(self, "_Ore_mined"))
	$ResultLabel.text = "Нажмите кнопку, чтобы добыть руду."
	
	# Настройка кнопки найма
	$HireButton.text = "Нанять шахтера (%d камня)" % hire_cost
	$HireButton.pressed.connect(_on_hire_button_pressed)
	
	# Запуск таймера автоматической добычи
	mining_timer.timeout.connect(_on_mining_timer_timeout)
	mining_timer.start(base_interval)  # Запускаем с базовым интервалом
	
	update_resource_display()

# Наем шахтера
func _on_hire_button_pressed():
	if stone_count >= hire_cost:
		stone_count -= hire_cost
		miners += 1
		hire_cost += 5
		$HireButton.text = "Нанять шахтера (%d камня)" % hire_cost
		update_resource_display()
		$ResultLabel.text = "Нанят шахтер! Всего шахтеров: %d" % miners
		
		# Обновляем интервал таймера
		update_mining_interval()
	else:
		$ResultLabel.text = "Недостаточно камня!"

# Обновление интервала добычи
func update_mining_interval():
	var new_interval = max(min_interval, base_interval - (miners * interval_step))
	mining_timer.wait_time = new_interval
	print("new interval = ", new_interval)
	mining_timer.start()  # Перезапускаем таймер с новым интервалом
	print("Интервал добычи обновлен: ", new_interval, " сек")  # Для отладки

func _on_mining_timer_timeout():
	if miners > 0:
		# Имитируем нажатие кнопки "КЛИК" для каждого шахтера
		for i in range(miners):

			generate_button.emit_signal("pressed")
			await get_tree().create_timer(0.1).timeout  # Задержка 0.01 секунды (10 мс)
		update_resource_display()
		
		
func set_ore_chance():
	stone.drop_chance += stone.ratio_chance 
	iron_ore.drop_chance += iron_ore.ratio_chance 
	silver_ore.drop_chance += silver_ore.ratio_chance 
	gold_ore.drop_chance += gold_ore.ratio_chance 
	platinum_ore.drop_chance += platinum_ore.ratio_chance 

func _Ore_mined():
	var block = $"../mine_block"
	var metric = "m"
	if block.depth < 1000:
		$"../depth_label".text = ("Глубина: " + str(block.depth) + metric)
	if block.depth > 1000:
		metric = "km"
		$"../depth_label".text = ("Глубина: " + str(block.depth/1000) + metric)
	if block.block_live == false:
		block._particles_tick()
		block.block_hp =+ 100
		block.block_live = true
		block.depth += 1
		_on_generate_pressed()
		set_ore_chance()
		
func _on_generate_pressed():
	var dropped_ores = get_random_ores()
	if dropped_ores.size() > 0:
		var ore_names = []
		for dropped_ore in dropped_ores:
			ore_names.append(dropped_ore.name)
			if dropped_ore == stone:
				stone_count += 1
			elif dropped_ore == iron_ore:
				iron_ore_count += 1
			elif dropped_ore == silver_ore:
				silver_ore_count += 1
			elif dropped_ore == gold_ore:
				gold_ore_count += 1
			elif dropped_ore == platinum_ore:
				platinum_ore_count += 1
		$ResultLabel.text = "Вы получили: %s!" % ", ".join(ore_names)
	else:
		$ResultLabel.text = "Ничего не выпало."
	update_resource_display()
	
func get_random_ores():
	var dropped_ores = []
	for ore in ores:
		if randf() < ore.drop_chance:
			dropped_ores.append(ore)
	return dropped_ores

func update_resource_display():
	if stone_count > 0:
		$"../VBoxContainer/StoneLabel".text = "Stone: %d" % stone_count
		$"../VBoxContainer/StoneLabel".visible = true
	else:
		$"../VBoxContainer/StoneLabel".visible = false
	
	if iron_ore_count > 0:
		$"../VBoxContainer/IronOreLabel".text = "I: %d" % iron_ore_count
		$"../VBoxContainer/IronOreLabel".visible = true
	else:
		$"../VBoxContainer/IronOreLabel".visible = false
	
	if gold_ore_count > 0:
		$"../VBoxContainer/GoldOreLabel".text = "G: %d" % gold_ore_count
		$"../VBoxContainer/GoldOreLabel".visible = true
	else:
		$"../VBoxContainer/GoldOreLabel".visible = false
	
	if platinum_ore_count > 0:
		$"../VBoxContainer/PlatinumOreLabel".text = "P: %d" % platinum_ore_count
		$"../VBoxContainer/PlatinumOreLabel".visible = true
	else:
		$"../VBoxContainer/PlatinumOreLabel".visible = false
	
	if silver_ore_count > 0:
		$"../VBoxContainer/SilverOreLabel".text = "S: %d" % silver_ore_count
		$"../VBoxContainer/SilverOreLabel".visible = true
	else:
		$"../VBoxContainer/SilverOreLabel".visible = false
