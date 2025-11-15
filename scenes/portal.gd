extends Area2D

@export var target_portal: Area2D

var panda_inside := false
var polar_inside := false

func _ready():
	area_entered.connect(_on_area_2d_area_entered)
	area_exited.connect(_on_area_2d_area_exited)
	
func _check_teleport() -> void:
	if panda_inside and polar_inside:
		_teleport_both()

func _teleport_both():
	var scene_root = get_tree().current_scene
	var panda := scene_root.get_node_or_null("PandaBearDemo")
	var polar := scene_root.get_node_or_null("PolarBearDemo")
	
	if panda and polar and target_portal:
		var panda_dest = target_portal.get_node_or_null("PandaDestination")
		var polar_dest = target_portal.get_node_or_null("PolarDestination")
		
		if panda_dest and polar_dest:
			panda.global_position = panda_dest.global_position
			polar.global_position = polar_dest.global_position

func _on_area_2d_area_entered(area: Area2D) -> void:
	var parent = area.get_parent()
	if parent.name == "PandaBearDemo":
		panda_inside = true
	elif parent.name == "PolarBearDemo":
		polar_inside = true
	_check_teleport()

func _on_area_2d_area_exited(area: Area2D) -> void:
	var parent = area.get_parent()
	if parent.name == "PandaBearDemo":
		panda_inside = false
	elif parent.name == "PolarBearDemo":
		polar_inside = false
