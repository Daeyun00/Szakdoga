extends CharacterBody2D

var run_speed = 200
var jump_speed = -400
var SPEED = 300.0
const JUMP_VELOCITY = -600.0

@onready var interact_ui = $InteractUI
@onready var inventory_ui = $InventoryUI


var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

func _ready():
	Global.set_player_reference(self)


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
	if event.is_action_pressed("ui_inventory"):
		inventory_ui.visible = !interact_ui.visible
		get_tree().paused = !get_tree().paused

func apply_item_effect(item):
	match item["effect"]:
		"Stamina":
			SPEED += 50.0
			print("Speed increased to ", SPEED)
		"Slot Boost":
			Global.increase_inventory_size(5)
			print("Slots increased to ", Global.inventory.size())
		_:
			print("There is no effect for this item")
