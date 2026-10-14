extends StaticBody2D

@export var monster_data: enemyData

# Gunakan preload untuk langsung memuat file item.tscn
# GANTI "res://path/ke/folder/item.tscn" dengan jalur file item Anda yang sebenarnya
const ITEM_SCENE = preload("res://scenes/item.tscn") 

var current_health: int

func _ready() -> void:
	$AnimatedSprite2D.play("slime")
	
	if monster_data:
		current_health = monster_data.health
		
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

func take_damage(amount: int) -> void:
	current_health -= amount
	print("Slime terkena damage: ", amount, ". HP sisa: ", current_health)
	
	if current_health <= 0:
		die()

func die() -> void:
	
	print("Slime mati!")
	
	# Instantiate item dari konstanta yang di-preload
	var spawned_item = ITEM_SCENE.instantiate()
	
	# Menyamakan posisi item dengan posisi slime yang mati
	spawned_item.global_position = global_position
	
	# add_sibling lebih aman daripada get_parent().add_child()
	# Ini menempatkan item di level hierarki yang sama dengan slime
	call_deferred("add_sibling", spawned_item)
	
	# Menghapus slime dari layar
	queue_free()	
	
