extends Node
class_name global_data
var player : Player
var menu : Menu
var player_hud : Player_HUD
var enemygodot: enemy_godot
func SET_PLAYERHUD( instance : Player_HUD):
    print("set player_hud")
    player_hud = instance

func SET_MENU(instance : Menu):
    print("set menu")
    menu = instance

func SET_PLAYER(instance : Player):
    print("set player")
    player = instance

func SET_GODOT_ENEMY(instance  :enemy_godot):
    enemygodot = instance
    print("set Enemy Godot")
    