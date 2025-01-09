extends Node2D
class_name enemy_godot
var badbirds_scene = preload ("res://scenes/Obstacles/bad_raven.tscn")
### DEFINES
@onready var timer : Timer  =$Spawn_rate_timer
@onready var animation_sprite : AnimatedSprite2D =$Godot_Movement/AnimatedSprite2D
@onready var animation_particle: CPUParticles2D = $Godot_Movement/AnimatedSprite2D/Particle_damaged
@onready var godot_movement :enemy_godot_movement  =$Godot_Movement
@onready var health_component : Health_Component =$Health_Component
@onready var health_generation_timer : Timer  =$Health_Component/Health_reg_timer
@onready var godot_shield : AnimatedSprite2D = $Godot_Shield
@export var spawn_rate_seconds : float = 4.0
### CONST
const START_POS : Vector2 = Vector2(1442,0)
const SPAWN_HEIGHT : float  = 250

########### VARIABLES
var is_godot_highlighted :bool = false
var _player_hud : Player_HUD
var _game_manager : Game_Manager
var _audio_manager:  Audio_Manager
var metagame : int = 0

func _ready() -> void:
    _player_hud = get_node("/root/GlobalData").player_hud
    print(_player_hud)
    _game_manager = get_node("/root/GameManager")
    _audio_manager  = get_node("/root/Audio")

    timer.timeout.connect(on_timer_timeout)
    timer.wait_time = spawn_rate_seconds
    _game_manager.game_is_running.connect(switch_game_state)
    _game_manager.game_restarted.connect(on_restart_game)

func on_restart_game():
    health_component.set_life(30)
    global_position = START_POS
    metagame = 0

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
func on_default_damage_entered(_area : Area2D):
    health_component.damage(1)
    _audio_manager.play_godot_damage()
    godot_shield.play("shield")
    animation_sprite.play_terrifiered()
    animation_particle.emitting = true
    health_generation_timer.start()

func on_health_reg_timout():
    health_component.heal()
    _player_hud.on_text_changed("player_attack - > Godot.Set_Life = 3 -> You Can`t Beat Me")
    
func on_real_damage_entered(_area: Area2D):
    metagame +=1
    health_component.damage(1)
    _audio_manager.play_godot_damage()

    animation_sprite.play_terrifiered()
    animation_particle.emitting = true
    _player_hud.on_text_changed("hearth_attack - > do you love me =O §$%& ERROR_HANDLE_LOVE **~~")
    _player_hud.update_metagame(metagame)