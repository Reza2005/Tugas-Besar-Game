
extends StaticBody2D

@export var monster_data: enemyData

func _ready() -> void:
	$AnimatedSprite2D.play("slime")
	$DetectionArea.body_entered.connect(
		_on_detection_area_body_entered
	)


func _on_detection_area_body_entered(body: Node2D) -> void:
	if not body is CharacterBody2D:
		return

	var combat := body.get_node_or_null(
		"CombatController"
	) as PlayerCombat

	if combat:
		combat.start_battle(monster_data)
