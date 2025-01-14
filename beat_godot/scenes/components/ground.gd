extends Area2D

var _is_game_running : bool  =false

var _game_manager : Game_Manager

func _ready() -> void:
    _game_manager = get_node("/root/GameManager")

    _game_manager.game_started.connect(on_game_started)
    _game_manager.game_paused.connect(on_game_paused)
    _game_manager.game_resumed.connect(on_game_resumed)
func on_game_paused():
    _is_game_running = false
func on_game_started():
    _is_game_running = true

func on_game_resumed():
    _is_game_running = true

func on_game_restart():
    _is_game_running = true

