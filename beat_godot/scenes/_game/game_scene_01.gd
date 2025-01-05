extends Node
class_name Game_Manager
### SIGNALS

signal game_is_running(value :bool)

### CONST
const SCROLL_SPEED : float  = 8.0
const PIPE_DELAY : float  = 100.0
const PIPE_RANGE: float = 200.0
### VARS
var _is_game_running : bool = false
var _is_game_over : bool  = false
var _scroll = 0
var _game_score : int = 0
var game_paused : bool = false
var _current_player_life: int = 3
var _current_player_invincible:  bool = false
@export var player_beatrii : CharacterBody2D
@export var ground_object : Node2D
@export var player_hud : Player_HUD
@export var player_menu : Menu

func _ready() -> void:
    get_node("/root/GlobalData").SET_GAMEMANAGER(self)
    new_game()


func new_game():
    ### RESET ALL VARIABLES
    _current_player_life = 3
    _is_game_running = false
    _is_game_over = false
    _game_score = 0
    _scroll = 0
    player_beatrii.reset()


func _input(event: InputEvent) -> void:
    if !_is_game_over:
        if event.is_action_pressed("fly") and player_beatrii.is_flying:
            player_beatrii.flap()
        if event.is_action_pressed("escape") and  !_is_game_running and !game_paused:
            print("game started")
            start_game()
        if event.is_action_pressed("escape") and _is_game_running:
            ### GAME PAUSED
             game_paused = true
             paused_game(game_paused)
        if event.is_action_pressed("escape") and game_paused:
            game_paused = false
            paused_game(game_paused)

func paused_game(value :bool):
    player_hud.visible = !value
    player_menu.visible  =value
    player_beatrii.is_flying = !value
    game_is_running.emit(!value)
    _is_game_running = !value

func start_game():
    game_is_running.emit(true)
    player_hud.visible = true
    player_menu.visible  =false
    _is_game_running = true
    player_beatrii.is_flying = true
    player_beatrii.flap()

func quit_game():
    get_tree().quit()

func _process(_delta: float) -> void:
    if _is_game_running:
        _scroll += SCROLL_SPEED
        #reset
        if _scroll >= 4096:
            _scroll =0
        #object move
        ground_object.position.x = -_scroll
########### PLAYER KILLED HEALTH COMPONENT
func player_progress_lifehack():
    _current_player_invincible = true

func player_scored():
    _game_score +=1
    get_node("/root/GlobalData").SET_PLAYER_SCORE(_game_score)
    # UI UPDATE
    get_node("/root/GlobalData").player_hud.update_player_score(_game_score)
func game_over():
    #### Check Life
    _current_player_life -= 1
    get_node("/root/GlobalData").player_life =_current_player_life
    get_node("/root/GlobalData").player_hud.update_player_life(_current_player_life)
    if _current_player_life <= 0 and !_current_player_invincible:
        game_is_running.emit(false)
        player_hud.visible = false
        player_menu.visible   = true
        player_beatrii.is_flying = false
        player_beatrii.is_falling = true
        _is_game_running = false
        _is_game_over = true
        #show game_over menu