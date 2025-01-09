extends TextureRect
## ravenscene
## spawn all time
var badbirds_scene = preload ("res://scenes/UI/random_raven.tscn")
const START_SPAWN_POS : Vector2 = Vector2(2000.0, 500.0)
var is_menu_disabled : bool = true
@onready var timer : Timer=$Timer

func _ready():
    timer.timeout.connect(start_spawn)
    timer.start()

func start_spawn():
    var new_bad_ravens = badbirds_scene.instantiate()
    new_bad_ravens.global_position.x = START_SPAWN_POS.x
    new_bad_ravens.global_position.y = randf_range(0, 1000)
    add_child(new_bad_ravens)