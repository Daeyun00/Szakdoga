extends Control

var database : SQLite

func _ready():
	database = SQLite.new()
	database.path = "res://data.db"
	database.open_db()


func _on_insertdata_button_down() -> void: #adat adása 
	var data = {
		"name": $Name.text,
		"score": int($Score.text)
	}
	database.insert_row("players", data)


func _on_selectdata_button_down() -> void: #select metod 3 cuccli 1. tábla 2. feltétel 3. mit adjon vissza
	print(database.select_rows("players", "score > 10", ["*"]))


func _on_updatedata_button_down() -> void:
	database.update_rows("players", "name = '" + $Name.text + "'", {"score": int($Score.text), "name":"Mark"})


func _on_deletedata_button_down() -> void:
	database.delete_rows("players", "name = '" + $Name.text + "'")


func _on_custom_select_button_down() -> void: #sql lekérdezés
	database.query("select * from players join playerInfo on playerInfo.id = players.playerinfoid where score > " + $Score.text)
	for i in database.query_result:
		print(i)


func _on_create_table_button_down() -> void:
	var table = {
		"id": {"data_type":"int", "primary_key": true, "not_null": true, "auto_increment": true},
		"name":{"data_type":"text"},
		"score":{"data_type":"int"}
	}
	database.create_table("players", table)


func _on_store_player_image_button_down() -> void:
	var image := preload("res://Assets/Wooden UI/Items/Stamina Potion.png")
	var pba = image.get_image().save_png_to_buffer()
	database.update_rows("players", "name = 'laura'", {"picture" : pba})



	
