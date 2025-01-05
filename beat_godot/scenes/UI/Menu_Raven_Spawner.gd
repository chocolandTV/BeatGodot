extends TextureRect
## ravenscene
## spawn all time
var badbirds_scene = preload ("res://scenes/UI/random_raven.tscn")
const START_SPAWN_POS : Vector2 = Vector2(1600.0, 0.0)
var is_menu_disabled : bool = true
@onready var timer : Timer=$Timer

func _ready() -> void:
    timer.timeout.connect(start_spawn)
    timer.start()
    get_parent().gamemanager.game_is_running.connect(switch_spawner)

func switch_spawner(value : bool):
    if !value:
        timer.start()
    else:
        timer.stop()

func start_spawn():
    var new_bad_ravens = badbirds_scene.instantiate()
    new_bad_ravens.global_position.x = START_SPAWN_POS.x
    new_bad_ravens.global_position.y = randf_range(-55, 200)
    add_child(new_bad_ravens)