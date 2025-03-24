extends Control


func _on_play_pressed() -> void:
	get_tree().change_scene_to_file("res://Levels/game_level.tscn")


func _on_exit_pressed() -> void:
	get_tree().quit()

var bg_music := AudioStreamPlayer.new()

func _ready():
	bg_music.stream = load("res://Art/Path to Lake Land.ogg")
	bg_music.autoplay = true
	bg_music.volume_db = -20
	add_child(bg_music)
