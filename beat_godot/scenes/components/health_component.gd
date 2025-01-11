extends Node
class_name Health_Component
signal died()
signal health_changed()

@export var max_health : int =  3
var is_invincible : bool  = false
var current_health : int = 3
var player_hearth_damage : int = 0
const MAX_LIFE : int = 10
func set_life(value : int):
    max_health = value
    current_health = value

func add_life():
    if current_health > MAX_LIFE:
        current_health = MAX_LIFE
        max_health = MAX_LIFE
    else: 
        current_health +=1
        max_health +=1

func cure_wounds():
    current_health +=1
    if max_health < current_health:
        current_health = max_health

func damage(damage_amount : int):
    if is_invincible:
        return
    current_health -= damage_amount
    health_changed.emit()
    check_death()
func heal():
    current_health = max_health
    health_changed.emit()

func check_death():
    if current_health <= 0:
        died.emit()

func damage_player_hearth():
    if player_hearth_damage < 3:
        player_hearth_damage += 1
        
func player_invincible_on():
    is_invincible = true