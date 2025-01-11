extends Area2D
class_name Player_Attack
@export var camera : Camera2D
@export var hearth_color : Color
@onready var cooldown_timer : Timer = $Cooldown_timer
@onready var animator : AnimationPlayer = $AnimationPlayer
@onready var sprite : Sprite2D =$Sprite2D

var damage : int = 1
var new_attack_sprite : Texture2D = preload("res://assets/textures/mouse_cursor_02.png")
var _is_cooldown : bool  = false
var _is_attacking : bool =false
func _ready() -> void:
    cooldown_timer.timeout.connect(on_timer_timeout)
    get_node("/root/GameManager").game_meta_broked.connect(on_metagame_update)

##### NEW UPDATE FUNCTION
func _physics_process(_delta: float) -> void:
    get_pos_dir_target()
    if _is_attacking:
        animator.play("attack")

func _input(event: InputEvent) -> void:
    if event.is_action_pressed("left_click"):
        if !_is_cooldown:
            _is_attacking = true
            _is_cooldown = true

    if event.is_action_released("left_click"):
        _is_attacking = false

func on_timer_timeout():
    _is_cooldown =false

func on_metagame_update():
    sprite.texture = new_attack_sprite
    sprite.modulate = hearth_color
    set_collision_layer_value(6,false)
    set_collision_layer_value(8, true)

func _on_animation_player_animation_finished(_anim_name:StringName) -> void:
    animator.play("RESET")

func get_pos_dir_target():
    var mouse_position:Vector2 = camera.get_local_mouse_position() +camera.global_position
    global_position = mouse_position

    var direction = global_position - mouse_position
    rotation = direction.angle()