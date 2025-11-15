extends StaticBody2D

@export var next_camera: Camera2D
@export var gate_open_distance: float = 200.0

var pandaNearby := false
var polarNearby := false
var isOpen := false

@onready var collisionShape = $CollisionShape2D
@onready var sprite = $Sign
@onready var detectionArea = $DetectionArea

func _ready() -> void:
	if detectionArea:
		detectionArea.area_entered.connect(_on_detection_area_entered)
		detectionArea.area_exited.connect(_on_detection_area_exited)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _on_detection_area_entered(area: Area2D) -> void:
	var parent = area.get_parent()
	if parent.name == "PandaBearDemo":
		pandaNearby = true
		print("pandaNearby")
	elif parent.name == "PolarBearDemo":
		polarNearby = true
		print("polarNearby")
	_check_both_bears()

func _on_detection_area_exited(area: Area2D) -> void:
	var parent = area.get_parent()
	if parent.name == "PandaBearDemo":
		pandaNearby = false
	elif parent.name == "PolarBearDemo":
		polarNearby = false
	
func _check_both_bears():
	if pandaNearby and polarNearby and not isOpen:
		_open()

func _open():
	isOpen = true
	if collisionShape:
		collisionShape.set_deferred("disabled", true)
	
	await get_tree().create_timer(0.5).timeout
	_switch_camera()
	
func _switch_camera():
	if next_camera:
		
		# Get whichever camera is currently active in the game
		var current_cam = get_viewport().get_camera_2d()
		if current_cam:
			current_cam.enabled = false
		
		next_camera.enabled = true
