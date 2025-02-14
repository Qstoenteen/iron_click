extends CanvasLayer

var iron_ore = preload ("res://Resource/iron.tres")
var gold_ore = preload ("res://Resource/gold.tres")
var platinum_ore = preload ("res://Resource/platinum.tres")

var ores = []
var iron_ore_count = 0
var gold_ore_count = 0
var platinum_ore_count = 0

func _ready():
	ores.append(iron_ore)
	ores.append(gold_ore)
	ores.append(platinum_ore)
	var button = $Mine_button
	button.pressed.connect(_click_mine)
	
	
func _click_mine():
	var tester = $VBoxContainer
	tester.test_print()
	_on_generate_pressed()

	tester.add_label(iron_ore_count)
	print("CLICKED")
	
func _on_generate_pressed():
	var dropped_ores = get_random_ores()
	
	if dropped_ores.size() > 0:
		var ore_names = []  
		for dropped_ore in dropped_ores:
			ore_names.append(dropped_ore.name)
			if dropped_ore == iron_ore:
				iron_ore_count += 1
			elif dropped_ore == gold_ore:
				gold_ore_count += 1
			elif dropped_ore == platinum_ore:
				platinum_ore_count += 1
	if dropped_ores.size() == 0:
		print("Ничего не выпало")
	
	
func get_random_ores():
	var dropped_ores = []  # Создаем пустой массив для выпавших руд
	for ore in ores:  # Проходим по всем рудам
		if randf() < ore.drop_chance:  # Проверяем, выпала ли руда
			dropped_ores.append(ore)  # Добавляем выпавшую руду в массив
	return dropped_ores  # Возвращаем массив выпавших руд
	
