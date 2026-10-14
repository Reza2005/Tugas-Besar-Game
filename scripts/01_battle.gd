extends Control
@export var debug_enemy_data: enemyData

#UI Nodes
#Enemy
@onready var enemy_texture = $MainLayout/BattleArea/EnemySide/VBoxContainer/TextureRect
@onready var enemy_hp: ProgressBar = $MainLayout/BattleArea/EnemySide/VBoxContainer/EnemyHP

#Player
@onready var player_hp: ProgressBar = $MainLayout/BattleArea/PlrSide/VBoxContainer/PlayerHP
@onready var run_button: Button = $MainLayout/ActionContainer/RunButton
@onready var atk_button: Button = $MainLayout/ActionContainer/AtkButton

#Misc
@onready var txt_label: Label = $MainLayout/PanelContainer/Label

#region \\ functions
#init for compiling enemy/plr data
#runMech / _on_run_button_pressed for running mechanic
#atkMech / _on_atk_button_pressed for attacking mechanic, involves the logic if the enemy has been defeated or not
#ETMech / enemy_turn for turn enemy function, involves the logic if the plr has been defeated or not
#WCMech / win_battle for battle won function
#endregion

#Logic Var.
var currentEnemyHP: int = 0
var enemyDMG: int = 0
var player: PlayerCombat

#func init( enemy_data: enemyData ):
	#print("01_battle")
	#enemy_texture.texture = enemy_data.texture
	#print("model of enemy is... ", enemy_texture.texture)
	#
	#txt_label.text = "A wild " + enemy_data.name + " appears!"
	#
	#pass
	
func init(enemy_data: enemyData, player_ref: PlayerCombat) -> void:
	print("01_battle")
	
	#Plr Logic
	player = player_ref #Stores player_ref variables to the player ref
	player_hp.max_value = player.max_HP
	player_hp.value = player.currentHP #use real heatlh
	
	#Enemy Logic
	#if enemy_data == null:
		#return
	#elif enemy_data.texture == null:
		#return
	#???? why the fuck did I need to return first to get the image?
	#its set in the .tres file itself idiot
	
	currentEnemyHP = enemy_data.health
	enemyDMG = enemy_data.damage
	
	enemy_hp.max_value = enemy_data.health
	enemy_hp.value = currentEnemyHP
	
	enemy_texture.texture = enemy_data.texture
	txt_label.text = "A wild " + enemy_data.name + " appears!"
	
	print("hp enemy is and damage is " + str(currentEnemyHP) + str(enemyDMG))

#runMech
func _on_run_button_pressed() -> void:
	get_tree().paused = false
	player.in_battle = false
	queue_free()

#atkMech
func _on_atk_button_pressed() -> void:
	#Lock buttons so as to not be bale to spam
	atk_button.disabled = true
	run_button.disabled = true
	
	#Deal fake damage(?) For stats, I guess?
	var rng = RandomNumberGenerator.new()
	var dmg = rng.randi_range(5,10)
	
	currentEnemyHP -= dmg
	enemy_hp.value = currentEnemyHP
	txt_label.text = "Hit for " + str(dmg)
	
	#Wait 1 second?
	await get_tree().create_timer(1.0).timeout
	
	#Check Results
	if currentEnemyHP <= 0:
		win_battle()
	else:
		enemy_turn()
		
#ETMech
func enemy_turn():
	txt_label.text = "The opposing force attacks"
	await get_tree().create_timer(1.0).timeout
		
	#Modify plr Script
	player.currentHP -= enemyDMG
	player_hp.value = player.currentHP
	
	txt_label.text = "You took " + str(enemyDMG) + "!"
	
	await get_tree().create_timer(1.0).timeout
	
	#Is plr dead?
	if player.currentHP <= 0:
		txt_label.text = "Defeated."
		await get_tree().create_timer(2.0).timeout
		
		#Restart game
		get_tree().paused = false
		get_tree().reload_current_scene()
	else:
		#give ctrl back to plr
		atk_button.disabled = false
		run_button.disabled = false
		txt_label.text = "Your turn"
		
#WCMech
func win_battle() -> void:
	txt_label.text = "You won!"
	await get_tree().create_timer(1.0).timeout

	get_tree().paused = false
	player.in_battle = false
	queue_free()
