extends AnimatedSprite2D

func _ready() -> void:

    var tween_updown = get_tree().create_tween().set_loops()

############ up and down
    tween_updown.set_ease(Tween.EASE_IN)
    tween_updown.set_trans(Tween.TRANS_SPRING)

    tween_updown.tween_property(self,"position",Vector2.UP * 100,5).as_relative()
    tween_updown.tween_property(self,"position",Vector2.DOWN * 50,10).as_relative()
    tween_updown.tween_property(self,"position",Vector2.DOWN * 50,3).as_relative()