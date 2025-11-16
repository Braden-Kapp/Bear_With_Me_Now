extends CharacterBody2D
 
@export var startPosition: Vector2
@export var endPosition: Vector2
@export var speed: float = 200.0

@onready var collisionShape = $CollisionShape2D
@onready var sprite = $Sprite2D
#Can Set Start/End/Speed in Inspector
var direction := 1

func _ready():
	position = startPosition

func _physics_process(delta):
	# Move platform
	position.x += speed * direction * delta
	if position.x >= endPosition.x:
		position.x = endPosition.x
		direction = -1
	elif position.x <= startPosition.x:
		position.x = startPosition.x
		direction = 1
		

func _breakBamboo():
	if collisionShape:
		collisionShape.set_deferred("disabled", true)
	if sprite:
		sprite.visible = false
func _remakeBamboo():
	if collisionShape:
		collisionShape.set_deferred("disabled", false)
	if sprite:
		sprite.visible = true

func _on_area_2d_area_entered(area: Area2D) -> void:
	var parent = area.get_parent()
	if parent.name == "PolarBearDemo":
		_breakBamboo()
		await get_tree().create_timer(2.0).timeout
		_remakeBamboo()
