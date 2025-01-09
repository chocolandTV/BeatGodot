extends Node
class_name global_data
var player : Player
var menu : Menu
var player_hud : Player_HUD
var player_score : int
var player_life : int = 3
var enemy_life_multiplier: int = 1

func SET_PLAYERHUD( instance : Player_HUD):
    print("set player_hud")
    player_hud = instance

func SET_MENU(instance : Menu):
    print("set menu")
    menu = instance

func SET_PLAYER(instance : Player):
    print("set player")
    player = instance

func SET_PLAYER_SCORE(value : int):
    player_score = value

func INCREASE_ENEMY_MULTIPLIER():
    enemy_life_multiplier +=1