extends Area2D

@onready var mage_2: Area2D = $"."
var first_interaction : bool
var is_player_within_area: bool


func _ready() -> void:
	Dialogic.signal_event.connect(_on_dialogic_signal)

func _on_body_entered(body: Node2D) -> void:
	if body.name == "Player":
		is_player_within_area = true

func _on_body_exited(body: Node2D) -> void:
	if body.name == "Player":
		is_player_within_area = false

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("interact") and is_player_within_area and first_interaction == false:
		Dialogic.start("mage")
		first_interaction = true
		
	if event.is_action_pressed("interact") and is_player_within_area and first_interaction == true:
		Dialogic.end_timeline()
		
func _on_dialogic_signal(argument:String):
	if argument == "mage_joined":
		mage_2.hide()
