
extends Node
class_name PlayerCombat

@export var max_HP: int = 100
@export var battle_scene: PackedScene

var currentHP: int
var in_battle: bool = false

func _ready() -> void:
	currentHP = max_HP

	if not _07SignalBus.encounter_started.is_connected(
		_on_encounter_started
	):
		_07SignalBus.encounter_started.connect(
			_on_encounter_started
		)


func start_battle(enemy: enemyData) -> void:
	if in_battle or enemy == null:
		return

	in_battle = true

	print("Battle should start")
	print("A wild " + enemy.name + " has appeared")

	_07SignalBus.encounter_started.emit(enemy)


func _on_encounter_started(enemy: enemyData) -> void:
	if battle_scene == null:
		push_error("Assign the battle scene in CombatController.")
		in_battle = false
		return

	var battle_instance := battle_scene.instantiate() as Control

	if battle_instance == null:
		push_error("The battle scene root must be a Control node.")
		in_battle = false
		return

	battle_instance.process_mode = Node.PROCESS_MODE_ALWAYS
	get_tree().current_scene.add_child(battle_instance)
	battle_instance.init(enemy, self)

	get_tree().paused = true
