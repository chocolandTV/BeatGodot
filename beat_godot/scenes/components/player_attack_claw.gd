extends Area2D
@export var camera : Camera2D

@onready var cooldown_timer : Timer = $Cooldown_timer
@onready var animator : AnimationPlayer = $AnimationPlayer
var _is_clicked : bool  =false
var _is_cooldown : bool  = false

func _input(event: InputEvent) -> void:
    if event.is_action_pressed("left_click"):
         _is_clicked = true
         if _is_clicked and !_is_cooldown:
            global_position = camera.get_local_mouse_position() + camera.global_position
            print("Position: ",camera.get_local_mouse_position() + camera.global_position)
            animator.play("attack")

         _is_cooldown = true
         cooldown_timer.start()

    if event.is_action_released("left_click"):
        _is_clicked = false

func on_timer_timeout():
    _is_cooldown =false