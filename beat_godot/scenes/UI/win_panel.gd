extends MarginContainer
@onready var pulsing_object : TextureRect =$VBoxContainer/Panel/Pulsing_win

func start_scaling():
    var tween_updown = get_tree().create_tween().set_loops(20)

############ up and down
    tween_updown.set_ease(Tween.EASE_IN)
    tween_updown.set_trans(Tween.TRANS_SPRING)

    tween_updown.tween_property(pulsing_object,"scale",Vector2.ONE * 1.2,2).as_relative()
    tween_updown.tween_property(pulsing_object,"scale",Vector2.ONE,10).as_relative()

func on_button_pressed_restart():
    get_tree().paused = false
    visible  = false
    get_tree().change_scene_to_file("res://scenes/_game/game_menu.tscn")