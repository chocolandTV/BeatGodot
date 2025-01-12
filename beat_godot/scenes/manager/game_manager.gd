extends Node
class_name Game_Manager

signal game_started()
signal game_resumed()
signal game_paused()
signal game_meta_broked()
signal game_godot_part_collected(value : int)
### VARS
var _is_game_running : bool = false
var _is_game_over : bool  = false
var _game_score : int = 0
var _game_godot_parts : int  = 0

var player_hud : Player_HUD
var player_menu : Menu
var _audio_manager : Audio_Manager

func _ready() -> void:
    _audio_manager = get_node("/root/Audio")
    
func new_game():
    _is_game_running = true
    _is_game_over = false
    _game_score = 0
    _game_godot_parts =0 
    game_started.emit()
######## PUBLICS
func is_game_running() ->bool :
    return _is_game_running
func is_game_over() -> bool : 
    return _is_game_over
#### RESUME GAME
func resume_game():
    game_resumed.emit()
    paused_game(false)

func paused_game(value :bool):
    if value:
        player_menu.game_paused()
        _is_game_running = !value
        game_paused.emit()
    else:
        game_resumed.emit()
    _is_game_running = !value

func start_game():
    _is_game_running = true
    
    game_started.emit()

func quit_game():
    get_tree().quit()

func player_scored(value : int):
    _audio_manager.play_random()
    _game_score +=value
    player_hud.update_player_score(_game_score)

func game_over():
    await get_tree().create_timer(2.0).timeout
    
    player_menu.update_game_over()
    player_hud.visible = false
    player_menu.visible   = true
    _is_game_running = false
    _is_game_over = true
func meta_game_progress():
    game_meta_broked.emit()

func meta_godot_part_collected():
    _game_godot_parts +=1
    game_godot_part_collected.emit(_game_godot_parts)

func check_godot_parts() -> bool:
    return _game_godot_parts >= 3
