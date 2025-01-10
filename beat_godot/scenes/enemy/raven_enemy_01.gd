extends AnimatedSprite2D

@onready var health_component : Health_Component =$Health_Component
@onready var particles : CPUParticles2D = $CPUParticles2D
var _audio_manager:  Audio_Manager
func _ready() -> void:

    health_component.died.connect(on_enemy_died)
    
    health_component.health_changed.connect(hit_effect)
    _audio_manager  = get_node("/root/Audio")

    get_parent().cured.connect(cure_enemy)

func cure_enemy():
    health_component.add_life()
########################### CLICK ON RAVEN
func on_click_damage():
    get_node("/root/GlobalData").menu.increase_menu_raven_counter()
    $TextureButton.visible = false
    health_component.damage(1)

func hit_effect():
    _audio_manager.play_random()
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
    $HitBox_Component.visible = false
    $Hurtbox_Component.visible = false
    var tween_dead = get_tree().create_tween()
    tween_dead.set_ease(Tween.EASE_IN)
    tween_dead.set_trans(Tween.TRANS_EXPO)
    ### SPAWNING CHANCE OF GODOT PART
    var _random : int = randi_range(0,20)
    print("random >1 result =", _random)
    if _random > 1:
        get_node("/root/GameManager").meta_godot_part_spawning(global_position)
    tween_dead.tween_property(self,"rotation",deg_to_rad(-90),1).as_relative()
    tween_dead.set_parallel()
    tween_dead.tween_property(self,"position",Vector2.DOWN * 1500,1).as_relative()
    tween_dead.tween_callback(queue_free).set_delay(10)
    