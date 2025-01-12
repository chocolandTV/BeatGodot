extends CharacterBody2D
class_name Player
### VARIABLES 
const  GRAVITY : int = 980
const MAX_VEL : int = 1200
var start_pos : Vector2
const FLAP_SPEED : int = -700
var is_flying : bool = false
var is_falling: bool = false
var is_player_active : bool = false
@onready var animation_sprite : AnimatedSprite2D = $Beatrii
@onready var health_component : Health_Component = $Health_Component
@onready var particles : CPUParticles2D = $Beatrii/flap_particles
@onready var animation_player : AnimationPlayer =$AnimationPlayer
var _game_manager : Game_Manager
var _audio_manager:  Audio_Manager
var _player_hud : Player_HUD

func _ready() -> void:
    start_pos = global_position
    _player_hud = get_node("/root/GlobalData").player_hud
    _game_manager = get_node("/root/GameManager")
    _game_manager.game_started.connect(on_game_started)
    _game_manager.game_paused.connect(on_game_paused)
    _game_manager.game_resumed.connect(on_game_resumed)

    _audio_manager  = get_node("/root/Audio")

    health_component.died.connect(on_player_death)
    health_component.health_changed.connect(on_player_damage)

    get_node("/root/GlobalData").SET_PLAYER(self)
    reset()
    on_game_started()
############# GAME MANAGER RESTART
func on_game_paused():
    is_player_active = false
func on_game_started():
    is_flying = true
    is_player_active = true
func on_game_resumed():
    is_player_active = true
    is_flying = true

    
func reset():
    is_falling = false
    is_flying = false
    position = start_pos
    set_rotation(0)
    health_component.set_life(3)
    
func _input(event: InputEvent) -> void:
        if event.is_action_pressed("fly") and is_flying:
                flap()

func _physics_process(delta: float) -> void:
    if is_flying or is_falling:
        velocity.y += GRAVITY * delta
        if global_position.y > 1080:
            flap()
        if velocity.y > MAX_VEL:
            velocity.y = MAX_VEL
        if is_flying:
            set_rotation(deg_to_rad(velocity.y *0.05   ))
            animation_sprite.play()
        elif is_falling:
            set_rotation(PI/2)
            animation_sprite.stop()
        move_and_collide(velocity * delta)
    else:
        animation_sprite.stop()

func on_player_death():
    is_falling = true
    is_flying = false
    animation_sprite.stop()
    _game_manager.game_over()

func on_player_damage():
        _player_hud.update_player_life(health_component.current_health)
        _audio_manager.play_hit()
        animation_player.play("damaged")

func flap():
    velocity.y = FLAP_SPEED
    particles.emitting  = true

func on_player_get_invincible():
    health_component.player_invincible_on()