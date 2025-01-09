extends Node2D
class_name Bad_Raven
var bad_raven_speed : float = 900
var _start_pos : Vector2
var  _game_manager : Game_Manager
signal cured()

func _ready() -> void:
    _game_manager = get_node("/root/GameManager")
    bad_raven_speed = randf_range(300, 700)
    _start_pos = global_position
    _game_manager.game_restarted.connect(on_game_restart)

func _process(delta: float) -> void:
    global_position.x -= bad_raven_speed * delta

func on_area_entered_respawn(_area : Area2D):
    print ("Respawn_ Enemy")
    global_position = _start_pos
    bad_raven_speed +=50
    cured.emit()

func on_game_restart():
    queue_free()