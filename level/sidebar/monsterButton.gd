extends TextureButton

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

export(String) var monsterImage = "res://"
export(int) var damage = 1
export(int) var mana = 20
export(String) var monsterName = "Falle"
export(String) var beschreibung = "I bims 1 Monster"
export(String) var tooltip = "I bims k1 Falle"


func _ready():
	get_node("Sprite").set_texture(load(monsterImage))
	var text = monsterName + "\n\n" + "Manakosten: " + str(mana) + "\n" + "Schaden: " + str(damage) + "\n" + beschreibung
	get_node("Label").set_text(text)
	get_node("Label").set_tooltip(tooltip)
