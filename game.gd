class_name Game
extends Node2D

const PLAYER = preload("res://player.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	var player = PLAYER.instantiate()
	player.global_position = $Level.get_child(0).global_position
	add_child(player)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass
