extends Node2D
var bad_raven_speed : float = 700

func _ready() -> void:
    bad_raven_speed = randf_range(bad_raven_speed,bad_raven_speed*2)

func _process(delta: float) -> void:
    global_position.x -= bad_raven_speed * delta
    if global_position.x <= -100:
        queue_free()