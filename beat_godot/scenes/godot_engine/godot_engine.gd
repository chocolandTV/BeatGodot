extends Node2D
class_name enemy_godot
var badbirds_scene = preload ("res://scenes/Obstacles/bad_raven.tscn")
### VARIABLES

@onready var timer : Timer  =$Timer
@export var ground_collider_0 : Area2D
@export var ground_collider_1: Area2D
@export var ground_collider_2: Area2D
## score update
@export var player_hud : Player_HUD

var bad_ravens_array : Array
var difficult : float  = 1
### CONST
const MAX_BAD_BIRDS : int  =20
const START_POS : Vector2 = Vector2(1096,0)
const HEIGH_MIN_MAX : Vector2 = Vector2(-1600.0, 1250.0)
const SPAWN_HEIGHT : float  = 100
const DIFICULT_STEP : int  =1
func _ready() -> void:
    timer.timeout.connect(on_timer_timeout)
    ground_collider_0.hit.connect(player_bird_hit)
    ground_collider_1.hit.connect(player_bird_hit)
    ground_collider_2.hit.connect(player_bird_hit)
    get_node("/root/GlobalData").game_manager.game_is_running.connect(switch_game_state)

func on_timer_timeout():
    generate_obstacles()
    ############ DIFICULT CHECK
    difficult += 1
    if difficult == DIFICULT_STEP and timer.wait_time != 0.0:
        timer.wait_time -=0.5
        difficult  = 0
        print("dificult increased")
        get_node("/root/GlobalData").player_hud.godot_anim_play_dificult()

func generate_obstacles():
    if bad_ravens_array.size()> MAX_BAD_BIRDS:
        bad_ravens_array[0].queue_free()
        bad_ravens_array.remove_at(0)

    # delete after stack is full ?
    var new_bad_ravens = badbirds_scene.instantiate()
    new_bad_ravens.global_position.x = START_POS.x

    # need calibrate
    new_bad_ravens.global_position.y = randf_range(-SPAWN_HEIGHT, SPAWN_HEIGHT)
    new_bad_ravens.hit.connect(player_bird_hit)
    new_bad_ravens.scored.connect(player_scored)

    # add to array
    bad_ravens_array.append(new_bad_ravens)
    add_child(new_bad_ravens)
    
func player_bird_hit():
    get_node("/root/Audio").play_hit()
    _game_over()
func player_scored():
    get_node("/root/Audio").play_random()
    get_node("/root/GlobalData").game_manager.player_scored()

func _game_over():
    timer.stop()
    get_node("/root/GlobalData").game_manager.game_over()

func switch_game_state(value :bool):
    if value:
        timer.start()
    else:
        timer.stop()