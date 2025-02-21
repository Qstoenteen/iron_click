extends CanvasLayer

var iron_ore = preload("res://Resource/Ores/Iron_Ore.tres")
var silver_ore = preload("res://Resource/Ores/Silver_Ore.tres")
var gold_ore = preload("res://Resource/Ores/Gold_Ore.tres")
var platinum_ore = preload("res://Resource/Ores/Platinum_Ore.tres")
var stone = preload("res://Resource/Ores/Stone.tres")

var ores = []

var stone_count = 0
var iron_ore_count = 0
var silver_ore_count = 0
var gold_ore_count = 0
var platinum_ore_count = 0

func set_ore_chance():
	stone.drop_chance += stone.ratio_chance 
	iron_ore.drop_chance += iron_ore.ratio_chance 
	silver_ore.drop_chance += silver_ore.ratio_chance 
	gold_ore.drop_chance += gold_ore.ratio_chance 
	platinum_ore.drop_chance += platinum_ore.ratio_chance 
	
func _ready():
	var pickaxe = $"../pickaxe"
	var block_tick = $"../mine_block"
	
	#pass

	# Заполняем список руд
	ores.append(iron_ore)
	ores.append(silver_ore)
	ores.append(gold_ore)
	ores.append(platinum_ore)
	ores.append(stone)
	
	# КНОПКА
	$GenerateButton.text = "КЛИК"
	$GenerateButton.pressed.connect(pickaxe._pickaxe_tick) #Анимация кирки
	$GenerateButton.pressed.connect(block_tick._block_tick) #Анимация блока
	$GenerateButton.pressed.connect(Callable(self, "_Ore_mined"))
	$ResultLabel.text = "Нажмите кнопку, чтобы добыть руду."
	
	# Обновление UI с количеством руды
	update_resource_display()

# Обработка нажатия кнопки
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
	if dropped_ores.size() > 0:  # Проверяем, выпали ли какие-то руды
		var ore_names = []  # Список имен выпавших руд
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
		# Выводим список всех выпавших руд
		$ResultLabel.text = "Вы получили: %s!" % ", ".join(ore_names)
	else:
		$ResultLabel.text = "Ничего не выпало."
	# Обновляем отображение количества руды
	update_resource_display()
	
func get_random_ores():
	var dropped_ores = []  # Создаем пустой массив для выпавших руд
	for ore in ores:  # Проходим по всем рудам
		if randf() < ore.drop_chance:  # Проверяем, выпала ли руда
			dropped_ores.append(ore)  # Добавляем выпавшую руду в массив
	return dropped_ores  # Возвращаем массив выпавших руд

# Обновление отображения количества руды
func update_resource_display():
				# Обновляем отображение для Камня
	if stone_count > 0:
		$"../VBoxContainer/StoneLabel".text = "Stone: %d" % stone_count
		$"../VBoxContainer/StoneLabel".visible = true
	else:
		$"../VBoxContainer/StoneLabel".visible = false
	# Обновляем отображение для Железной руды
	if iron_ore_count > 0:
		$"../VBoxContainer/IronOreLabel".text = "I: %d" % iron_ore_count
		$"../VBoxContainer/IronOreLabel".visible = true
	else:
		$"../VBoxContainer/IronOreLabel".visible = false
	# Обновляем отображение для Золотой руды
	if gold_ore_count > 0:
		$"../VBoxContainer/GoldOreLabel".text = "G: %d" % gold_ore_count
		$"../VBoxContainer/GoldOreLabel".visible = true
	else:
		$"../VBoxContainer/GoldOreLabel".visible = false
			# Обновляем отображение для Платиновой руды
	if platinum_ore_count > 0:
		$"../VBoxContainer/PlatinumOreLabel".text = "P: %d" % platinum_ore_count
		$"../VBoxContainer/PlatinumOreLabel".visible = true
	else:
		$"../VBoxContainer/PlatinumOreLabel".visible = false
	# Обновляем отображение для Серебряной руды
	if silver_ore_count > 0:
		$"../VBoxContainer/SilverOreLabel".text = "S: %d" % silver_ore_count
		$"../VBoxContainer/SilverOreLabel".visible = true
	else:
		$"../VBoxContainer/SilverOreLabel".visible = false
