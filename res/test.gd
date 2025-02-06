extends Node

# Подключаем созданный ресурс
var iron_ore: Resource = preload("res://Resource/Ores/Gold_Ore.tres")

func _ready():
	if iron_ore:
		print("Ресурс успешно загружен!")
		print("Информация о руде:")
		print(iron_ore.get("name")) # Название
		print("Вес:", iron_ore.get("weight")) # Вес
		print("Цена:", iron_ore.get("price")) # Цена
		print("Шанс выпадения:", iron_ore.get("drop_chance") * 100, "%") # Шанс выпадения
		print("Редкость:", iron_ore.get("rarity")) # Редкость
		print("Качество:", iron_ore.get("quality")) # Качество
		print("Тип:", iron_ore.get("type")) # Тип
		print("Цвет:", iron_ore.get("color")) # Цвет
		print("Описание:", iron_ore.get("description")) # Описание
		print("Максимальный стек:", iron_ore.get("max_stack")) # Максимальный стек
		print("Энергия:", iron_ore.get("energy")) # Энергия
	else:
		print("Не удалось загрузить ресурс Iron_Ore.tres!")
