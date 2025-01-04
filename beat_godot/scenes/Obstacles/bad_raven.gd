extends Area2D
@export var bad_raven_speed : float = 250
signal hit 
signal score

func _on_body_entered(_body):
    hit.emit()

func _on_score_entered(_body):
    score.emit()

func _process(delta: float) -> void:
    global_position.x -= bad_raven_speed * delta