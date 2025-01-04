extends Node2D
### SIGNALS

signal game_start()

### CONST
const SCROLL_SPEED : float  = 8.0
const PIPE_DELAY : float  = 100.0
const PIPE_RANGE: float = 200.0
### VARS
var _is_game_running : bool = false
var _is_game_over : bool  = false
var _scroll = 0
var game_score : int = 0
@export var player_beatrii : CharacterBody2D
@export var ground_object : Node2D

func _ready() -> void:
    new_game()


func new_game():
    ### RESET ALL VARIABLES
    _is_game_running = false
    _is_game_over = false
    game_score = 0
    _scroll = 0
    player_beatrii.reset()


func _input(event: InputEvent) -> void:
    if !_is_game_over:
        if event.is_action_pressed("fly") and player_beatrii.is_flying:
            player_beatrii.flap()
        if event.is_action_pressed("escape") and  !_is_game_running:
            print("game started")
            start_game()

# func get_movement_vector():
# 	var x_movement = Input.get_action_strength("move_right") - Input.get_action_strength("move_left")
# 	var y_movement = Input.get_action_strength("move_down") - Input.get_action_strength("move_up")
# 	return Vector2(x_movement, y_movement)

func start_game():
    game_start.emit()
    _is_game_running = true
    player_beatrii.is_flying = true
    player_beatrii.flap()

func _process(_delta: float) -> void:
    if _is_game_running:
        _scroll += SCROLL_SPEED
        #reset
        if _scroll >= 4096:
            _scroll =0
        #object move
        ground_object.position.x = -_scroll

func player_scored():
    game_score +=1
    # UI UPDATE

func game_over():
    player_beatrii.is_flying = false
    player_beatrii.is_falling = true
    _is_game_running = false
    _is_game_over = true
    #show game_over menu