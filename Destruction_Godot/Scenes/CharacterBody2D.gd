extends CharacterBody2D


const max_spd = 120
const accel = 800
const friction = 500

var blend_position: Vector2 = Vector2.ZERO





func _physics_process(delta):
	move(delta)

func move(delta):
	var input_vector = Input.get_vector("moveLeft", "moveRight", "moveUp", "moveDown")
	if input_vector == Vector2.ZERO:
		applyFriction(friction * delta)
	else:
		applyMovement(input_vector * accel * delta)
		blend_position = input_vector
		pass
	move_and_slide()
	
func applyFriction(amount) -> void:
	if velocity.length() > amount:
		velocity -= velocity.normalized() * amount
	else:
		velocity = Vector2.ZERO

func applyMovement(amount) -> void:
	velocity += amount
	velocity = velocity.limit_length(max_spd)

