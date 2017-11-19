extends Node2D

var mana = 100

func update_mana_bar():
	get_node("ManaBar").set_value(mana)
	
func use_mana(amount):
	if(amount <= mana):
		mana -= amount
		update_mana_bar()
		return true
	else:
		return false

func setMaxMana(amount):
	get_node("ManaBar").set_max(mana)

func _ready():
	setMaxMana(mana)
