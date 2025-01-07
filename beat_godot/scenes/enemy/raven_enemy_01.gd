extends AnimatedSprite2D

@onready var health_component : Health_Component =$Health_Component
@onready var particles : CPUParticles2D = $CPUParticles2D

func _ready() -> void:

    health_component.died.connect(on_enemy_died)
    health_component.set_life(get_node("/root/GlobalData").enemy_life_multiplier)
    health_component.health_changed.connect(hit_effect)

func hit_effect():
    particles.emitting = true
    var tween = get_tree().create_tween()
    tween.set_ease(Tween.EASE_IN)
    tween.set_trans(Tween.TRANS_EXPO)
    tween.tween_property(self,"modulate", Color.RED ,0.1)
    tween.tween_property(self,"modulate", Color.BLACK ,0.1)
    tween.tween_property(self,"modulate", Color.RED ,0.3)
    tween.tween_property(self,"modulate", Color.BLACK ,1)
    tween.set_trans(Tween.TRANS_SPRING)
    var current_scale = float(health_component.current_health)/float(health_component.max_health) * 100
    tween.tween_property(self,"scale", current_scale  ,0.5)

func on_enemy_died():
    var tween_dead = get_tree().create_tween()
    tween_dead.set_ease(Tween.EASE_IN)
    tween_dead.set_trans(Tween.TRANS_EXPO)

    tween_dead.tween_property(self,"rotation",deg_to_rad(-90),1).as_relative()
    tween_dead.set_parallel()
    tween_dead.tween_property(self,"position",Vector2.DOWN * 1500,3).as_relative()
    tween_dead.tween_callback(queue_free).set_delay(3)
    