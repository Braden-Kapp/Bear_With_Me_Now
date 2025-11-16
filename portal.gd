extends Area2D

@export var pandaDestination: Node2D
@export var polarDestination: Node2D

func _ready():
	body_entered.connect(_on_body_entered)

func _on_body_entered(body: Node2D) -> void:
	if body.name == "PandaBearDemo" or body.name == "PolarBearDemo":
		_teleport_both()

func _teleport_both():
	var scene_root = get_tree().current_scene
	var panda := scene_root.get_node_or_null("PandaBearDemo")
	var polar := scene_root.get_node_or_null("PolarBearDemo")
	
	if panda and polar and pandaDestination and polarDestination:
		panda.global_position = pandaDestination.global_position
		polar.global_position = pandaDestination.global_position
