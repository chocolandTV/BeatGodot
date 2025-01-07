extends AnimatedSprite2D

@onready var health_component : Health_Component =$Health_Component
@onready var particles : CPUParticles2D = $CPUParticles2D
var _audio_manager:  Audio_Manager
func _ready() -> void:

    health_component.died.connect(on_enemy_died)
    health_component.set_life(get_node("/root/GlobalData").enemy_life_multiplier)
    health_component.health_changed.connect(hit_effect)
    _audio_manager  = get_node("/root/Audio")

    get_parent().cured.connect(cure_enemy)

func cure_enemy():
    health_component.cure_wounds()

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

    tween_dead.tween_property(self,"rotation",deg_to_rad(-90),1).as_relative()
    tween_dead.set_parallel()
    tween_dead.tween_property(self,"position",Vector2.DOWN * 3500,1).as_relative()
    tween_dead.tween_callback(queue_free).set_delay(10)
    