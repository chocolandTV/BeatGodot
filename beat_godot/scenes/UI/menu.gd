extends CanvasLayer
class_name Menu

@export var gamemanager: Node
@export var credit_panel : MarginContainer
@export var button_start : Button

var is_credits_visible : bool  = false
func _ready() -> void:
    get_node("/root/GlobalData").SET_MENU(self)

func on_button_pressed_start():
    gamemanager.start_game()
    button_start.text  = "Resume"

func on_button_pressed_quit():
    gamemanager.quit_game()

func on_button_pressed_credits():
    is_credits_visible = !is_credits_visible
    credit_panel.visible = is_credits_visible