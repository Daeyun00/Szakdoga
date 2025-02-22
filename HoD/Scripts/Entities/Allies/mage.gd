extends Button

var MaxHP = 100
var HP = 100
var MaxMana = 100
var Mana = 100
var MaxATK = 0
var ATK = 2
var MaxDEF = 0
var DEF = 0



func apply_item_effect(item):
	match item["effect"]:
		"Health":
			HP += 5
			print("HP increased to ", HP)
		"Stanima":
			Mana += 10
			print("Mana incrase to ", Mana)
		"Armor":
			DEF += 10
			print("DEF incrase to ", DEF)
		_:
			print("There is no effect for this item")
