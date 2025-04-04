extends Node2D

@onready var heartsContainer = $CanvasLayer/HeartsContainer
@onready var player = $Player2
var bg_music := AudioStreamPlayer.new()

func _ready():
	heartsContainer.setMaxHearts(player.maxHealth)
	heartsContainer.updateHearts(player.currentHealth)
	player.healthChanged.connect(heartsContainer.updateHearts)
	bg_music.stream = load("res://Art/Dark Descent (Extended Cut).mp3")
	bg_music.autoplay = true
	bg_music.volume_db = -20
	add_child(bg_music)

func _on_inventory_gui_closed():
	get_tree().paused = false


func _on_inventory_gui_opened():
	get_tree().paused = true
