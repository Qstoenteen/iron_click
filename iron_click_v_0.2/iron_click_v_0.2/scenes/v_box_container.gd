extends VBoxContainer
#var ore = preload("res://Scripts/game_codes.gd")

func test_print():
	var tester = "TESTER"
	print (tester)
	pass
	#print(ore.iron_ore_count)

func add_label(label_text):
	var label = Label.new()
	label.text = str(label_text)
	label.name = "LABEL_NAME"
	label.position = Vector2()
	add_child(label)
	
	#Идея следующая - Если есть руда - создается отдельный лейбл, если руда исчезает - лейбл тоже удаляется.
	#Это позволит делает неограниченное кол-во руд, не меняя код проверок лейбла., Лейбл всегда будет появляется
	# и корректно отображать имеющуюся руду.
	
