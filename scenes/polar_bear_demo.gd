extends CharacterBody2D

@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D

const SPEED = 800.0
const JUMP_VELOCITY = -1300.0
const MAX_JUMP_VELOCITY = -2500.0
var bigJumpin = false


func _physics_process(delta: float) -> void:
	if is_on_floor():
		bigJumpin = false
	
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * 2.0 * delta

	# Handle jump.
	if Input.is_action_just_pressed("jumpPolar") and is_on_floor():
		velocity.y = JUMP_VELOCITY
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction := Input.get_axis("leftPolar", "rightPolar")
	if direction:
		velocity.x = direction * SPEED
		if(not bigJumpin):
			if Input.is_action_pressed("rightPolar"):
				if is_on_floor():
					animated_sprite.play("rightPolar")
				else:
					animated_sprite.play("rightJumpPolar")
			if Input.is_action_pressed("leftPolar"):
				if is_on_floor():
					animated_sprite.play("leftPolar")
				else:
					animated_sprite.play("leftJumpPolar")
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		if(not bigJumpin):
			animated_sprite.play("standingPolar")

		
	if is_on_floor():
		_large_jump(delta)
	
	move_and_slide()
func _large_jump(delta: float):
	if Input.is_action_pressed("bigjumpPolar"):
		animated_sprite.play("bigJumpPolar")
	if Input.is_action_just_released("bigjumpPolar"):
		velocity.y =  MAX_JUMP_VELOCITY
		bigJumpin = true
		animated_sprite.play("whileBigJump")
