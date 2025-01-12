extends AnimatedSprite2D

@onready var health_component : Health_Component =$Health_Component
@onready var particles : CPUParticles2D = $CPUParticles2D
func _ready() -> void:

    health_component.died.connect(on_enemy_died)
    health_component.health_changed.connect(hit_effect)


func hit_effect():
    get_node("/root/GameManager").player_scored(100)
    get_node("/root/Audio").play_random()
    particles.emitting = true
    var tween = get_tree().create_tween()
    tween.set_ease(Tween.EASE_IN)
    tween.set_trans(Tween.TRANS_EXPO)
    tween.tween_property(self,"modulate", Color.RED ,0.1)
    tween.tween_property(self,"modulate", Color.BLACK ,0.1)
    tween.tween_property(self,"modulate", Color.RED ,0.3)
    tween.tween_property(self,"modulate", Color.BLACK ,1)
    tween.set_trans(Tween.TRANS_SPRING)

func on_enemy_died():
    get_node("/root/GlobalData").menu.increase_menu_raven_counter()
    particles.emitting = true
    var tween_dead = get_tree().create_tween()
    tween_dead.set_ease(Tween.EASE_IN)
    tween_dead.set_trans(Tween.TRANS_EXPO)
    ### SPAWNING CHANCE OF GODOT PART
    get_node("/root/GameManager").player_scored(1000)
    call_deferred("on_enemy_died_spawning_godot_part")
    tween_dead.tween_property(self,"rotation",deg_to_rad(-90),0.3).as_relative()
    tween_dead.set_parallel()
    tween_dead.tween_property(self,"position",Vector2.DOWN * 2500,0.5).as_relative()
    tween_dead.tween_callback(queue_free).set_delay(2)

func on_enemy_died_spawning_godot_part():
    get_node("/root/GlobalData").enemygodot.meta_godot_part_spawning()