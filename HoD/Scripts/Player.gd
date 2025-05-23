extends CharacterBody2D

var HP = 100
var run_speed = 200
var jump_speed = -400
var SPEED = 300.0
const JUMP_VELOCITY = -600.0
var is_paused : bool


@onready var interact_ui = $InteractUI
@onready var inventory_ui = $InventoryUI
@onready var inventory_hotbar = $Inventory_Hotbar
@onready var shopInterac_ui = $InteractUI2
@onready var money = $InventoryUI/ColorRect/Cost
@onready var player = $"."



var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

func _ready():
	Global.set_player_reference(self)
	Dialogic.signal_event.connect(_on_dialogic_signal)
	Dialogic.timeline_started.connect(set_physics_process.bind(false)) 
	Dialogic.timeline_started.connect(set_process_input.bind(false)) 
	
	Dialogic.timeline_ended.connect(set_physics_process.bind(true))
	Dialogic.timeline_ended.connect(set_process_input.bind(true))
	
	
func _on_dialogic_signal(argument:String):
	if argument == "dialog_started":
		velocity.x = 0
		$AnimatedSprite2D.play("Idle")
		



func _physics_process(delta):
	velocity.y += delta * gravity
	
	var direction = Input.get_axis("ui_left", "ui_right")
	
	if Input.is_action_pressed("ui_left"):
		$AnimatedSprite2D.flip_h = true
		$AnimatedSprite2D.play("Run")
		velocity.x = direction * SPEED
		
	elif Input.is_action_pressed("ui_right"):
		$AnimatedSprite2D.flip_h = false
		$AnimatedSprite2D.play("Run")
		velocity.x = direction * SPEED
		
	elif Input.is_action_just_released("ui_right"):
		$AnimatedSprite2D.play("Idle")
		velocity.x = 0
	elif Input.is_action_just_released("ui_left"):
		$AnimatedSprite2D.play("Idle")
		velocity.x = 0
	move_and_slide()
	
func _input(event):
		
	if  event.is_action_pressed("pause_menu"):
		velocity.x = 0
		$AnimatedSprite2D.play("Idle")
		
	if event.is_action_pressed("interact"):
		velocity.x = 0
		$AnimatedSprite2D.play("Idle")
	
	if event.is_action_pressed("ui_inventory"):
		inventory_ui.visible = !inventory_ui.visible
		inventory_hotbar.visible = !inventory_hotbar.visible
		player.visible = !player.visible
		
		
func apply_item_effect(item):
	match item["effect"]:
		"Stamina":
			if SPEED < 300:
				SPEED += 10.0
				print("Speed increased to ", SPEED)
			if SPEED >= 300:
				SPEED = 300
				print(SPEED)
		"Healing":
			if HP < 100:
				HP += 10
				print("HP increase to ", HP)
			if HP >= 100:
				HP = 100
				print(HP)
		"dagger":
			if SPEED > 0 and  SPEED < 300:
				SPEED -= 30
				print("Speed: ", SPEED)
			if SPEED <= 0:
				SPEED = 0
				print(SPEED)
		_:
			print("There is no effect for this item")

func use_hotbar_item(slot_index):
	if slot_index < Global.hotbar_inventory.size():
		var item = Global.hotbar_inventory[slot_index]
		if item != null:
			apply_item_effect(item)
			item["quantity"] -= 1
			if item["quantity"] <= 0:
				Global.hotbar_inventory[slot_index] = null
				Global.remove_item(item["type"], item["effect"])
			Global.inventory_updated.emit()

func _unhandled_input(event):
	if event is InputEventKey and event.pressed:
		for i in range(Global.hotbar_size):
			if Input.is_action_just_pressed("hotbar_" + str(i + 1)):
				use_hotbar_item(i)
				break
