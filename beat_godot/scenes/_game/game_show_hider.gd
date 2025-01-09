extends Node2D
@onready var game_scene : Node2D = $Game_Content
var  _game_manager : Game_Manager
func _ready() -> void:
    _game_manager = get_node("/root/GameManager")
    _game_manager.game_started.connect(on_game_start)
    _game_manager.game_paused.connect(on_game_paused)
    _game_manager.game_resumed.connect(on_game_resume)
func on_game_start():
    game_scene.visible = true
func on_game_resume():
    game_scene.visible = true
func on_game_paused():
    game_scene.visible = false
