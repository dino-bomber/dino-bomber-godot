class_name Game
extends Node2D

const PORT = 25565
const PLAYER = preload("res://player.tscn")

@onready var multiplayer_ui = $UI/Multiplayer
@onready var oid_label = $UI/Multiplayer/VBoxContainer/OID
@onready var oid_input = $UI/Multiplayer/VBoxContainer/OIDInput
var players: Array[Player] = []

func _ready():
	$MultiplayerSpawner.spawn_function = add_player

	await Multiplayer.noray_connected
	oid_label.text = Noray.oid

func _on_host_pressed() -> void:
	Multiplayer.host()
	
	multiplayer.peer_connected.connect(
		func(pid):
			print("Peer " + str(pid) + " has joined the game!")
			$MultiplayerSpawner.spawn(pid)
	)
	
	$MultiplayerSpawner.spawn(multiplayer.get_unique_id())
	multiplayer_ui.hide()

func _on_join_pressed() -> void:
	Multiplayer.join(oid_input.text)
	multiplayer_ui.hide()

func add_player(pid : int) -> Player:
	var player = PLAYER.instantiate()
	player.name = str(pid)
	player.global_position = $Level.get_child(players.size()).global_position
	players.append(player)
	return player

func get_random_spawnpoint():
	return $Level.get_children().pick_random().global_position


func _on_copy_oid_pressed():
	DisplayServer.clipboard_set(Noray.oid)
