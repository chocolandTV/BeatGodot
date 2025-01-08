extends Node2D
class_name Bad_Raven
var bad_raven_speed : float = 900
var _start_pos : Vector2

signal cured()

func _ready() -> void:
    bad_raven_speed = randf_range(300, 700)
    _start_pos = global_position
func _process(delta: float) -> void:
    global_position.x -= bad_raven_speed * delta

func on_area_entered_respawn(_area : Area2D):
    print ("Respawn_ Enemy")
    global_position = _start_pos
    bad_raven_speed +=50
    cured.emit()