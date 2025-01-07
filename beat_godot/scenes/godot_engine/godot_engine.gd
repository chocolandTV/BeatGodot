extends Node2D
class_name enemy_godot
var badbirds_scene = preload ("res://scenes/Obstacles/bad_raven.tscn")
### DEFINES
@onready var timer : Timer  =$Spawn_rate_timer
@onready var animation_sprite : AnimatedSprite2D =$Godot_Movement/AnimatedSprite2D
@onready var animation_particle: CPUParticles2D = $Godot_Movement/AnimatedSprite2D/Particle_damaged
@onready var godot_movement :enemy_godot_movement  =$Godot_Movement
@export var spawn_rate_seconds : float = 4.0
### CONST
const START_POS : Vector2 = Vector2(1096,0)
const SPAWN_HEIGHT : float  = 400

########### VARIABLES
var is_godot_highlighted :bool = false
# var _godot_life : int = 30
var _player_hud : Player_HUD
var _game_manager : Game_Manager
var _audio_manager:  Audio_Manager

func _ready() -> void:
    _player_hud = get_node("/root/GlobalData").player_hud
    print(_player_hud)
    _game_manager = get_node("/root/GlobalData").game_manager
    _audio_manager  = get_node("/root/Audio")

    timer.timeout.connect(on_timer_timeout)
    timer.wait_time = spawn_rate_seconds
    _game_manager.game_is_running.connect(switch_game_state)
#### TIMER EVENT  ALL 4 SECONDS
func on_timer_timeout():
    generate_obstacles()
    _player_hud.godot_anim_play_dificult()
    godot_movement.increase_difficult_speed()

func generate_obstacles():
    var new_bad_ravens = badbirds_scene.instantiate()
    new_bad_ravens.global_position.x = START_POS.x
    new_bad_ravens.global_position.y = randf_range(-SPAWN_HEIGHT, SPAWN_HEIGHT)
    add_child(new_bad_ravens)

func godot_loose_parts():
    _player_hud.godot_anim_play_endgame()


func player_scored():
    if randi_range(0,100) < 10:  #sound fix
        _audio_manager.play_random()
    _game_manager.player_scored()

func switch_game_state(value :bool):
    if value:
        timer.start()
    else:
        timer.stop()

# func _input(event: InputEvent) -> void:
#         if event.is_action_pressed("left_click") and  is_godot_highlighted:
#             _godot_life -= 1
#             ### UPDATE GODOT UI LIFE
#             if _godot_life == 20:
#                 _audio_manager.play_godot_damage()
#                 _player_hud.update_metagame(1)
#                 animation_sprite.play_terrifiered()
#                 animation_particle.emitting = true
#             if _godot_life == 10:
#                 _audio_manager.play_godot_damage()
#                 _player_hud.update_metagame(2)
#                 animation_sprite.play_terrifiered()
#                 animation_particle.emitting = true
#             if _godot_life == 0:
#                 _audio_manager.play_godot_damage()
#                 _player_hud.update_metagame(3)
#                 animation_sprite.play_terrifiered()
#                 animation_particle.emitting = true
