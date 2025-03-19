extends Node
@onready var player = $"../../CanvasLayer/Player"


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_save_pressed() -> void:
	var saved_game:SavedGame = SavedGame.new()
	
	saved_game.player_position = player.global_position
	saved_game.player_health = player.HP
	saved_game.player_speed = player.SPEED
	
	ResourceSaver.save(saved_game, "user://savegame.tres")



func _on_load_pressed() -> void:
	var saved_game:SavedGame = load("user://savegame.tres") as SavedGame
	
	player.global_position = saved_game.player_position
	player.HP = saved_game.player_health
	player.SPEED = saved_game.player_speed
	print(player.HP)
	print(player.SPEED)
