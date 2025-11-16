extends Node2D



func _process(delta: float) -> void:
	if !$AudioStreamPlayer2D.playing:
		$AudioStreamPlayer2D.play()
