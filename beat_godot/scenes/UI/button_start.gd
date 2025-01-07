extends Button

func _ready() -> void:
    pivot_offset = Vector2(175,68)
    mouse_entered.connect(on_mouse_entered_button_highlight)
    mouse_exited.connect(on_mouse_exited_button_highlight)

func on_mouse_entered_button_highlight():
    var tween = get_tree().create_tween()
    tween.set_ease(Tween.EASE_IN)
    tween.set_trans(Tween.TRANS_EXPO)
    tween.tween_property(self,"scale", Vector2.ONE * 1.1,0.2)

func on_mouse_exited_button_highlight():
    var tween = get_tree().create_tween()
    tween.set_ease(Tween.EASE_IN)
    tween.set_trans(Tween.TRANS_EXPO)
    tween.tween_property(self,"scale", Vector2.ONE ,0.2)

    #############
    #### TWEEN TUTORIAL 
    # var tween = get_tree().create_tween().set_parallel(true)
    #  tween.tween_callback(queue_free)
    # tween.tween_callback(private_function.bind("bye bye"))
    # tween.tween_callback(private_function.bind("hye hye"))
    # func private_function(message):
        # print(message)