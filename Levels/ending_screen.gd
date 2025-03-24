extends Control


var bg_music := AudioStreamPlayer.new()

func _on_quit_pressed() -> void:
	get_tree().change_scene_to_file("res://Levels/menu.tscn")

func _ready():
	bg_music.stream = load("res://Art/raspberry_jam.ogg")
	bg_music.autoplay = true
	bg_music.volume_db = -20
	add_child(bg_music)
