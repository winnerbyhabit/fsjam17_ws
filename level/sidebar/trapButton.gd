extends TextureButton

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

export(String) var trapImage = "res://"
export(int) var damage = 1
export(int) var mana = 20
export(String) var trapName = "Falle"
export(String) var tooltip = "I bims 1 Falle"
func _ready():
	get_node("Sprite").set_texture(load(trapImage))
	var text = trapName + "\n\n" + "Manakosten: " + str(mana) + "\n" + "Schaden: " + str(damage)
	get_node("Label").set_text(text)
	get_node("Label").set_tooltip(tooltip)
