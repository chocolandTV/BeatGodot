extends Node2D
var bad_raven_speed : float = 700
var _game_manager : Game_Manager
@onready var _animatedsprite : AnimatedSprite2D =$AnimatedSprite2D
@onready var button : TextureButton =$TextureButton
func _ready() -> void:
    bad_raven_speed = randf_range(bad_raven_speed,bad_raven_speed*2)
    _game_manager = get_node("/root/GameManager")


func _process(delta: float) -> void:
    global_position.x -= bad_raven_speed * delta
    if global_position.x <= -1000:
        global_position.x = 2500

func on_game_started(value : bool):
    if value:
        queue_free()

func on_game_manager_added(game_manager : Game_Manager):
    game_manager.game_is_running.connect(on_game_started)

func on_died():
    button.visible = false
    var tween_dead = get_tree().create_tween()
    tween_dead.set_ease(Tween.EASE_IN)
    tween_dead.set_trans(Tween.TRANS_EXPO)
    tween_dead.tween_property(_animatedsprite,"modulate", Color.RED ,0.3)
    tween_dead.tween_property(_animatedsprite,"rotation",deg_to_rad(-90),1).as_relative()
    tween_dead.set_parallel()
    tween_dead.tween_property(_animatedsprite,"position",Vector2.DOWN * 1500,1).as_relative()
    tween_dead.tween_callback(queue_free).set_delay(5)
