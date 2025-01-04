extends CharacterBody2D

### VARIABLES 
const  GRAVITY : int = 1000
const MAX_VEL : int = 1200
const START_POS : Vector2= Vector2 (100,400)
const FLAP_SPEED : int = -700
var is_flying : bool = false
var is_falling: bool = false

@onready var animation_sprite : AnimatedSprite2D = $Beatrii

func _ready() -> void:
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

func flap():

    velocity.y = FLAP_SPEED