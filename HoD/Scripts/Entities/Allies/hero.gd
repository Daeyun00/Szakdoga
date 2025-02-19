extends Button

var MaxHP = 100
var HP = 100
var MaxRage = 100
var Rage = 0
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
			Rage += 10
			print("Rage incrase to ", Rage)
		"Armor":
			DEF += 10
			print("DEF incrase to ", DEF)
		_:
			print("There is no effect for this item")
