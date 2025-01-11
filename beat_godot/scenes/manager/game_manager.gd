extends Node
class_name Game_Manager

signal game_restarted()
signal game_started()
signal game_resumed()
signal game_paused()
signal game_meta_broked()
signal game_godot_part_collected()
### VARS
var _is_game_running : bool = false
var _is_game_over : bool  = false
var _game_score : int = 0
var _game_godot_parts : int  = 0
var real_game_score : int  = 0
var player_hud : Player_HUD
var player_menu : Menu

func new_game():
    _is_game_running = false
    _is_game_over = false
    _game_score = 0
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
    player_hud.visible = !value
    player_menu.visible  =value
    if value:
        player_menu.game_paused()
        game_paused.emit()
    else:
        game_resumed.emit()
    _is_game_running = !value

func start_game():
    player_hud  = get_node("/root/GlobalData").player_hud
    player_menu  =get_node("/root/GlobalData").menu
    player_hud.visible = true
    player_menu.visible  =false
    _is_game_running = true
    
    game_started.emit()

func restart_game():
    player_hud  = get_node("/root/GlobalData").player_hud
    player_menu  =get_node("/root/GlobalData").menu
    player_hud.visible = true
    player_menu.visible  =false
    _is_game_running = true
    player_hud.update_player_life(3)
    player_hud.update_player_score(0)
    _game_score = 0
    game_restarted.emit()

func quit_game():
    get_tree().quit()

func player_scored():
    _game_score +=1000
    get_node("/root/GlobalData").player_hud.update_player_score(_game_score)
func game_over():
    await get_tree().create_timer(2.0).timeout
    player_hud  = get_node("/root/GlobalData").player_hud
    player_menu  =get_node("/root/GlobalData").menu
    get_node("/root/GlobalData").menu.update_game_over()
    player_hud.visible = false
    player_menu.visible   = true
    _is_game_running = false
    _is_game_over = true
func meta_game_progress():
    game_meta_broked.emit()

func meta_godot_part_collected():
    _game_godot_parts +=1
    game_godot_part_collected.emit()

func check_godot_parts() -> bool:
    return _game_godot_parts >= 3
