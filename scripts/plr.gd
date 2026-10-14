extends Node
class_name PlayerCombat

@export var max_HP: int = 17

var currentHP: int
var in_battle: bool = false

func _ready() -> void:
	currentHP = max_HP

func start_battle(enemy: enemyData) -> void:
	if in_battle or enemy == null:
		return

	in_battle = true
	print("Battle should start: ", enemy.name)
	_07SignalBus.encounter_started.emit(enemy)
