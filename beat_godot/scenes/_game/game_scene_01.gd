extends Node2D
### SIGNALS

signal game_start()

### CONST
const SCROLL_SPEED : float  = 8.0
const PIPE_DELAY : float  = 100.0
const PIPE_RANGE: float = 200.0
### VARS
var is_game_running : bool = false
var is_game_over : bool  = false
var scroll = 0
var game_score : int = 0
var screen_size  : Vector2i
var ground_height : int
var pipes: Array

@export var player_beatrii : CharacterBody2D
@export var ground_object : Node2D

func _ready() -> void:
    new_game()

func new_game():
    ### RESET ALL VARIABLES
    is_game_running = false
    is_game_over = false
    game_score = 0
    scroll = 0
    player_beatrii.reset()


func _input(event: InputEvent) -> void:
    if !is_game_over:
        if event.is_action_pressed("fly") and player_beatrii.is_flying:
            player_beatrii.flap()
        if event.is_action_pressed("escape") and  !is_game_running:
            print("game started")
            start_game()

# func get_movement_vector():
# 	var x_movement = Input.get_action_strength("move_right") - Input.get_action_strength("move_left")
# 	var y_movement = Input.get_action_strength("move_down") - Input.get_action_strength("move_up")
# 	return Vector2(x_movement, y_movement)

func start_game():
    game_start.emit()
    is_game_running = true
    player_beatrii.is_flying = true
    player_beatrii.flap()

func _process(_delta: float) -> void:
    if is_game_running:
        scroll += SCROLL_SPEED
        #reset
        if scroll >= 4096:
            scroll =0
        #object move
        ground_object.position.x = -scroll

