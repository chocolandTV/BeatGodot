extends CharacterBody2D
class_name Godot_Engine_Part

@onready var anim_player : AnimationPlayer = $AnimationPlayer
@onready var timer : Timer =$Flap_Timer
@onready var health_comp: Health_Component = $Health_Component
@onready var particles : CPUParticles2D = $CPUParticles2D
var _is_done : bool = false
const  GRAVITY : int = 980
const MAX_VEL : int = 1200
const FLAP_SPEED : int = -700
const SPEED  : int  =350
### var  animation
### on death - > collect -> queue_free
### func _process movement like player  but -
### on timer timeout flap +anim rotate + particle
func _ready() -> void:
    timer.timeout.connect(flap)
    health_comp.died.connect(_on_died_collect_part)

func _physics_process(delta: float) -> void:
        velocity.y += GRAVITY * delta
        velocity.x -= SPEED * delta
        if velocity.y > MAX_VEL:
            velocity.y = MAX_VEL
            set_rotation(deg_to_rad(velocity.y *0.05   ))
        move_and_collide(velocity * delta)

func _on_died_collect_part():
    print("godot_part_collected")
    if !_is_done:
        _is_done =true
        set_rotation(PI/2)
        anim_player.stop()
        get_node("/root/GameManager").meta_godot_part_collected()
        queue_free()

func flap():
    velocity.y = FLAP_SPEED
    particles.emitting = true
    anim_player.play("rotate")
func on_respawner_entered(_area : Area2D):
    queue_free()