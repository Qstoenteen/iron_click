extends Resource

class_name Ore

@export var name: String = "Неизвестная руда"
@export var weight: float = 1.0
@export var price: float = 10.0
@export var drop_chance: float = 0.5
@export var rarity: String = "Обычная"
@export var quality: int = 1
@export var type: String = "Металлическая"
@export var color: Color = Color(1, 1, 1)
@export var description: String = "Описание руды."
@export var max_stack: int = 64
@export var energy: float = 0.0
@export var texture: Texture2D = null # Новое свойство для текстуры
