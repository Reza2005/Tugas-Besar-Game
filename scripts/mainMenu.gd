class_name mainMenu extends Node

const MainWorld = preload("res://scenes/world.tscn")
@onready var play: Button = $VBoxContainer/PanelContainer/Play
@onready var quit: Button = $VBoxContainer/PanelContainer2/Quit

func _on_play_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/world.tscn")

func _on_quit_pressed() -> void:
	get_tree().quit
