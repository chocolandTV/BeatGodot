extends CanvasLayer
class_name Menu

@export var gamemanager: Node
@export var credit_panel : MarginContainer
@export var button_start : Button

var is_credits_visible : bool  = false
var is_game_over : bool = false
func _ready() -> void:
    get_node("/root/GlobalData").SET_MENU(self)

func on_button_pressed_start():
    is_game_over = false
    gamemanager.start_game()
    button_start.text  = "Resume"

func on_button_pressed_restart():
    is_game_over = false
    get_tree().change_scene_to_file("res://scenes/_game/game_scene_01.tscn")
    on_button_pressed_start()


func on_button_pressed_quit():
    gamemanager.quit_game()

func on_button_pressed_credits():
    is_credits_visible = !is_credits_visible
    credit_panel.visible = is_credits_visible

func update_game_over():
    button_start.text  = "Restart"
    is_game_over = true

