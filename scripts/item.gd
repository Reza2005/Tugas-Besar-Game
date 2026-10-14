extends AnimatableBody2D

@export var monster_data: enemyData

# Ganti teks di dalam tanda kutip dengan lokasi file scene Victory Screen Anda di panel FileSystem.
# (Anda bisa klik kanan file Victory_Screen.tscn -> Copy Path)
const VICTORY_SCENE_PATH = "res://scenes/Victory_Screen.tscn"

func _ready() -> void:
	pass

func _process(delta: float) -> void:
	pass

# Fungsi ini muncul setelah Anda menghubungkan sinyal body_entered
func _on_detection_area_body_entered(body) -> void:
	# Cek apakah yang menyentuh item adalah pemain (bisa menggunakan nama node "Player" atau grup)
	if body.is_in_group("Player"): 
		print("Item diambil! Pindah ke Victory Screen...")
		# Menghapus item dari map (opsional, jika ingin ada jeda/efek sebelum pindah)
		# queue_free() 
		
		# Perintah untuk berpindah scene
		get_tree().change_scene_to_file("res://scenes/Victory_Screen.tscn")
