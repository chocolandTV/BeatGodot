extends Node
class_name global_data

var player : Player
var menu : Menu
var player_hud : Player_HUD
var game_manager : Game_Manager
var player_score : int
var player_life : int = 3
var enemy_life_multiplier: int = 1
var audio_manager : Audio_Manager

func SET_GAMEMANAGER( instance  : Game_Manager):
    print("set game_manager")
    game_manager = instance

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

func SET_AUDIO_MANAGER(instance : Audio_Manager):
    print("set audio_manager")
    audio_manager = instance

func INCREASE_ENEMY_MULTIPLIER():
    enemy_life_multiplier +=1