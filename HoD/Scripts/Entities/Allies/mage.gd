extends Button

var HP = 100
var Mana = 100
var ATK = 0
var DEF = 0



func apply_item_effect(item):
	match item["effect"]:
		"Health":
			HP += 5
			print("HP increased to ", HP)
		"Stanima":
			Mana += 10
			print("Rage incrase to ", Mana)
		"Armor":
			DEF += 10
			print("DEF incrase to ", DEF)
		_:
			print("There is no effect for this item")
