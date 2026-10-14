class_name enemyData extends Resource

@export var name : String = "scientist"
@export var texture : Texture2D
@export var health : int = 20

# Mengganti damage tunggal dengan rentang (minimum dan maksimum)
@export var min_damage : int = 5
@export var max_damage : int = 8

# Fungsi untuk mendapatkan nilai damage secara acak
func get_damage() -> int:
	return randi_range(min_damage, max_damage)
