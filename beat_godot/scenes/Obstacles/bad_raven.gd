extends Area2D
class_name Bad_Raven
var bad_raven_speed : float = 900
signal hit 
signal scored

func _on_body_entered(_body):
    hit.emit()

func _on_score_entered(_body):
    scored.emit()

func _process(delta: float) -> void:
    global_position.x -= bad_raven_speed * delta