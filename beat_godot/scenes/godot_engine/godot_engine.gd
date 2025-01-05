extends Node2D
class_name enemy_godot
var badbirds_scene = preload ("res://scenes/Obstacles/bad_raven.tscn")
### VARIABLES

@onready var timer : Timer  =$Timer
@export var ground_collider_0 : Area2D
@onready var animation_sprite : AnimatedSprite2D =$Godot_BG/AnimatedSprite2D
@onready var animation_particle: CPUParticles2D = $Godot_BG/AnimatedSprite2D/Particle_damaged
## score update
@export var player_hud : Player_HUD

var bad_ravens_array : Array
var difficult : float  = 1
var _wait_time : float = 4
### CONST
const MAX_BAD_BIRDS : int  =100
const START_POS : Vector2 = Vector2(1096,0)

const SPAWN_HEIGHT : float  = 200
const DIFFICULT_STEP : int  =1
########### ENDGAME 
var is_godot_highlighted :bool = false
var item_clicked : int = 0
func _ready() -> void:
    timer.timeout.connect(on_timer_timeout)
    ground_collider_0.hit.connect(player_bird_hit)
    get_node("/root/GlobalData").game_manager.game_is_running.connect(switch_game_state)

func on_timer_timeout():
    generate_obstacles()
    ############ DIFICULT CHECK
    difficult += 1
    if difficult >= DIFFICULT_STEP and _wait_time != 0.0:
        _wait_time =  max(0.5,_wait_time - 0.5)
        timer.wait_time = _wait_time
        difficult  = 0
        if item_clicked >= 1:
            get_node("/root/GlobalData").player_hud.godot_anim_play_endgame()
        else:
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
    if !get_node("/root/GlobalData").game_manager.current_player_invincible:
        get_node("/root/Audio").play_hit()
        health_changed()
func player_scored():
    if randi_range(0,100):
        get_node("/root/Audio").play_random()
    get_node("/root/GlobalData").game_manager.player_scored()

func health_changed():
    timer.stop()
    get_node("/root/GlobalData").game_manager.game_over()

func switch_game_state(value :bool):
    if value:
        timer.start()
    else:
        timer.stop()

func _input(event: InputEvent) -> void:
        if event.is_action_pressed("left_click") and  is_godot_highlighted:
            item_clicked += 1
            print("click 1")
            get_node("/root/Audio").play_random()
            if item_clicked >= 10:
                get_node("/root/GlobalData").player_hud.update_metagame(1)
                animation_sprite.play_terrifiered()
                animation_particle.emitting = true
                #update ui item 1
            if item_clicked >= 20:
                get_node("/root/GlobalData").player_hud.update_metagame(2)
                animation_sprite.play_terrifiered()
                animation_particle.emitting = true
            if item_clicked >= 30:
                get_node("/root/GlobalData").player_hud.update_metagame(3)
                animation_sprite.play_terrifiered()
                animation_particle.emitting = true
                #( FINAL WIN)
func on_mouse_entered():
    is_godot_highlighted = true
func on_mouse_exited():
    is_godot_highlighted = false 