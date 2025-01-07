extends Area2D
class_name Bad_Raven
var bad_raven_speed : float = 900
signal hit 
signal scored
@onready var particle_01 : CPUParticles2D =$Raven_obstacle_01/CPUParticles2D
@onready var particle_02: CPUParticles2D = $Raven_obstacle_02/CPUParticles2D2

func _on_body_entered(_body):
    hit.emit()

func _on_score_entered(_body):
    scored.emit()

func _process(delta: float) -> void:
    global_position.x -= bad_raven_speed * delta