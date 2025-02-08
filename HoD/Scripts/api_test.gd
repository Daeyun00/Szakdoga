extends Control

@onready var http_request = $Button/HTTPRequest
@onready var rich_text_lkabel = $RichTextLabel

var url = "https://meowfacts.herokuapp.com/"

func _on_button_pressed():
	http_request.request(url)


func _on_http_request_request_completed(result: int, response_code: int, headers: PackedStringArray, body: PackedByteArray):
	var data = JSON.parse_string(body.get_string_from_utf8())
	print(data.data[0])
	var cat_fact = data.data[0]
	rich_text_lkabel.text = cat_fact
