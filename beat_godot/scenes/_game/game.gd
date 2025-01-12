extends Node2D
var _game_manager  : Game_Manager
@export var game_content_node : Node2D

func _ready() -> void:
    _game_manager = get_node("/root/GameManager")
    _game_manager.new_game()
    _game_manager.game_resumed.connect(on_game_resume_button)
func _input(event: InputEvent) -> void:
    if event.is_action_pressed("escape") and _game_manager.is_game_running():
            on_game_paused()
    elif event.is_action_pressed("escape") and _game_manager.is_game_paused():
            on_game_resumed()

func on_game_paused():
    _game_manager.paused_game(true)
    game_content_node.visible = false
    get_tree().paused = true

func on_game_resumed():
    _game_manager.paused_game(false)
    game_content_node.visible = true
    get_tree().paused = false

func on_game_resume_button():
    game_content_node.visible = true
    get_tree().paused = false