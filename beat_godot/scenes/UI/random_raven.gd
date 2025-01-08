extends Node2D
var bad_raven_speed : float = 500

func _process(delta: float) -> void:
    global_position.x -= bad_raven_speed * delta
    if global_position.x <= -100:
        queue_free()