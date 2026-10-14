extends Node2D

#To spawn a battle scene, we need to export it as a PackedScene variable
@export var battle_scene : PackedScene
@onready var ui_Layer = $UILayer
@onready var player = $plr

const HUD_SCENE = preload("res://scenes/main menu.tscn")

func _ready():
	print("00_world")
	print(battle_scene)
	_07SignalBus.encounter_started.connect(start_battle)
		
func start_battle(enemy_data):
	print("00_world_2")
	get_tree().paused = true #Very important for returning the player back into the original workspace/playground
	
	#Creating the battle scene
	var battle_inst = battle_scene.instantiate()
	
	#Add it (battleScene) to the screen, inside the canvasLayer
	ui_Layer.add_child(battle_inst)
	
	#Passing enemy and player data
	battle_inst.init(enemy_data, player)
