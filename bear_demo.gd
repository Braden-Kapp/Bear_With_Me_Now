extends CharacterBody2D
class_name PandaBearDemo
@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D
const SPEED = 1200.0
const JUMP_VELOCITY = -1300.0
const MAX_JUMP_VELOCITY = -1800.0
var in_grab_area = false
var grabbin = false
var grab_left = false
var grab_right = false

func _physics_process(delta: float) -> void:
	
	in_grab_area = grab_left or grab_right
	if in_grab_area:
		_grab()
	else:
		grabbin = false
	# Add the gravity.
	if not is_on_floor():
		if not grabbin:
			velocity += get_gravity() * 2.0 * delta

	# Handle jump.
	if Input.is_action_just_pressed("jumpPanda") and is_on_floor():
		velocity.y = JUMP_VELOCITY
	# Get the input direction and handle the movement/deceleration.
	if not grabbin:
		var direction := Input.get_axis("leftPanda", "rightPanda")
		if direction:
			velocity.x = direction * SPEED
			if Input.is_action_pressed("rightPanda"):
				if is_on_floor():
					animated_sprite.play("rightPanda")
				else:
					animated_sprite.play("rightJumpPanda")
			if Input.is_action_pressed("leftPanda"):
				if is_on_floor():
					animated_sprite.play("leftPanda")
				else:
					animated_sprite.play("leftJumpPanda")
		else:
			velocity.x = move_toward(velocity.x, 0, SPEED)
			animated_sprite.play("standPanda")
			
	
	move_and_slide()

	

func _on_left_grab_area_2d_area_entered(area: Area2D) -> void:
	grab_left = true

func _on_right_grab_area_2d_area_entered(area: Area2D) -> void:
	grab_right = true
	
func _on_left_grab_area_2d_area_exited(area: Area2D) -> void:
	grab_left = false

func _on_right_grab_area_2d_area_exited(area: Area2D) -> void:
	grab_right = false
	#change sprites for grab func
func _grab():
	if Input.is_action_pressed("grabPanda"):
		grabbin = true
		velocity = Vector2.ZERO  # stop movement completely
		
		if grab_right:
			animated_sprite.play("grabRightPanda")
		elif grab_left:
			animated_sprite.play("grabLeftPanda")
	if Input.is_action_just_released("grabPanda"):
		grabbin = false
