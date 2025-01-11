extends CharacterBody2D

var run_speed = 200
var jump_speed = -400
const SPEED = 300.0
const JUMP_VELOCITY = -600.0


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
