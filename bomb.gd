extends Node2D

@onready var _animated_sprite = $BombSprite

func _ready() -> void:
	print("Bomb placed at ", position)
	_animated_sprite.play("fuse_burning")


func _on_timer_timeout():
	queue_free()
