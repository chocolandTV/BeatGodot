extends CharacterBody2D
class_name Player
### VARIABLES 
const  GRAVITY : int = 1000
const MAX_VEL : int = 1200
const START_POS : Vector2= Vector2 (100,400)
const FLAP_SPEED : int = -700
var is_flying : bool = false
var is_falling: bool = false

@onready var animation_sprite : AnimatedSprite2D = $Beatrii
@onready var health_component : Health_Component = $Health_Component
var _game_manager : Game_Manager
var _audio_manager:  Audio_Manager
var _player_hud : Player_HUD

func _ready() -> void:
    _player_hud = get_node("/root/GlobalData").player_hud
    _game_manager = get_node("/root/GlobalData").game_manager
    _audio_manager  = get_node("/root/Audio")

    health_component.died.connect(on_player_death)
    health_component.health_changed.connect(on_player_damage)

    get_node("/root/GlobalData").SET_PLAYER(self)
    reset()

func reset():
    is_falling = false
    is_flying = false
    position = START_POS
    set_rotation(0)

func _physics_process(delta: float) -> void:
    if is_flying or is_falling:
        velocity.y += GRAVITY * delta
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
func flap():
    velocity.y = FLAP_SPEED

func on_player_scored():
    _game_manager.player_scored()
    _audio_manager.play_random()