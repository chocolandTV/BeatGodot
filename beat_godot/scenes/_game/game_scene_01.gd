extends Node2D
### SIGNALS
signal game_over()
### CONST
const SCROLL_SPEED : float  = 4.0
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

@onready var player_beatrii : CharacterBody2D = %Player

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
    if !game_over:
        if event.is_action_pressed("dash"):
            dashing()

# func get_movement_vector():
# 	var x_movement = Input.get_action_strength("move_right") - Input.get_action_strength("move_left")
# 	var y_movement = Input.get_action_strength("move_down") - Input.get_action_strength("move_up")
# 	return Vector2(x_movement, y_movement)