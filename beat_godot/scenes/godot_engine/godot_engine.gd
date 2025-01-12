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
@onready var godot_shield : AnimatedSprite2D = $Godot_Movement/Godot_Shield
@export var spawn_rate_seconds : float = 4.0
@export var color_75 :Color
@export var color_50: Color
@export var color_25: Color
@onready var lifebar : ColorRect =$Godot_Movement/LifeBar/ColorRect
var godot_part_scene = preload ("res://scenes/godot_engine/godot_engine_part.tscn")
### CONST
var start_pos : Vector2
var color_array : Array[Color]
var size_array : Array[int] = [33,22,11,1]
const SPAWN_HEIGHT : float  = 250

########### VARIABLES
var is_godot_highlighted :bool = false
var _player_hud : Player_HUD
var _game_manager : Game_Manager
var _audio_manager:  Audio_Manager
var metagame : int = 0

func _ready() -> void:
    get_node("/root/GlobalData").SET_GODOT_ENEMY(self)
    color_array.append(color_75)
    color_array.append(color_75)
    color_array.append(color_50)
    color_array.append(color_25)
    start_pos = global_position
    _player_hud = get_node("/root/GlobalData").player_hud
    print(_player_hud)
    _game_manager = get_node("/root/GameManager")
    _audio_manager  = get_node("/root/Audio")

    timer.timeout.connect(on_timer_timeout)
    timer.wait_time = spawn_rate_seconds
    _game_manager.game_started.connect(game_start)
    _game_manager.game_paused.connect(game_paused)
    _game_manager.game_restarted.connect(on_restart_game)
    _game_manager.game_resumed.connect(game_start)

func on_restart_game():
    health_component.set_life(30)
    global_position = start_pos
    metagame = 0
    

#### TIMER EVENT  ALL 4 SECONDS
func on_timer_timeout():
    generate_obstacles()
    _player_hud.godot_anim_play_dificult()
    godot_movement.increase_difficult_speed()
    animation_sprite.play_redeye()

func generate_obstacles():
    var new_bad_ravens = badbirds_scene.instantiate()
    new_bad_ravens.global_position.x = start_pos.x
    new_bad_ravens.global_position.y = randf_range(-SPAWN_HEIGHT, SPAWN_HEIGHT)
    add_child(new_bad_ravens)

func godot_loose_parts():
    _player_hud.godot_anim_play_endgame()

func meta_godot_part_spawning():
    if randi_range(0,100) > 90:
        var new_godot_part =  godot_part_scene.instantiate()
        new_godot_part.global_position = Vector2(global_position.x, 500+ randi_range(-200,200))
        call_deferred("add_child", new_godot_part)


func game_start():
    timer.start()
func game_paused():
    timer.stop()
func on_default_damage_entered(_area : Area2D):
    get_node("/root/GameManager").player_scored(1)
    health_component.damage(1)
    godot_shield.play("shield")
    animation_sprite.play_red_godot()
    animation_particle.emitting = true
    health_generation_timer.start()

func on_health_reg_timout():
    health_component.heal()
    _player_hud.on_text_changed("player_attack - > Godot.Set_Life = 3 -> You Can`t Beat Me")
    
func on_real_damage_entered(_area: Area2D):
    meta_godot_part_spawning()
    get_node("/root/GameManager").player_scored(10000)
    metagame +=1
    lifebar.modulate = color_array[metagame]
    lifebar.size.x =  size_array[metagame]
    health_component.damage(10000)
    _audio_manager.play_godot_damage()
    animation_sprite.play_terrifiered()
    animation_particle.emitting = true
    _player_hud.on_text_changed("hearth_attack - > do you love me =O §$%& ERROR_HANDLE_LOVE **~~")
    _player_hud.update_metagame(metagame)
    _player_hud.godot_anim_play_hard_damaged()

    ######################################### HEAL WHEN PLAYER HAVE NOT ALL 3 GODOT PARTS
    if !get_node("/root/GameManager").check_godot_parts():
        print("real_damage_chanceled, player has not all parts")
        metagame -=1
        lifebar.modulate = color_array[metagame]
        lifebar.size.x =  size_array[metagame]
        health_component.damage(-_area.damage)
        animation_sprite.play_terrifiered()
        godot_shield.play("shield")
        _player_hud.on_text_changed("SHIELD HEAL - > you love me!  -> but i still have my Godot Parts XD")
        _player_hud.update_metagame(metagame)


func _on_godot_shield_animation_finished() -> void:
    godot_shield.play("default")
