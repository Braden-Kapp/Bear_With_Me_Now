extends CharacterBody2D

@export var startPosition: Vector2
@export var endPosition: Vector2
@export var speed: float = 700.0

@onready var collisionShape = $CollisionShape2D
@onready var sprite = $Sprite2D

var direction := 1

func _ready():
	position = startPosition

func _physics_process(delta):

	var moveVec = (endPosition - startPosition).normalized()
	position += moveVec * speed * direction * delta

	if direction == 1 and (position - startPosition).dot(endPosition - startPosition) >= (endPosition - startPosition).length_squared():
		position = endPosition
		direction = -1
	elif direction == -1 and (position - endPosition).dot(startPosition - endPosition) >= (startPosition - endPosition).length_squared():
		position = startPosition
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
	if parent.name == "PandaBearDemo":
		_breakBamboo()
		await get_tree().create_timer(2.0).timeout
		_remakeBamboo()
