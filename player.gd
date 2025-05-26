
class_name Player
extends CharacterBody2D

const SPEED = 200.0
@export var bomb_scene: PackedScene

@onready var _animated_sprite = $AnimatedSprite2D
@onready var game: Game = get_parent()

func _enter_tree() -> void:
	set_multiplayer_authority(int(str(name)))

func _input(event):
	if event.is_action_pressed("drop_bomb"):
		place_bomb()

func place_bomb():
	if bomb_scene:
		var bomb = bomb_scene.instantiate()
		bomb.global_position = global_position
		get_tree().current_scene.add_child(bomb)
	
func _physics_process(_delta: float) -> void:
	if !is_multiplayer_authority():
		return
	
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var y_direction = Input.get_axis("ui_up", "ui_down")
	if y_direction:
		velocity.y = y_direction * SPEED
	else:
		velocity.y = move_toward(velocity.y, 0, SPEED)
		
	var x_direction = Input.get_axis("ui_left", "ui_right")
	if x_direction:
		velocity.x = x_direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		
	if velocity.length():
		var animation: String
		match velocity.normalized():
			Vector2.UP:
				animation = "up_walk"
			Vector2.LEFT:
				animation = "left_walk"
			Vector2.RIGHT:
				animation = "right_walk"
			Vector2.DOWN:
				animation = "down_walk"
		
		_animated_sprite.play(animation)
	else:
		_animated_sprite.stop()

	move_and_slide()
