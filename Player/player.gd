extends CharacterBody2D

signal healthChanged

@export var speed: int = 200 # was 45
@onready var animations = $Sprite2D/AnimationPlayer
@onready var actionable_finder: Area2D = $Direction/ActionableFinder

@export var maxHealth = 10
@onready var currentHealth: int = maxHealth

@export var inventory: Inventory

var is_sprinting = false

func handleInput():
	var moveDirection = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	velocity = moveDirection * speed


	
func _unhandled_input(event: InputEvent) -> void:
	if Input.is_action_just_pressed("interact"):
		var actionables = actionable_finder.get_overlapping_areas()
		if actionables.size() > 0:
			actionables[0].action()
			return


func updateAnimation():
	if velocity.length() == 0:
		animations.stop()
	else:
		var direction = "Down"
		if velocity.x < 0: direction = "Left"
		elif velocity.x > 0: direction = "Right"
		elif velocity.y < 0: direction = "Up"
	
		animations.play("walk" + direction)


func handleCollision():
	for i in get_slide_collision_count():
		var collision = get_slide_collision(i)
		var collider = collision.get_collider()
		print_debug(collider.name)

func _on_hurt_box_area_entered(area):
	if area.has_method("collect"):
		area.collect(inventory)
	if area.name == "HitBox":
		currentHealth -= 1
		if currentHealth < 0:
			currentHealth = maxHealth
		healthChanged.emit(currentHealth)

func _physics_process(delta):
		handleInput()
		move_and_slide()
		handleCollision()
		updateAnimation()
		if Input.is_action_just_pressed("toggle_inventory"):
			inventory.print_contents()
