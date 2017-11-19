extends Node2D

var mana = 100

func update_mana_bar():
	get_node("ManaBar").set_value(mana)
	get_node("mana").set_text(str(mana))
	
func use_mana(amount):
	if(amount <= mana):
		mana -= amount
		update_mana_bar()
		return true
	else:
		return false

func setMaxMana(amount):
	get_node("ManaBar").set_max(mana)
	
func getMaxMana():
	return get_node("ManaBar").get_max()

func _ready():
	setMaxMana(mana)

func setMana(var1):
	mana = var1
	update_mana_bar()

func getMana():
	return mana