extends Area2D
@export var camera : Camera2D
@export var hearth_color : Color
@onready var cooldown_timer : Timer = $Cooldown_timer
@onready var animator : AnimationPlayer = $AnimationPlayer
@onready var sprite : Sprite2D =$Sprite2D
@onready var hit_box : Hitbox_Component =$HitBox_Component
var damage : int = 1
var new_attack_sprite : Texture2D = preload("res://assets/textures/hearth_attack.png")
var _is_clicked : bool  =false
var _is_cooldown : bool  = false
func _ready() -> void:
    cooldown_timer.timeout.connect(on_timer_timeout)

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

func on_metagame_update():
    sprite.texture = new_attack_sprite
    sprite.modulate = hearth_color
    hit_box.visible = true