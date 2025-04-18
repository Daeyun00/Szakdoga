extends Control

#Menus
@onready var _options: WindowDefault = $Options
@onready var _options_menu: Menu = $Options/AttackMenu

#Hostiles
@onready var hostile1: Button = $Hostiles/Slime
@onready var hostile2: Button = $Hostiles/Slime2
@onready var hostile3: Button = $Hostiles/Slime3

#Allies
@onready var Hero: Button = $Allies/Hero
@onready var Mage: Button = $Allies/Mage
@onready var Thief: Button = $Allies/Thief

@onready var attackMenu = $Options

#idk
@onready var tim = $Timer
@onready var usage_panel = $UsagePanel
@onready var details_panel = $DetailsPanel
@onready var inventory = $InventoryUI
@onready var quitButton = $InventoryUI/Quit

@onready var item_option = $itemOption

#slimes :3
@onready var slime1_color = $Hostiles/Slime.get_node("AnimatedSprite2D")
@onready var slime2_color = $Hostiles/Slime2.get_node("AnimatedSprite2D")

signal interacted(jezus: bool)

var is_fight = false
var is_skill = false
var is_item = false
var is_guard = false
var hero_guard = false
var mage_guard = false
var thief_guard = false
var is_flee = false

var hero = false
var mage = false
var thief = false

var hero_down = false
var mage_down = false
var thief_down = false

var slime1_down = false
var slime2_down = false
var slime3_down = false

var finished_action = false

#hostile switches
var selected_hostile = 0
var slime1_select = false
var slime2_select = false
var slime3_select = false

#hostile effects
var slime1_taunt = false
var slime1_taunt_turn = 0
var slime2_taunt = false
var slime2_taunt_turn = 0
var slime3_taunt = false
var slime3_taunt_turn = 0

#Hero skill switches
var _charge_select = false
var _taunt_select = false
var _Defensive_attack_select = false
var _defense_token = 0
var _bloodlust_select = false
var _bloodlust_token = 0
var _decimate_select = false
var _decimate_token = 0

#Mage spell switches
var _fireball_select = false
var _fireball_token1 = 0
var _fireball_token2 = 0
var _fireball_token3 = 0
var _heal_I_select = false
var _empower_select = false
var _empower_token1 = 0
var _empower_token2 = 0
var _empower_token3 = 0
var _resistance_select = false
var _resistance_token = 0
var _resistance_token1 = 0
var _resistance_token2 = 0
var _resistance_token3 = 0
var _thunder_select = false
var _thunder_token1 = 0
var _thunder_token2 = 0
var _thunder_token3 = 0

#Thief Combo switches
var _envenom_select = false
var _envenom_used_combo1 = 0
var _envenom_used_combo2 = 0
var _envenom_used_combo3 = 0
var _envenom_token1 = 0
var _envenom_token2 = 0
var _envenom_token3 = 0
var _eviscerate_select = false
var _eviscerate_used_combo = 0
var _rupture_select = false
var _rupture_token1 = 0
var _rupture_token2 = 0
var _rupture_token3 = 0
var _rupture_used_combo1 = 0
var _rupture_used_combo2 = 0
var _rupture_used_combo3 = 0
var _rupture_used_combo = 0
var _night_blade_select = false
var _night_blade_token = 0
var _shadowstrike_select = false
var _shadowstrike_used_combo = 0
var _shadowstrike_token1 = 0
var _shadowstrike_token2 = 0
var _shadowstrike_token3 = 0


var turn = 0

func _ready() -> void:
	#SLIMEEESSSSSS
	slime1_color.play("pink_slime")
	slime2_color.play("green_slime")
	
	_options_menu.button_focus(0)
	Global.set_battle_reference(self)
	
	SqlController.database.delete_rows("map_battle", "quantity = '1'")
	
	SqlController.database.delete_rows("allies", "name = 'hero'")
	SqlController.database.delete_rows("allies", "name = 'mage'")
	SqlController.database.delete_rows("allies", "name = 'thief'")
	
	SqlController.database.delete_rows("hostiles", "name = 'hostile1'")
	SqlController.database.delete_rows("hostiles", "name = 'hostile2'")
	SqlController.database.delete_rows("hostiles", "name = 'hostile3'")
	
	SqlController.database.insert_row("map_battle", {"enemy": 3, "quantity": 1})
	SqlController.database.insert_row("allies", {"name": "hero", "lvl": 1, "exp": 0, "gold": Global.currency, "atk": Hero.ATK, "max_att": 2, "def": Hero.DEF, "max_def": 100, "hp": $Allies/Hero.HP, "max_hp": $Allies/Hero.MaxHP, "resource": 2})
	SqlController.database.insert_row("allies", {"name": "mage", "lvl": 1, "exp": 0, "gold": Global.currency, "atk": Mage.ATK, "max_att": 2, "def": Mage.DEF, "max_def": 100, "hp": $Allies/Mage.HP, "max_hp": $Allies/Mage.MaxHP, "resource": 2})
	SqlController.database.insert_row("allies", {"name": "thief", "lvl": 1, "exp": 0, "gold": Global.currency, "atk": Thief.ATK, "max_att": 2, "def": Thief.DEF, "max_def": 100, "hp": $Allies/Thief.HP, "max_hp": $Allies/Thief.MaxHP, "resource": 2})
	
	SqlController.database.insert_row("hostiles", {"name": "hostile1", "atk": hostile1.ATK, "max_att": hostile1.ATK, "def": hostile1.DEF, "max_def": 100, "hp": $Hostiles/Slime.HP, "max_hp": $Hostiles/Slime.MaxHP})
	SqlController.database.insert_row("hostiles", {"name": "hostile2", "atk": hostile2.ATK, "max_att": hostile2.ATK, "def": hostile2.DEF, "max_def": 100, "hp": $Hostiles/Slime2.HP, "max_hp": $Hostiles/Slime2.MaxHP})
	SqlController.database.insert_row("hostiles", {"name": "hostile3", "atk": hostile3.ATK, "max_att": hostile3.ATK, "def": hostile3.DEF, "max_def": 100, "hp": $Hostiles/Slime3.HP, "max_hp": $Hostiles/Slime3.MaxHP})

	

func _process(delta: float) -> void:
	#no res
	if(hero_down):
		if(Hero.HP > 0):
			Hero.HP = 0
			SqlController.database.update_rows("allies", "name = 'hero'", {"lvl": 1, "exp": 1, "gold": Global.currency, "atk": Hero.ATK, "max_att": Hero.ATK, "def": Hero.DEF, "max_def": 100, "hp": Hero.HP, "max_hp": $Allies/Hero.MaxHP, "resource": 2})
	if(mage_down):
		if(Mage.HP > 0):
			Mage.HP = 0
			SqlController.database.update_rows("allies", "name = 'mage'", {"lvl": 1, "exp": 1, "gold": Global.currency, "atk": Mage.ATK, "max_att": Mage.ATK, "def": Mage.DEF, "max_def": 100, "hp": Mage.HP, "max_hp": $Allies/Mage.MaxHP, "resource": 2})
	if(thief_down):
		if(Thief.HP > 0):
			Thief.HP = 0
			SqlController.database.update_rows("allies", "name = 'thief'", {"lvl": 1, "exp": 1, "gold": Global.currency, "atk": Thief.ATK, "max_att": Thief.ATK, "def": Thief.DEF, "max_def": 100, "hp": Thief.HP, "max_hp": $Allies/Thief.MaxHP, "resource": 2})
	
	#no 0 ally
	if(Hero.HP <= 0):
		Hero.HP = 0
		SqlController.database.update_rows("allies", "name = 'hero'", {"lvl": 1, "exp": 1, "gold": Global.currency, "atk": Hero.ATK, "max_att": Hero.ATK, "def": Hero.DEF, "max_def": 100, "hp": Hero.HP, "max_hp": $Allies/Hero.MaxHP, "resource": 2})
		$Top/Players/Hero_label/Hero_status.text = "Down"
		$"Effects/Hero_effect/Down-Icon".visible = true
		hero_down = true
	if(Mage.HP <= 0):
		Mage.HP = 0
		SqlController.database.update_rows("allies", "name = 'mage'", {"lvl": 1, "exp": 1, "gold": Global.currency, "atk": Mage.ATK, "max_att": Mage.ATK, "def": Mage.DEF, "max_def": 100, "hp": Mage.HP, "max_hp": $Allies/Mage.MaxHP, "resource": 2})
		$Top/Players/Mage_label/Mage_status.text = "Down"
		$"Effects/Mage_effect/Down-Icon".visible = true
		mage_down = true
	if(Thief.HP <= 0):
		Thief.HP = 0
		SqlController.database.update_rows("allies", "name = 'thief'", {"lvl": 1, "exp": 1, "gold": Global.currency, "atk": Thief.ATK, "max_att": Thief.ATK, "def": Thief.DEF, "max_def": 100, "hp": Thief.HP, "max_hp": $Allies/Thief.MaxHP, "resource": 2})
		$Top/Players/Thief_label/Thief_status.text = "Down"
		$"Effects/Thief_effect/Down-Icon".visible = true
		thief_down = true
	
	#no 0 enemy
	if(hostile1.HP <= 0):
		hostile1.HP = 0
		SqlController.database.update_rows("hostiles", "name = 'hostile1'", {"atk": hostile1.ATK, "max_att": 2, "def": hostile1.DEF, "max_def": 100, "hp": $Hostiles/Slime.HP, "max_hp": $Hostiles/Slime.MaxHP})
		$Top/Enemies/Enemy1/Enemy1_HP_label.text = "Down"
		$"Effects/Slime1_effect/Down-Icon".visible = true
		slime1_down = true
	if(hostile2.HP <= 0):
		hostile2.HP = 0
		SqlController.database.update_rows("hostiles", "name = 'hostile2'", {"atk": hostile2.ATK, "max_att": 2, "def": hostile2.DEF, "max_def": 100, "hp": $Hostiles/Slime2.HP, "max_hp": $Hostiles/Slime2.MaxHP})
		$Top/Enemies/Enemy2/Enemy2_HP_label.text = "Down"
		$"Effects/Slime2_effect/Down-Icon".visible = true
		slime2_down = true
	if(hostile3.HP <= 0):
		hostile3.HP = 0
		SqlController.database.update_rows("hostiles", "name = 'hostile1'", {"atk": hostile3.ATK, "max_att": 2, "def": hostile3.DEF, "max_def": 100, "hp": $Hostiles/Slime3.HP, "max_hp": $Hostiles/Slime3.MaxHP})
		$Top/Enemies/Enemy3/Enemy3_HP_label.text = "Down"
		$"Effects/Slime3_effect/Down-Icon".visible = true
		slime3_down = true

	#turn skips
	if(Hero.HP < 0):
		turn = 0
	if(Hero.HP < 0 and Mage.HP > 0):
		turn = 1
	if (Hero.HP < 0 and Mage.HP < 0):
		turn = 2
	if (turn == 1 && Mage.HP <= 0):
		turn = 2
	if(turn == 2 && Thief.HP <=0 && !(hero_down and mage_down and thief_down)):
		turn = 3
	
	#death
	if(mage_down && hero_down && thief_down):
		get_tree().quit()
	
	#win
	if(slime1_down && slime2_down && slime3_down):
		get_tree().change_scene_to_file("res://Scenes/World scenes/VillageCenter/village_center.tscn")
	
	#enemy focus
	if(is_fight):
		if($Allies/Hero.has_focus()):
			hostile1.grab_focus()
	
	#HP labels
	var HeroHP = str($Allies/Hero.HP) + "/" + str($Allies/Hero.MaxHP) + " HP"
	var MageHP = str($Allies/Mage.HP) + "/" + str($Allies/Mage.MaxHP) + " HP"
	var ThiefHP = str($Allies/Thief.HP) + "/" + str($Allies/Thief.MaxHP) + " HP"
	
	var SlimeHP = str($Hostiles/Slime.HP) + "/" + str($Hostiles/Slime.MaxHP) + " HP" 
	var Slime2HP = str($Hostiles/Slime2.HP) + "/" + str($Hostiles/Slime2.MaxHP) + " HP" 
	var Slime3HP = str($Hostiles/Slime3.HP) + "/" + str($Hostiles/Slime3.MaxHP) + " HP" 
	$Top/Enemies/Enemy1/Enemy1_HP_label.text = SlimeHP
	$Top/Enemies/Enemy2/Enemy2_HP_label.text = Slime2HP
	$Top/Enemies/Enemy3/Enemy3_HP_label.text = Slime3HP
	$Top/Players/Hero_label/Hero_HP_label.text = HeroHP
	$Top/Players/Mage_label/Mage_HP_label.text = MageHP
	$Top/Players/Thief_label/Thief_HP_label.text = ThiefHP
	
	
	#Resource labels
	
	if(Hero.Rage > Hero.MaxRage):
		Hero.Rage = Hero.MaxRage
	if(Mage.Mana > Mage.MaxMana):
		Mage.Mana = Mage.MaxMana
	if(Thief.Combo > Thief.MaxCombo):
		Thief.Combo = Thief.MaxCombo
	
	var Rage = str(Hero.Rage) + "/" + str(Hero.MaxRage) + " Rage"
	var Mana = str(Mage.Mana) + "/" + str(Mage.MaxMana) + " Mana"
	var Combo = str(Thief.Combo) + "/" + str(Thief.MaxCombo) + " Combo"
	
	$Top/Players/Hero_label/Hero_rage_label.text = Rage
	$Top/Players/Mage_label/Mage_mana_label.text = Mana
	$Top/Players/Thief_label/Thief_combo_label.text = Combo
	
	$Top/Players/Hero_label/Hero_ATK_label.text = str(Hero.ATK) + " ATK"
	$Top/Players/Mage_label/Mage_ATK_label.text = str(Mage.ATK) + " ATK"
	$Top/Players/Thief_label/Thief_ATK_label.text = str(Thief.ATK) + " ATK"
	
	$Top/Players/Hero_label/Hero_DEF_label.text = str(Hero.DEF) + " DEF"
	$Top/Players/Mage_label/Mage_DEF_label.text = str(Mage.DEF) + " DEF"
	$Top/Players/Thief_label/Thief_DEF_label.text = str(Thief.DEF) + " DEF"
	if(turn == 0 and Hero.HP == 0):
		turn = 1
	match turn:
		0:
			$ActionTurn/Turns.text = "Hero's Turn"
		1:
			$ActionTurn/Turns.text = "Mage's Turn"
		2:
			$ActionTurn/Turns.text = "Thief's Turn"
		_:
			$ActionTurn/Turns.text = "Enemy's Turn"
	
	#Option focus fix
	if(!is_fight && !is_skill && !is_item && !is_guard && !is_flee):
		if (!$Options/AttackMenu/Fight_button.has_focus() and !$Options/AttackMenu/Flee_button.has_focus() and !$Options/AttackMenu/Guard_button.has_focus() and !$Options/AttackMenu/Item_button.has_focus() and !$Options/AttackMenu/Skill_button.has_focus()):
			$Options/AttackMenu/Fight_button.grab_focus()
	
	#Enemy attack
	if(turn >= 3):
		$Options.visible = false
		for i in 3:
			var rnd = randi_range(0, 2)
			var s_strikernd1 = randi_range(0, 1)
			var s_strikernd2 = randi_range(0, 1)
			var s_strikernd3 = randi_range(0, 1)
			if(slime1_taunt or slime2_taunt or slime3_taunt):
				if(slime1_taunt and turn == 3 and hostile1.HP > 0):
					Hero.HP -= hostile1.ATK - Hero.DEF
					SqlController.database.update_rows("allies", "name = 'hero'", {"lvl": 1, "exp": 1, "gold": Global.currency, "atk": Hero.ATK, "max_att": Hero.ATK, "def": Hero.DEF, "max_def": 100, "hp": Hero.HP, "max_hp": $Allies/Hero.MaxHP, "resource": 2})
					print("s1 hit h (taunt)")
					slime1_taunt_turn += 1
					print(turn)
					if(slime1_taunt_turn == 2):
						slime1_taunt = false
				elif(slime2_taunt and turn == 4 and hostile2.HP > 0):
					Hero.HP -= hostile2.ATK - Hero.DEF
					SqlController.database.update_rows("allies", "name = 'hero'", {"lvl": 1, "exp": 1, "gold": Global.currency, "atk": Hero.ATK, "max_att": Hero.ATK, "def": Hero.DEF, "max_def": 100, "hp": Hero.HP, "max_hp": $Allies/Hero.MaxHP, "resource": 2})
					print("s2 hit h (taunt)")
					if(slime2_taunt_turn == 2):
						slime2_taunt = false
				elif(slime3_taunt and turn == 5 and hostile3.HP > 0):
					Hero.HP -= hostile3.ATK - Hero.DEF
					SqlController.database.update_rows("allies", "name = 'hero'", {"lvl": 1, "exp": 1, "gold": Global.currency, "atk": Hero.ATK, "max_att": Hero.ATK, "def": Hero.DEF, "max_def": 100, "hp": Hero.HP, "max_hp": $Allies/Hero.MaxHP, "resource": 2})
					print("s3 hit h (taunt)")
					if(slime3_taunt_turn == 2):
						slime3_taunt = false
			else:
				match rnd:
					0:
						match turn:
							3:
								if(_shadowstrike_token1 > 1 and hostile1.HP > 0):
									if(s_strikernd1 > 0):
										Hero.HP -= hostile1.ATK - Hero.DEF
										SqlController.database.update_rows("allies", "name = 'hero'", {"lvl": 1, "exp": 1, "gold": Global.currency, "atk": Hero.ATK, "max_att": Hero.ATK, "def": Hero.DEF, "max_def": 100, "hp": Hero.HP, "max_hp": $Allies/Hero.MaxHP, "resource": 2})
										print("s1 hit h")
										print(turn)
								else:
									if(hostile1.HP > 0):
										Hero.HP -= hostile1.ATK - Hero.DEF
										SqlController.database.update_rows("allies", "name = 'hero'", {"lvl": 1, "exp": 1, "gold": Global.currency, "atk": Hero.ATK, "max_att": Hero.ATK, "def": Hero.DEF, "max_def": 100, "hp": Hero.HP, "max_hp": $Allies/Hero.MaxHP, "resource": 2})
										print("s1 hit h")
										print(turn)
							4:
								if(_shadowstrike_token2 > 1 and hostile2.HP > 0):
									if(s_strikernd2 > 0):
										Hero.HP -= hostile2.ATK - Hero.DEF
										SqlController.database.update_rows("allies", "name = 'hero'", {"lvl": 1, "exp": 1, "gold": Global.currency, "atk": Hero.ATK, "max_att": Hero.ATK, "def": Hero.DEF, "max_def": 100, "hp": Hero.HP, "max_hp": $Allies/Hero.MaxHP, "resource": 2})
										print("s2 hit h")
										print(turn)
								else:
									Hero.HP -= hostile2.ATK - Hero.DEF
									SqlController.database.update_rows("allies", "name = 'hero'", {"lvl": 1, "exp": 1, "gold": Global.currency, "atk": Hero.ATK, "max_att": Hero.ATK, "def": Hero.DEF, "max_def": 100, "hp": Hero.HP, "max_hp": $Allies/Hero.MaxHP, "resource": 2})
									print("s2 hit h")
									print(turn)
							5:
								if(_shadowstrike_token3 > 1 and hostile3.HP > 0):
									if(s_strikernd3 > 0):
										Hero.HP -= hostile3.ATK - Hero.DEF
										SqlController.database.update_rows("allies", "name = 'hero'", {"lvl": 1, "exp": 1, "gold": Global.currency, "atk": Hero.ATK, "max_att": Hero.ATK, "def": Hero.DEF, "max_def": 100, "hp": Hero.HP, "max_hp": $Allies/Hero.MaxHP, "resource": 2})
										print("s3 hit h")
										print(turn)
								else:
									Hero.HP -= hostile3.ATK - Hero.DEF
									SqlController.database.update_rows("allies", "name = 'hero'", {"lvl": 1, "exp": 1, "gold": Global.currency, "atk": Hero.ATK, "max_att": Hero.ATK, "def": Hero.DEF, "max_def": 100, "hp": Hero.HP, "max_hp": $Allies/Hero.MaxHP, "resource": 2})
									print("s3 hit h")
									print(turn)
					1:
						match turn:
							3:
								if(_shadowstrike_token1 > 1 and hostile1.HP > 0):
									if(s_strikernd1 > 0):
										Mage.HP -= hostile1.ATK - Mage.DEF
										SqlController.database.update_rows("allies", "name = 'mage'", {"lvl": 1, "exp": 1, "gold": Global.currency, "atk": Mage.ATK, "max_att": Mage.ATK, "def": Mage.DEF, "max_def": 100, "hp": Mage.HP, "max_hp": $Allies/Mage.MaxHP, "resource": 2})
										print("s1 hit m")
										print(turn)
								else:
									if(hostile1.HP > 0 and hostile1.HP > 0):
										Mage.HP -= hostile1.ATK - Mage.DEF
										SqlController.database.update_rows("allies", "name = 'mage'", {"lvl": 1, "exp": 1, "gold": Global.currency, "atk": Mage.ATK, "max_att": Mage.ATK, "def": Mage.DEF, "max_def": 100, "hp": Mage.HP, "max_hp": $Allies/Mage.MaxHP, "resource": 2})
										print("s1 hit m")
										print(turn)
							4:
								if(_shadowstrike_token2 > 1 and hostile2.HP > 0):
									if(s_strikernd2 > 0):
										Mage.HP -= hostile2.ATK - Mage.DEF
										SqlController.database.update_rows("allies", "name = 'mage'", {"lvl": 1, "exp": 1, "gold": Global.currency, "atk": Mage.ATK, "max_att": Mage.ATK, "def": Mage.DEF, "max_def": 100, "hp": Mage.HP, "max_hp": $Allies/Mage.MaxHP, "resource": 2})
										print("s2 hit m")
										print(turn)
								else:
									Mage.HP -= hostile2.ATK - Mage.DEF
									SqlController.database.update_rows("allies", "name = 'mage'", {"lvl": 1, "exp": 1, "gold": Global.currency, "atk": Mage.ATK, "max_att": Mage.ATK, "def": Mage.DEF, "max_def": 100, "hp": Mage.HP, "max_hp": $Allies/Mage.MaxHP, "resource": 2})
									print("s2 hit m")
									print(turn)
							5:
								if(_shadowstrike_token3 > 1 and hostile3.HP > 0):
									if(s_strikernd3 > 0):
										Mage.HP -= hostile3.ATK - Mage.DEF
										SqlController.database.update_rows("allies", "name = 'mage'", {"lvl": 1, "exp": 1, "gold": Global.currency, "atk": Mage.ATK, "max_att": Mage.ATK, "def": Mage.DEF, "max_def": 100, "hp": Mage.HP, "max_hp": $Allies/Mage.MaxHP, "resource": 2})
										print("s3 hit m")
										print(turn)
								else:
									Mage.HP -= hostile3.ATK - Mage.DEF
									SqlController.database.update_rows("allies", "name = 'mage'", {"lvl": 1, "exp": 1, "gold": Global.currency, "atk": Mage.ATK, "max_att": Mage.ATK, "def": Mage.DEF, "max_def": 100, "hp": Mage.HP, "max_hp": $Allies/Mage.MaxHP, "resource": 2})
									print("s3 hit m")
									print(turn)
					2:
						if(!_night_blade_token):
							match turn:
								3:
									if(_shadowstrike_token1 > 1 and hostile1.HP > 0):
										if(s_strikernd1 > 0):
											Thief.HP -= hostile1.ATK - Thief.DEF
											SqlController.database.update_rows("allies", "name = 'thief'", {"lvl": 1, "exp": 1, "gold": Global.currency, "atk": Thief.ATK, "max_att": Thief.ATK, "def": Thief.DEF, "max_def": 100, "hp": Thief.HP, "max_hp": $Allies/Thief.MaxHP, "resource": 2})
											print("s1 hit t")
											print(turn)
									else:
										if(hostile1.HP > 0):
											Thief.HP -= hostile1.ATK - Thief.DEF
											SqlController.database.update_rows("allies", "name = 'thief'", {"lvl": 1, "exp": 1, "gold": Global.currency, "atk": Thief.ATK, "max_att": Thief.ATK, "def": Thief.DEF, "max_def": 100, "hp": Thief.HP, "max_hp": $Allies/Thief.MaxHP, "resource": 2})
											print("s1 hit t")
											print(turn)
								4:
									if(_shadowstrike_token2 > 1 and hostile2.HP > 0):
										if(s_strikernd2 > 0):
											Thief.HP -= hostile2.ATK - Thief.DEF
											SqlController.database.update_rows("allies", "name = 'thief'", {"lvl": 1, "exp": 1, "gold": Global.currency, "atk": Thief.ATK, "max_att": Thief.ATK, "def": Thief.DEF, "max_def": 100, "hp": Thief.HP, "max_hp": $Allies/Thief.MaxHP, "resource": 2})
											print("s2 hit t")
											print(turn)
									else:
										Thief.HP -= hostile2.ATK - Thief.DEF
										SqlController.database.update_rows("allies", "name = 'thief'", {"lvl": 1, "exp": 1, "gold": Global.currency, "atk": Thief.ATK, "max_att": Thief.ATK, "def": Thief.DEF, "max_def": 100, "hp": Thief.HP, "max_hp": $Allies/Thief.MaxHP, "resource": 2})
										print("s2 hit t")
										print(turn)
								5:
									if(_shadowstrike_token3 > 1 and hostile3.HP > 0):
										if(s_strikernd3 > 0):
											Thief.HP -= hostile3.ATK - Thief.DEF
											SqlController.database.update_rows("allies", "name = 'thief'", {"lvl": 1, "exp": 1, "gold": Global.currency, "atk": Thief.ATK, "max_att": Thief.ATK, "def": Thief.DEF, "max_def": 100, "hp": Thief.HP, "max_hp": $Allies/Thief.MaxHP, "resource": 2})
											print("s3 hit t")
											print(turn)
									else:
										Thief.HP -= hostile3.ATK - Thief.DEF
										SqlController.database.update_rows("allies", "name = 'thief'", {"lvl": 1, "exp": 1, "gold": Global.currency, "atk": Thief.ATK, "max_att": Thief.ATK, "def": Thief.DEF, "max_def": 100, "hp": Thief.HP, "max_hp": $Allies/Thief.MaxHP, "resource": 2})
										print("s3 hit t")
										print(turn)
						else:
							print("evasion")
					_:
						print("D:")
			turn += 1
		if(hero_guard):
			Hero.DEF -= 5
			SqlController.database.update_rows("allies", "name = 'hero'", {"lvl": 1, "exp": 1, "gold": Global.currency, "atk": Hero.ATK, "max_att": Hero.ATK, "def": Hero.DEF, "max_def": 100, "hp": Hero.HP, "max_hp": $Allies/Hero.MaxHP, "resource": 2})
		if(mage_guard):
			Mage.DEF -= 5
			SqlController.database.update_rows("allies", "name = 'mage'", {"lvl": 1, "exp": 1, "gold": Global.currency, "atk": Mage.ATK, "max_att": Mage.ATK, "def": Mage.DEF, "max_def": 100, "hp": Mage.HP, "max_hp": $Allies/Mage.MaxHP, "resource": 2})
		if(thief_guard):
			Thief.DEF -= 5
			SqlController.database.update_rows("allies", "name = 'thief'", {"lvl": 1, "exp": 1, "gold": Global.currency, "atk": Thief.ATK, "max_att": Thief.ATK, "def": Thief.DEF, "max_def": 100, "hp": Thief.HP, "max_hp": $Allies/Thief.MaxHP, "resource": 2})
		turn = 0
		print(turn)
		$Options/AttackMenu/Fight_button.grab_focus()
		#hero token
		if(_defense_token>0):
			if(_defense_token > 2):
				_defense_token = 0
				if(!_decimate_token):
					Hero.DEF -= 10
					SqlController.database.update_rows("allies", "name = 'hero'", {"lvl": 1, "exp": 1, "gold": Global.currency, "atk": Hero.ATK, "max_att": Hero.ATK, "def": Hero.DEF, "max_def": 100, "hp": Hero.HP, "max_hp": $Allies/Hero.MaxHP, "resource": 2})
				$"Effects/Hero_effect/Defensive-Icon".visible = false
			else:
				_defense_token += 1
		if(_bloodlust_token>0):
			if(_bloodlust_token > 2):
				_bloodlust_token = 0
				Hero.ATK -= 10
				SqlController.database.update_rows("allies", "name = 'hero'", {"lvl": 1, "exp": 1, "gold": Global.currency, "atk": Hero.ATK, "max_att": Hero.ATK, "def": Hero.DEF, "max_def": 100, "hp": Hero.HP, "max_hp": $Allies/Hero.MaxHP, "resource": 2})
				$"Effects/Hero_effect/Bloodlust-Icon".visible = false
			else:
				_bloodlust_token += 1
		if(_decimate_token>0):
			if(_decimate_token > 2):
				_decimate_token = 0
				Hero.DEF += 20
				SqlController.database.update_rows("allies", "name = 'hero'", {"lvl": 1, "exp": 1, "gold": Global.currency, "atk": Hero.ATK, "max_att": Hero.ATK, "def": Hero.DEF, "max_def": 100, "hp": Hero.HP, "max_hp": $Allies/Hero.MaxHP, "resource": 2})
				$"Effects/Hero_effect/Decimate-Icon".visible = false
			else:
				_decimate_token += 1
		#mage token
		if(_fireball_token1 > 0):
			if(_fireball_token1 > 2):
				_fireball_token1 = 0
				$"Effects/Slime1_effect/Fireball-Icon".visible = false
			else:
				_fireball_token1 += 1
				hostile1.HP -= Mage.ATK*0.5
				SqlController.database.update_rows("hostiles", "name = 'hostile1'", {"atk": hostile1.ATK, "max_att": 2, "def": hostile1.DEF, "max_def": 100, "hp": $Hostiles/Slime.HP, "max_hp": $Hostiles/Slime.MaxHP})
				print("m hit s1 (DoT)")
		if(_fireball_token2 > 0):
			if(_fireball_token2 > 2):
				_fireball_token2 = 0
				$"Effects/Slime2_effect/Fireball-Icon".visible = false
			else:
				_fireball_token2 += 1
				hostile2.HP -= Mage.ATK*0.5
				SqlController.database.update_rows("hostiles", "name = 'hostile2'", {"atk": hostile2.ATK, "max_att": 2, "def": hostile2.DEF, "max_def": 100, "hp": $Hostiles/Slime2.HP, "max_hp": $Hostiles/Slime2.MaxHP})
				print("m hit s2 (DoT)")
		if(_fireball_token3 > 0):
			if(_fireball_token3 > 2):
				_fireball_token3 = 0
				$"Effects/Slime3_effect/Fireball-Icon".visible = false
			else:
				_fireball_token3 += 1
				hostile3.HP -= Mage.ATK*0.5
				SqlController.database.update_rows("hostiles", "name = 'hostile3'", {"atk": hostile3.ATK, "max_att": 2, "def": hostile3.DEF, "max_def": 100, "hp": $Hostiles/Slime3.HP, "max_hp": $Hostiles/Slime3.MaxHP})
				print("m hit s3 (DoT)")
		if(_empower_token1 > 0):
			if (_empower_token1 > 2):
				_empower_token1 = 0
				Hero.ATK -= 10
				SqlController.database.update_rows("allies", "name = 'hero'", {"lvl": 1, "exp": 1, "gold": Global.currency, "atk": Hero.ATK, "max_att": Hero.ATK, "def": Hero.DEF, "max_def": 100, "hp": Hero.HP, "max_hp": $Allies/Hero.MaxHP, "resource": 2})
				$"Effects/Hero_effect/Empower-Icon".visible = false
			else:
				_empower_token1 += 1
		if(_empower_token2 > 0):
			if (_empower_token2 > 2):
				_empower_token2 = 0
				Mage.ATK -= 10
				SqlController.database.update_rows("allies", "name = 'mage'", {"lvl": 1, "exp": 1, "gold": Global.currency, "atk": Mage.ATK, "max_att": Mage.ATK, "def": Hero.DEF, "max_def": 100, "hp": Mage.HP, "max_hp": $Allies/Mage.MaxHP, "resource": 2})
				$"Effects/Mage_effect/Empower-Icon".visible = false
			else:
				_empower_token1 += 1
		if(_empower_token3 > 0):
			if (_empower_token3 > 2):
				_empower_token3 = 0
				Thief.ATK -= 10
				SqlController.database.update_rows("allies", "name = 'thief'", {"lvl": 1, "exp": 1, "gold": Global.currency, "atk": Thief.ATK, "max_att": Thief.ATK, "def": Thief.DEF, "max_def": 100, "hp": Thief.HP, "max_hp": $Allies/Thief.MaxHP, "resource": 2})
				$"Effects/Thief_effect/Empower-Icon".visible = false
			else:
				_empower_token3 += 1
		if(_resistance_token1 > 0):
			if (_resistance_token1 > 2):
				_resistance_token1 = 0
				Hero.DEF -= 10
				SqlController.database.update_rows("allies", "name = 'hero'", {"lvl": 1, "exp": 1, "gold": Global.currency, "atk": Hero.ATK, "max_att": Hero.ATK, "def": Hero.DEF, "max_def": 100, "hp": Hero.HP, "max_hp": $Allies/Hero.MaxHP, "resource": 2})
				$"Effects/Hero_effect/Resistance-Icon".visible = false
			else:
				_resistance_token1 += 1
		if(_resistance_token2 > 0):
			if (_resistance_token2 > 2):
				_resistance_token2 = 0
				Mage.DEF -= 10
				SqlController.database.update_rows("allies", "name = 'mage'", {"lvl": 1, "exp": 1, "gold": Global.currency, "atk": Mage.ATK, "max_att": Mage.ATK, "def": Mage.DEF, "max_def": 100, "hp": Mage.HP, "max_hp": $Allies/Mage.MaxHP, "resource": 2})
				$"Effects/Mage_effect/Resistance-Icon".visible = false
			else:
				_resistance_token1 += 1
		if(_resistance_token3 > 0):
			if (_resistance_token3 > 2):
				_resistance_token3 = 0
				Thief.DEF -= 10
				SqlController.database.update_rows("allies", "name = 'thief'", {"lvl": 1, "exp": 1, "gold": Global.currency, "atk": Thief.ATK, "max_att": Thief.ATK, "def": Thief.DEF, "max_def": 100, "hp": Thief.HP, "max_hp": $Allies/Thief.MaxHP, "resource": 2})
				$"Effects/Thief_effect/Resistance-Icon".visible = false
			else:
				_resistance_token3 += 1
		if(_thunder_token1 > 0):
			if(_thunder_token1 > 2):
				_thunder_token1 = 0
				hostile1.DEF += 10
				SqlController.database.update_rows("hostiles", "name = 'hostile1'", {"atk": hostile1.ATK, "max_att": 2, "def": hostile1.DEF, "max_def": 100, "hp": $Hostiles/Slime.HP, "max_hp": $Hostiles/Slime.MaxHP})
				$"Effects/Slime1_effect/Thunder-Icon".visible = false
			else:
				_thunder_token1 += 1
		if(_thunder_token2 > 0):
			if(_thunder_token2 > 2):
				_thunder_token2 = 0
				hostile2.DEF += 10
				SqlController.database.update_rows("hostiles", "name = 'hostile2'", {"atk": hostile2.ATK, "max_att": 2, "def": hostile2.DEF, "max_def": 100, "hp": $Hostiles/Slime2.HP, "max_hp": $Hostiles/Slime2.MaxHP})
				$"Effects/Slime2_effect/Thunder-Icon".visible = false
			else:
				_thunder_token2 += 1
		if(_thunder_token3 > 0):
			if(_thunder_token3 > 2):
				_thunder_token3 = 0
				hostile3.DEF += 10
				SqlController.database.update_rows("hostiles", "name = 'hostile3'", {"atk": hostile3.ATK, "max_att": 2, "def": hostile3.DEF, "max_def": 100, "hp": $Hostiles/Slime3.HP, "max_hp": $Hostiles/Slime3.MaxHP})
				$"Effects/Slime3_effect/Thunder-Icon"
			else:
				_thunder_token3 += 1
		#thief tokens
		if(_envenom_token1 > 0):
			if(_envenom_token1 > 2):
				_envenom_token1 = 0
				$"Effects/Slime1_effect/Envenom-Icon".visible = false
			else:
				_envenom_token1 += 1
				hostile1.HP -= Thief.ATK*0.5*_envenom_used_combo1
				SqlController.database.update_rows("hostiles", "name = 'hostile1'", {"atk": hostile1.ATK, "max_att": 2, "def": hostile1.DEF, "max_def": 100, "hp": $Hostiles/Slime.HP, "max_hp": $Hostiles/Slime.MaxHP})
				print("t hit s1 (PDoT)")
		if(_envenom_token2 > 0):
			if(_envenom_token2 > 2):
				_envenom_token2 = 0
				$"Effects/Slime2_effect/Envenom-Icon".visible = false
			else:
				_envenom_token2 += 1
				hostile2.HP -= Thief.ATK*0.5*_envenom_used_combo2
				SqlController.database.update_rows("hostiles", "name = 'hostile2'", {"atk": hostile2.ATK, "max_att": 2, "def": hostile2.DEF, "max_def": 100, "hp": $Hostiles/Slime2.HP, "max_hp": $Hostiles/Slime2.MaxHP})
				print("t hit s2 (PDoT)")
		if(_envenom_token3 > 0):
			if(_envenom_token3 > 2):
				_envenom_token3 = 0
				$"Effects/Slime3_effect/Envenom-Icon".visible = false
			else:
				_envenom_token3 += 1
				hostile3.HP -= Thief.ATK*0.5*_envenom_used_combo3
				SqlController.database.update_rows("hostiles", "name = 'hostile3'", {"atk": hostile3.ATK, "max_att": 2, "def": hostile3.DEF, "max_def": 100, "hp": $Hostiles/Slime3.HP, "max_hp": $Hostiles/Slime3.MaxHP})
				print("t hit s3 (PDoT)")
		
		if(_rupture_token1 > 0):
			if(_rupture_token1 > 2):
				_rupture_token1 = 0
				$"Effects/Slime1_effect/Bleed-Icon".visible = false
			else:
				_rupture_token1 += 1
				hostile1.HP -= Thief.ATK*0.5*_rupture_used_combo1
				SqlController.database.update_rows("hostiles", "name = 'hostile1'", {"atk": hostile1.ATK, "max_att": 2, "def": hostile1.DEF, "max_def": 100, "hp": $Hostiles/Slime.HP, "max_hp": $Hostiles/Slime.MaxHP})
				print("t hit s1 (BDoT)")
		if(_rupture_token2 > 0):
			if(_rupture_token2 > 2):
				_rupture_token2 = 0
				$"Effects/Slime2_effect/Bleed-Icon".visible = false
			else:
				_rupture_token2 += 1
				hostile2.HP -= Thief.ATK*0.5*_rupture_used_combo2
				SqlController.database.update_rows("hostiles", "name = 'hostile2'", {"atk": hostile2.ATK, "max_att": 2, "def": hostile2.DEF, "max_def": 100, "hp": $Hostiles/Slime2.HP, "max_hp": $Hostiles/Slime2.MaxHP})
				print("t hit s2 (BDoT)")
		if(_rupture_token3 > 0):
			if(_rupture_token3 > 2):
				_rupture_token3 = 0
				$"Effects/Slime3_effect/Bleed-Icon".visible = false
			else:
				_rupture_token3 += 1
				hostile3.HP -= Thief.ATK*0.5*_rupture_used_combo3
				SqlController.database.update_rows("hostiles", "name = 'hostile3'", {"atk": hostile3.ATK, "max_att": 2, "def": hostile3.DEF, "max_def": 100, "hp": $Hostiles/Slime3.HP, "max_hp": $Hostiles/Slime3.MaxHP})
				print("t hit s3 (BDoT)")
		if(_night_blade_token>0):
			if(_night_blade_token == 2):
				_night_blade_token = 0
				$"Effects/Thief_effect/Night-Blade-Icon".visible = false
			else:
				_night_blade_token += 1
		if(_shadowstrike_token1>0):
			if(_shadowstrike_token1 == 2):
				_shadowstrike_token1 = 0
				$"Effects/Slime1_effect/Shadowstrike-Icon".visible = false
			else:
				_shadowstrike_token1 += 1
		if(_shadowstrike_token2>0):
			if(_shadowstrike_token2 == 2):
				_shadowstrike_token2 = 0
				$"Effects/Slime2_effect/Shadowstrike-Icon".visible = false
			else:
				_shadowstrike_token2 += 1
		if(_shadowstrike_token3>0):
			if(_shadowstrike_token3 == 2):
				_shadowstrike_token3 = 0
				$"Effects/Slime3_effect/Shadowstrike-Icon".visible = false
			else:
				_shadowstrike_token3 += 1
		
		$Top/Players/Hero_label/Hero_status.text = "Ready"
		$Top/Players/Mage_label/Mage_status.text = "Ready"
		$Top/Players/Thief_label/Thief_status.text = "Ready"
		$Options.visible = true

#misc
func _on_v_box_container_button_focused(button: BaseButton) -> void:
	pass

func wait(seconds: float) -> void:
	await get_tree().create_timer(seconds).timeout


#main sequence
func _on_v_box_container_button_pressed(button: BaseButton) -> void: 
	print("Hero Defense: " + str(Hero.DEF) + " | Hero Attack: " + str(Hero.ATK) + " | Turn: " + str(turn))
	match button.name:
		"Fight_button":
			print("Fight")
			is_fight = !is_fight
			_fight_window(button)
		"Skill_button":
			print("Skill")
			is_skill = !is_skill
			_skill_window(button)
			
		"Item_button":
			print("Choose a character")
			is_item = !is_item
			$Options.visible = false
			inventory.visible = true
		"Guard_button":
			match turn:
				0:
					Hero.DEF += 5
					SqlController.database.update_rows("allies", "name = 'hero'", {"lvl": 1, "exp": 1, "gold": Global.currency, "atk": Hero.ATK, "max_att": Hero.ATK, "def": Hero.DEF, "max_def": 100, "hp": Hero.HP, "max_hp": $Allies/Hero.MaxHP, "resource": 2})
					hero_guard = true
					$Top/Players/Hero_label/Hero_status.text = "Guard"
					turn += 1
					print(turn)
				1:
					Mage.DEF += 5
					SqlController.database.update_rows("allies", "name = 'mage'", {"lvl": 1, "exp": 1, "gold": Global.currency, "atk": Mage.ATK, "max_att": Mage.ATK, "def": Mage.DEF, "max_def": 100, "hp": Mage.HP, "max_hp": $Allies/Mage.MaxHP, "resource": 2})
					mage_guard = true
					$Top/Players/Mage_label/Mage_status.text = "Guard"
					turn += 1
					print(turn)
				2:
					Thief.DEF += 5
					SqlController.database.update_rows("allies", "name = 'thief'", {"lvl": 1, "exp": 1, "gold": Global.currency, "atk": Thief.ATK, "max_att": Thief.ATK, "def": Thief.DEF, "max_def": 100, "hp": Thief.HP, "max_hp": $Allies/Thief.MaxHP, "resource": 2})
					thief_guard = true
					$Top/Players/Thief_label/Thief_status.text = "Guard"
					turn += 1
					print(turn)
				_:
					print("...???")
			print("Guard")
			is_guard = !is_guard
		"Flee_button":
			var rnd = randi_range(0, 1);
			if(rnd == 0):
				turn = 3
			if(rnd == 1):
				get_tree().change_scene_to_file("res://Scenes/World scenes/VillageCenter/village_center.tscn")
			print("Flee")
			is_flee = !is_flee
		_:
			print("o_o")

#Attack
func _fight_window(button: BaseButton) -> void:
	button.release_focus()
	hostile1.grab_focus()
	$Options.visible = false
	match turn:
				0:
					$Top/Players/Hero_label/Hero_status.text = "Attack"
				1:
					$Top/Players/Mage_label/Mage_status.text = "Attack"
				2:
					$Top/Players/Thief_label/Thief_status.text = "Attack"
				_:
					print(":3")

#skills
func _skill_window(button: BaseButton) -> void:
	button.release_focus()
	$Options.visible = false
	match turn:
		0:
			$Top/Players/Hero_label/Hero_status.text = "Skill"
			$Martials.visible = true
			$Martials/MatialMenu/Charge.grab_focus()
		1:
			$Top/Players/Mage_label/Mage_status.text = "Skill"
			$Spells.visible = true
			$Spells/SpellMenu/Fireball.grab_focus()
		2:
			$Top/Players/Thief_label/Thief_status.text = "Skill"
			$Combos.visible = true
			$Combos/ComboMenu/Envenom.grab_focus()


func _on_matial_menu_button_pressed(button: BaseButton) -> void:
	match button.name:
		"Charge":
			#A stronger normal attack
			if(Hero.Rage >= 5):
				hostile1.grab_focus()
				_charge_select = true
			else:
				$Top/Players/Hero_label/Hero_status.text = "Not enough Rage"
				$Martials.visible = false
				$Options.visible = true
				$Options/AttackMenu/Fight_button.grab_focus()
				is_skill = !is_skill
		"Taunt":
			#makes the enemy attack the hero for 2 turns
			if(Hero.Rage>=10):
				hostile1.grab_focus()
				_taunt_select = true
			else:
				$Top/Players/Hero_label/Hero_status.text = "Not enough Rage"
				$Martials.visible = false
				$Options.visible = true
				$Options/AttackMenu/Fight_button.grab_focus()
				is_skill = !is_skill
		"DefAttack":
			#attacks with *2 multiplier and increases DEF by 10 for two turn
			if(Hero.Rage>=5):
				hostile1.grab_focus()
				_Defensive_attack_select = true
			else:
				$Top/Players/Hero_label/Hero_status.text = "Not enough Rage"
				$Martials.visible = false
				$Options.visible = true
				$Options/AttackMenu/Fight_button.grab_focus()
				is_skill = !is_skill
		"Bloodlust":
			#attacks with 5* multiplier and increases ATK by 10 for two turn
			if(Hero.Rage>=40):
				hostile1.grab_focus()
				_bloodlust_select = true
			else:
				$Top/Players/Hero_label/Hero_status.text = "Not enough Rage"
				$Martials.visible = false
				$Options.visible = true
				$Options/AttackMenu/Fight_button.grab_focus()
				is_skill = !is_skill
		"Decimate":
			#Attacks with *15 multiplier but decreases DEF by 20 for three turns disables defensive stance if active
			if(Hero.Rage >= 20):
				hostile1.grab_focus()
				_decimate_select = true
			else:
				$Top/Players/Hero_label/Hero_status.text = "Not enough Rage"
				$Martials.visible = false
				$Options.visible = true
				$Options/AttackMenu/Fight_button.grab_focus()
				is_skill = !is_skill


func _on_spell_menu_button_pressed(button: BaseButton) -> void:
		match button.name:
			"Fireball":
				#Launches an attack with *2 multiplier and puts a burn DoT(ATK*0.5) on the enemy.
				if(Mage.Mana >= 10):
					hostile1.grab_focus()
					_fireball_select = true
				else:
					$Top/Players/Mage_label/Mage_status.text = "Not enough Mana"
					$Spells.visible = false
					$Options.visible = true
					$Options/AttackMenu/Fight_button.grab_focus()
					is_skill = !is_skill
			"Heal I":
				#Heals a selected ally by their MaxHP's 20%
				if(Mage.Mana >= 10):
					Hero.grab_focus()
					_heal_I_select = true
				else:
					$Top/Players/Mage_label/Mage_status.text = "Not enough Mana"
					$Spells.visible = false
					$Options.visible = true
					$Options/AttackMenu/Fight_button.grab_focus()
					is_skill = !is_skill
			"Empower":
				#Grants attack to ally
				if(Mage.Mana >= 5):
					Hero.grab_focus()
					_empower_select = true
				else:
					$Top/Players/Mage_label/Mage_status.text = "Not enough Mana"
					$Spells.visible = false
					$Options.visible = true
					$Options/AttackMenu/Fight_button.grab_focus()
					is_skill = !is_skill
			"Resistance":
				#Grants defense to ally
				if(Mage.Mana >= 20):
					Hero.grab_focus()
					_resistance_select = true
				else:
					$Top/Players/Mage_label/Mage_status.text = "Not enough Mana"
					$Spells.visible = false
					$Options.visible = true
					$Options/AttackMenu/Fight_button.grab_focus()
					is_skill = !is_skill
			"Thunder":
				#Attacks with 10* multiplier and Breaks enemy defense
				if(Mage.Mana >= 40):
					hostile1.grab_focus()
					_thunder_select = true
				else:
					$Top/Players/Mage_label/Mage_status.text = "Not enough Mana"
					$Spells.visible = false
					$Options.visible = true
					$Options/AttackMenu/Fight_button.grab_focus()
					is_skill = !is_skill

func _on_combo_menu_button_pressed(button: BaseButton) -> void:
		match button.name:
			"Envenom":
				#Attacks with a Combo*2 and poisons them DoT for 2 turns
				if(Thief.Combo > 0):
					hostile1.grab_focus()
					_envenom_select = true
				else:
					$Top/Players/Thief_label/Thief_status.text = "No Combo"
					$Combos.visible = false
					$Options.visible = true
					$Options/AttackMenu/Fight_button.grab_focus()
					is_skill = !is_skill
			"Eviscerate":
				#Deals high damage
				if(Thief.Combo > 0):
					hostile1.grab_focus()
					_eviscerate_select = true
				else:
					$Top/Players/Thief_label/Thief_status.text = "No Combo"
					$Combos.visible = false
					$Options.visible = true
					$Options/AttackMenu/Fight_button.grab_focus()
					is_skill = !is_skill
			"Rupture":
				#deals significant ammount of damage and stacks a bleed on enemy
				if(Thief.Combo > 0):
					hostile1.grab_focus()
					_rupture_select = true
				else:
					$Top/Players/Thief_label/Thief_status.text = "No Combo"
					$Combos.visible = false
					$Options.visible = true
					$Options/AttackMenu/Fight_button.grab_focus()
					is_skill = !is_skill
			"Night blade":
				#deals a large ammount of damage and makes all attacks towards the thief to miss.
				if(Thief.Combo > 4):
					hostile1.grab_focus()
					_night_blade_select = true
				else:
					$Top/Players/Thief_label/Thief_status.text = "Not enough Combo"
					$Combos.visible = false
					$Options.visible = true
					$Options/AttackMenu/Fight_button.grab_focus()
					is_skill = !is_skill
			"Shadowstrike":
				#deals an average ammount of damage and blinds enemies
				if(Thief.Combo > 0):
					hostile1.grab_focus()
					_shadowstrike_select = true
				else:
					$Top/Players/Thief_label/Thief_status.text = "No Combo"
					$Combos.visible = false
					$Options.visible = true
					$Options/AttackMenu/Fight_button.grab_focus()
					is_skill = !is_skill

#enemy functions
func _on_slime_pressed() -> void:
	if(!slime1_down):
		if(is_fight):
			match turn:
					0:
						hostile1.HP -= Hero.ATK - hostile1.DEF
						SqlController.database.update_rows("hostiles", "name = 'hostile1'", {"atk": hostile1.ATK, "max_att": 2, "def": hostile1.DEF, "max_def": 100, "hp": $Hostiles/Slime.HP, "max_hp": $Hostiles/Slime.MaxHP})
						if (Hero.Rage < 100):
							Hero.Rage += 5
						turn += 1
						print(turn)
					1:
						hostile1.HP -= Mage.ATK/2 - hostile1.DEF
						SqlController.database.update_rows("hostiles", "name = 'hostile1'", {"atk": hostile1.ATK, "max_att": 2, "def": hostile1.DEF, "max_def": 100, "hp": $Hostiles/Slime.HP, "max_hp": $Hostiles/Slime.MaxHP})
						turn += 1
						print(turn)
					2:
						hostile1.HP -= Thief.ATK - hostile1.DEF
						SqlController.database.update_rows("hostiles", "name = 'hostile1'", {"atk": hostile1.ATK, "max_att": 2, "def": hostile1.DEF, "max_def": 100, "hp": $Hostiles/Slime.HP, "max_hp": $Hostiles/Slime.MaxHP})
						if (Thief.Combo < 10):
							Thief.Combo += 1
						turn += 1
						print(turn)
					_:
						print("o_o")
						print(turn)
			hostile1.release_focus()
			$Options.visible = true
			$Options/AttackMenu/Fight_button.grab_focus()
			is_fight = !is_fight
		if(is_skill):
			#Hero skills
			if(_charge_select):
				hostile1.HP -= Hero.ATK*3 - hostile1.DEF
				SqlController.database.update_rows("hostiles", "name = 'hostile1'", {"atk": hostile1.ATK, "max_att": 2, "def": hostile1.DEF, "max_def": 100, "hp": $Hostiles/Slime.HP, "max_hp": $Hostiles/Slime.MaxHP})
				Hero.Rage -= 5
				turn += 1
				print(turn)
				$Martials.visible = false
				$Options.visible = true
				$Options/AttackMenu/Fight_button.grab_focus()
				_charge_select = false
				is_skill = !is_skill
			if(_taunt_select):
				slime1_taunt = true
				Hero.Rage -= 10
				turn += 1
				$"Effects/Slime1_effect/Taunt-Icon".visible = true
				print(turn)
				$Martials.visible = false
				$Options.visible = true
				$Options/AttackMenu/Fight_button.grab_focus()
				_taunt_select = false
				is_skill = !is_skill
			if(_Defensive_attack_select):
				hostile1.HP -= Hero.ATK*2 - hostile1.DEF
				SqlController.database.update_rows("hostiles", "name = 'hostile1'", {"atk": hostile1.ATK, "max_att": 2, "def": hostile1.DEF, "max_def": 100, "hp": $Hostiles/Slime.HP, "max_hp": $Hostiles/Slime.MaxHP})
				Hero.Rage -= 5
				Hero.DEF += 10
				SqlController.database.update_rows("allies", "name = 'hero'", {"lvl": 1, "exp": 1, "gold": Global.currency, "atk": Hero.ATK, "max_att": Hero.ATK, "def": Hero.DEF, "max_def": 100, "hp": Hero.HP, "max_hp": $Allies/Hero.MaxHP, "resource": 2})
				_defense_token = 1
				turn += 1
				$"Effects/Hero_effect/Defensive-Icon".visible = true
				print(turn)
				$Martials.visible = false
				$Options.visible = true
				$Options/AttackMenu/Fight_button.grab_focus()
				is_skill = !is_skill
				_Defensive_attack_select = false
			if(_bloodlust_select):
				if(_bloodlust_token == 0):
					Hero.ATK += 10
					SqlController.database.update_rows("allies", "name = 'hero'", {"lvl": 1, "exp": 1, "gold": Global.currency, "atk": Hero.ATK, "max_att": Hero.ATK, "def": Hero.DEF, "max_def": 100, "hp": Hero.HP, "max_hp": $Allies/Hero.MaxHP, "resource": 2})
				hostile1.HP -= Hero.ATK*4 - hostile1.DEF
				SqlController.database.update_rows("hostiles", "name = 'hostile1'", {"atk": hostile1.ATK, "max_att": 2, "def": hostile1.DEF, "max_def": 100, "hp": $Hostiles/Slime.HP, "max_hp": $Hostiles/Slime.MaxHP})
				Hero.Rage -= 40
				_bloodlust_token = 1
				turn += 1
				$"Effects/Hero_effect/Bloodlust-Icon".visible = true
				print(turn)
				$Martials.visible = false
				$Options.visible = true
				$Options/AttackMenu/Fight_button.grab_focus()
				is_skill = !is_skill
				_bloodlust_select = false
			if(_decimate_select):
				hostile1.HP -= Hero.ATK*30
				SqlController.database.update_rows("hostiles", "name = 'hostile1'", {"atk": hostile1.ATK, "max_att": 2, "def": hostile1.DEF, "max_def": 100, "hp": $Hostiles/Slime.HP, "max_hp": $Hostiles/Slime.MaxHP})
				Hero.DEF -= 20
				SqlController.database.update_rows("allies", "name = 'hero'", {"lvl": 1, "exp": 1, "gold": Global.currency, "atk": Hero.ATK, "max_att": Hero.ATK, "def": Hero.DEF, "max_def": 100, "hp": Hero.HP, "max_hp": $Allies/Hero.MaxHP, "resource": 2})
				if(_defense_token > 0):
					Hero.DEF -= 10
					SqlController.database.update_rows("allies", "name = 'hero'", {"lvl": 1, "exp": 1, "gold": Global.currency, "atk": Hero.ATK, "max_att": Hero.ATK, "def": Hero.DEF, "max_def": 100, "hp": Hero.HP, "max_hp": $Allies/Hero.MaxHP, "resource": 2})
				_decimate_token = 1
				turn += 1
				$"Effects/Hero_effect/Decimate-Icon".visible = true
				print(turn)
				$Martials.visible = false
				$Options.visible = true
				$Options/AttackMenu/Fight_button.grab_focus()
				is_skill = !is_skill
				_decimate_select = false
				
			#Mage spells
			if(_fireball_select):
				hostile1.HP -= Mage.ATK*2 - hostile1.DEF
				if(_fireball_token1 == 0):
					_fireball_token1 = 1
				Mage.Mana -= 10
				$"Effects/Slime1_effect/Fireball-Icon".visible = true
				turn += 1
				print(turn)
				$Spells.visible = false
				$Options.visible = true
				$Options/AttackMenu/Fight_button.grab_focus()
				is_skill = !is_skill
				_fireball_select = false
			if(_thunder_select):
				if(_thunder_token1 == 0):
					hostile1.DEF -= 10
					SqlController.database.update_rows("hostiles", "name = 'hostile1'", {"atk": hostile1.ATK, "max_att": 2, "def": hostile1.DEF, "max_def": 100, "hp": $Hostiles/Slime.HP, "max_hp": $Hostiles/Slime.MaxHP})
				hostile1.HP -= Mage.ATK*10 - hostile1.DEF
				SqlController.database.update_rows("hostiles", "name = 'hostile1'", {"atk": hostile1.ATK, "max_att": 2, "def": hostile1.DEF, "max_def": 100, "hp": $Hostiles/Slime.HP, "max_hp": $Hostiles/Slime.MaxHP})
				_thunder_token1 = 1
				Mage.Mana -= 40
				turn += 1
				$"Effects/Slime1_effect/Thunder-Icon".visible = true
				print(turn)
				$Spells.visible = false
				$Options.visible = true
				$Options/AttackMenu/Fight_button.grab_focus()
				is_skill = !is_skill
				_thunder_select = false
				
			#thief combos
			if(_envenom_select):
				hostile1.HP -= Thief.ATK*0.3*(Thief.Combo*2) - hostile1.DEF
				SqlController.database.update_rows("hostiles", "name = 'hostile1'", {"atk": hostile1.ATK, "max_att": 2, "def": hostile1.DEF, "max_def": 100, "hp": $Hostiles/Slime.HP, "max_hp": $Hostiles/Slime.MaxHP})
				if(_envenom_token1 == 0):
					_envenom_token1 = 1
					_envenom_used_combo1 = Thief.Combo
				Thief.Combo = 0
				turn += 1
				$"Effects/Slime1_effect/Envenom-Icon".visible = true
				print(turn)
				$Combos.visible = false
				$Options.visible = true
				$Options/AttackMenu/Fight_button.grab_focus()
				is_skill = !is_skill
				_envenom_select = false
			
			if (_eviscerate_select):
				hostile1.HP -= Thief.ATK*(Thief.Combo) - hostile1.DEF
				SqlController.database.update_rows("hostiles", "name = 'hostile1'", {"atk": hostile1.ATK, "max_att": 2, "def": hostile1.DEF, "max_def": 100, "hp": $Hostiles/Slime.HP, "max_hp": $Hostiles/Slime.MaxHP})
				Thief.Combo = 0
				turn += 1
				print(turn)
				$Combos.visible = false
				$Options.visible = true
				$Options/AttackMenu/Fight_button.grab_focus()
				is_skill = !is_skill
				_eviscerate_select = false
			
			if(_rupture_select):
				hostile1.HP -= Thief.ATK*0.3*(Thief.Combo*2) - hostile1.DEF
				SqlController.database.update_rows("hostiles", "name = 'hostile1'", {"atk": hostile1.ATK, "max_att": 2, "def": hostile1.DEF, "max_def": 100, "hp": $Hostiles/Slime.HP, "max_hp": $Hostiles/Slime.MaxHP})
				if(_rupture_token1 == 0):
					_rupture_token1 = 1
					_rupture_used_combo1 = Thief.Combo
				Thief.Combo = 0
				turn += 1
				$"Effects/Slime1_effect/Bleed-Icon".visible
				print(turn)
				$Combos.visible = false
				$Options.visible = true
				$Options/AttackMenu/Fight_button.grab_focus()
				is_skill = !is_skill
				_rupture_select = false
			
			if(_night_blade_select):
				hostile1.HP -= Thief.ATK * Thief.Combo - hostile1.DEF
				SqlController.database.update_rows("hostiles", "name = 'hostile1'", {"atk": hostile1.ATK, "max_att": 2, "def": hostile1.DEF, "max_def": 100, "hp": $Hostiles/Slime.HP, "max_hp": $Hostiles/Slime.MaxHP})
				_night_blade_token = 1
				Thief.Combo = 0
				turn += 1
				$"Effects/Thief_effect/Night-Blade-Icon".visible = true
				print(turn)
				$Combos.visible = false
				$Options.visible = true
				$Options/AttackMenu/Fight_button.grab_focus()
				is_skill = !is_skill
				_night_blade_select = false
			
			if(_shadowstrike_select):
				hostile1.HP -= Thief.ATK*0.3*(Thief.Combo*2) - hostile1.DEF
				SqlController.database.update_rows("hostiles", "name = 'hostile1'", {"atk": hostile1.ATK, "max_att": 2, "def": hostile1.DEF, "max_def": 100, "hp": $Hostiles/Slime.HP, "max_hp": $Hostiles/Slime.MaxHP})
				if(_shadowstrike_token1 == 0):
					_shadowstrike_token1 = 1
				Thief.Combo = 0
				turn += 1
				$"Effects/Slime1_effect/Shadowstrike-Icon".visible = true
				print(turn)
				$Combos.visible = false
				$Options.visible = true
				$Options/AttackMenu/Fight_button.grab_focus()
				is_skill = !is_skill
				_shadowstrike_select = false
	else:
		print("Enemy down")

func _on_slime_2_pressed() -> void:
	if(!slime2_down):
		if(is_fight):
			match turn:
					0:
						hostile2.HP -= Hero.ATK - hostile2.DEF
						SqlController.database.update_rows("hostiles", "name = 'hostile2'", {"atk": hostile2.ATK, "max_att": 2, "def": hostile2.DEF, "max_def": 100, "hp": $Hostiles/Slime2.HP, "max_hp": $Hostiles/Slime2.MaxHP})
						if (Hero.Rage < 100):
							Hero.Rage += 5
						turn += 1
						print(turn)
					1:
						hostile2.HP -= Mage.ATK/2 - hostile2.DEF
						SqlController.database.update_rows("hostiles", "name = 'hostile2'", {"atk": hostile2.ATK, "max_att": 2, "def": hostile2.DEF, "max_def": 100, "hp": $Hostiles/Slime2.HP, "max_hp": $Hostiles/Slime2.MaxHP})
						turn += 1
						print(turn)
					2:
						hostile2.HP -= Thief.ATK - hostile2.DEF
						SqlController.database.update_rows("hostiles", "name = 'hostile2'", {"atk": hostile2.ATK, "max_att": 2, "def": hostile2.DEF, "max_def": 100, "hp": $Hostiles/Slime2.HP, "max_hp": $Hostiles/Slime2.MaxHP})
						turn += 1
						print(turn)
					_:
						print("o_o")
						print(turn)
			hostile2.release_focus()
			$Options.visible = true
			$Options/AttackMenu/Fight_button.grab_focus()
			is_fight = !is_fight
		if(is_skill):
			if(_charge_select):
				hostile2.HP -= Hero.ATK*3 - hostile2.DEF
				SqlController.database.update_rows("hostiles", "name = 'hostile2'", {"atk": hostile2.ATK, "max_att": 2, "def": hostile2.DEF, "max_def": 100, "hp": $Hostiles/Slime2.HP, "max_hp": $Hostiles/Slime2.MaxHP})
				Hero.Rage -= 5
				turn += 1
				print(turn)
				$Martials.visible = false
				$Options.visible = true
				$Options/AttackMenu/Fight_button.grab_focus()
				_charge_select = false
				is_skill = !is_skill
			elif(_taunt_select):
				slime2_taunt = true
				Hero.Rage -= 10
				turn += 1
				$"Effects/Slime2_effect/Taunt-Icon".visible = true
				print(turn)
				$Martials.visible = false
				$Options.visible = true
				$Options/AttackMenu/Fight_button.grab_focus()
				_taunt_select = false
				is_skill = !is_skill
			if(_Defensive_attack_select):
				hostile2.HP -= Hero.ATK*2 - hostile2.DEF
				SqlController.database.update_rows("hostiles", "name = 'hostile2'", {"atk": hostile2.ATK, "max_att": 2, "def": hostile2.DEF, "max_def": 100, "hp": $Hostiles/Slime2.HP, "max_hp": $Hostiles/Slime2.MaxHP})
				Hero.Rage -= 5
				Hero.DEF += 10
				SqlController.database.update_rows("allies", "name = 'hero'", {"lvl": 1, "exp": 1, "gold": Global.currency, "atk": Hero.ATK, "max_att": Hero.ATK, "def": Hero.DEF, "max_def": 100, "hp": Hero.HP, "max_hp": $Allies/Hero.MaxHP, "resource": 2})
				_defense_token = 1
				turn += 1
				$"Effects/Hero_effect/Defensive-Icon".visible = true
				print(turn)
				$Martials.visible = false
				$Options.visible = true
				$Options/AttackMenu/Fight_button.grab_focus()
				is_skill = !is_skill
				_Defensive_attack_select = false
			if(_bloodlust_select):
				if(_bloodlust_token == 0):
					Hero.ATK += 10
					SqlController.database.update_rows("allies", "name = 'hero'", {"lvl": 1, "exp": 1, "gold": Global.currency, "atk": Hero.ATK, "max_att": Hero.ATK, "def": Hero.DEF, "max_def": 100, "hp": Hero.HP, "max_hp": $Allies/Hero.MaxHP, "resource": 2})
				hostile2.HP -= Hero.ATK*4 - hostile2.DEF
				SqlController.database.update_rows("hostiles", "name = 'hostile2'", {"atk": hostile2.ATK, "max_att": 2, "def": hostile2.DEF, "max_def": 100, "hp": $Hostiles/Slime2.HP, "max_hp": $Hostiles/Slime2.MaxHP})
				Hero.Rage -= 40
				_bloodlust_token = 1
				turn += 1
				$"Effects/Hero_effect/Bloodlust-Icon".visible = true
				print(turn)
				$Martials.visible = false
				$Options.visible = true
				$Options/AttackMenu/Fight_button.grab_focus()
				is_skill = !is_skill
				_bloodlust_select = false
			if(_decimate_select):
				hostile2.HP -= Hero.ATK*30
				SqlController.database.update_rows("hostiles", "name = 'hostile2'", {"atk": hostile2.ATK, "max_att": 2, "def": hostile2.DEF, "max_def": 100, "hp": $Hostiles/Slime2.HP, "max_hp": $Hostiles/Slime2.MaxHP})
				Hero.DEF -= 20
				SqlController.database.update_rows("allies", "name = 'hero'", {"lvl": 1, "exp": 1, "gold": Global.currency, "atk": Hero.ATK, "max_att": Hero.ATK, "def": Hero.DEF, "max_def": 100, "hp": Hero.HP, "max_hp": $Allies/Hero.MaxHP, "resource": 2})
				if(_defense_token > 0):
					Hero.DEF -= 10
					SqlController.database.update_rows("allies", "name = 'hero'", {"lvl": 1, "exp": 1, "gold": Global.currency, "atk": Hero.ATK, "max_att": Hero.ATK, "def": Hero.DEF, "max_def": 100, "hp": Hero.HP, "max_hp": $Allies/Hero.MaxHP, "resource": 2})
				_decimate_token = 1
				turn += 1
				$"Effects/Hero_effect/Decimate-Icon".visible = true
				print(turn)
				$Martials.visible = false
				$Options.visible = true
				$Options/AttackMenu/Fight_button.grab_focus()
				is_skill = !is_skill
				_decimate_select = false
			if(_fireball_select):
				hostile2.HP -= Mage.ATK*2 - hostile2.DEF
				SqlController.database.update_rows("hostiles", "name = 'hostile2'", {"atk": hostile2.ATK, "max_att": 2, "def": hostile2.DEF, "max_def": 100, "hp": $Hostiles/Slime2.HP, "max_hp": $Hostiles/Slime2.MaxHP})
				if(_fireball_token2 == 0):
					_fireball_token2 = 1
				Mage.Mana -= 10
				turn += 1
				$"Effects/Slime2_effect/Fireball-Icon".visible = true
				print(turn)
				$Spells.visible = false
				$Options.visible = true
				$Options/AttackMenu/Fight_button.grab_focus()
				is_skill = !is_skill
				_fireball_select = false
			if(_thunder_select):
				if(_thunder_token2 == 0):
					hostile1.DEF -= 10
					SqlController.database.update_rows("hostiles", "name = 'hostile1'", {"atk": hostile1.ATK, "max_att": 2, "def": hostile1.DEF, "max_def": 100, "hp": $Hostiles/Slime.HP, "max_hp": $Hostiles/Slime.MaxHP})
				hostile2.HP -= Mage.ATK*10 - hostile2.DEF
				SqlController.database.update_rows("hostiles", "name = 'hostile2'", {"atk": hostile2.ATK, "max_att": 2, "def": hostile2.DEF, "max_def": 100, "hp": $Hostiles/Slime2.HP, "max_hp": $Hostiles/Slime2.MaxHP})
				_thunder_token2 = 1
				Mage.Mana -= 40
				turn += 1
				$"Effects/Slime2_effect/Thunder-Icon".visible = true
				print(turn)
				$Spells.visible = false
				$Options.visible = true
				$Options/AttackMenu/Fight_button.grab_focus()
				is_skill = !is_skill
				_thunder_select = false
			#thief combos
			if(_envenom_select):
				hostile2.HP -= Thief.ATK*(Thief.Combo*2) - hostile2.DEF
				SqlController.database.update_rows("hostiles", "name = 'hostile2'", {"atk": hostile2.ATK, "max_att": 2, "def": hostile2.DEF, "max_def": 100, "hp": $Hostiles/Slime2.HP, "max_hp": $Hostiles/Slime2.MaxHP})
				if(_envenom_token2 == 0):
					_envenom_token2 = 1
					_envenom_used_combo2 = Thief.Combo
				Thief.Combo = 0
				turn += 1
				$"Effects/Slime2_effect/Envenom-Icon".visible = true
				print(turn)
				$Combos.visible = false
				$Options.visible = true
				$Options/AttackMenu/Fight_button.grab_focus()
				is_skill = !is_skill
				_envenom_select = false
				
			if (_eviscerate_select):
				hostile2.HP -= Thief.ATK*(Thief.Combo) - hostile2.DEF
				SqlController.database.update_rows("hostiles", "name = 'hostile2'", {"atk": hostile2.ATK, "max_att": 2, "def": hostile2.DEF, "max_def": 100, "hp": $Hostiles/Slime2.HP, "max_hp": $Hostiles/Slime2.MaxHP})
				Thief.Combo = 0
				turn += 1
				print(turn)
				$Combos.visible = false
				$Options.visible = true
				$Options/AttackMenu/Fight_button.grab_focus()
				is_skill = !is_skill
				_eviscerate_select = false
			
			if(_rupture_select):
				hostile2.HP -= Thief.ATK*0.3*(Thief.Combo*2) - hostile2.DEF
				SqlController.database.update_rows("hostiles", "name = 'hostile2'", {"atk": hostile2.ATK, "max_att": 2, "def": hostile2.DEF, "max_def": 100, "hp": $Hostiles/Slime2.HP, "max_hp": $Hostiles/Slime2.MaxHP})
				if(_rupture_token2 == 0):
					_rupture_token2 = 1
					_rupture_used_combo2 = Thief.Combo
				Thief.Combo = 0
				turn += 1
				$"Effects/Slime2_effect/Bleed-Icon".visible = true
				print(turn)
				$Combos.visible = false
				$Options.visible = true
				$Options/AttackMenu/Fight_button.grab_focus()
				is_skill = !is_skill
				_rupture_select = false
			
			if(_night_blade_select):
				hostile2.HP -= Thief.ATK * Thief.Combo - hostile2.DEF
				SqlController.database.update_rows("hostiles", "name = 'hostile2'", {"atk": hostile2.ATK, "max_att": 2, "def": hostile2.DEF, "max_def": 100, "hp": $Hostiles/Slime2.HP, "max_hp": $Hostiles/Slime2.MaxHP})
				_night_blade_token = 1
				Thief.Combo = 0
				turn += 1
				$"Effects/Thief_effect/Night-Blade-Icon".visible = true
				print(turn)
				$Combos.visible = false
				$Options.visible = true
				$Options/AttackMenu/Fight_button.grab_focus()
				is_skill = !is_skill
				_night_blade_select = false
			
			if(_shadowstrike_select):
				hostile2.HP -= Thief.ATK*0.3*(Thief.Combo*2) - hostile2.DEF
				SqlController.database.update_rows("hostiles", "name = 'hostile2'", {"atk": hostile2.ATK, "max_att": 2, "def": hostile2.DEF, "max_def": 100, "hp": $Hostiles/Slime2.HP, "max_hp": $Hostiles/Slime2.MaxHP})
				if(_shadowstrike_token2 == 0):
					_shadowstrike_token2 = 1
				Thief.Combo = 0
				turn += 1
				$"Effects/Slime2_effect/Shadowstrike-Icon".visible = true
				print(turn)
				$Combos.visible = false
				$Options.visible = true
				$Options/AttackMenu/Fight_button.grab_focus()
				is_skill = !is_skill
				_shadowstrike_select = false
	else:
		print("enemy down")


func _on_slime_3_pressed() -> void:
	if(!slime3_down):
		if(is_fight):
			match turn:
					0:
						hostile3.HP -= Hero.ATK - hostile3.DEF
						SqlController.database.update_rows("hostiles", "name = 'hostile3'", {"atk": hostile3.ATK, "max_att": 2, "def": hostile3.DEF, "max_def": 100, "hp": $Hostiles/Slime3.HP, "max_hp": $Hostiles/Slime3.MaxHP})
						if (Hero.Rage < 100):
							Hero.Rage += 5
						turn += 1
						print(turn)
					1:
						hostile3.HP -= Mage.ATK/2 - hostile3.DEF
						SqlController.database.update_rows("hostiles", "name = 'hostile3'", {"atk": hostile3.ATK, "max_att": 2, "def": hostile3.DEF, "max_def": 100, "hp": $Hostiles/Slime3.HP, "max_hp": $Hostiles/Slime3.MaxHP})
						turn += 1
						print(turn)
					2:
						hostile3.HP -= Thief.ATK - hostile3.DEF
						SqlController.database.update_rows("hostiles", "name = 'hostile3'", {"atk": hostile3.ATK, "max_att": 2, "def": hostile3.DEF, "max_def": 100, "hp": $Hostiles/Slime3.HP, "max_hp": $Hostiles/Slime3.MaxHP})
						turn += 1
						print(turn)
					_:
						print("o_o")
						print(turn)
			hostile3.release_focus()
			$Options.visible = true
			$Options/AttackMenu/Fight_button.grab_focus()
			is_fight = !is_fight
		if(is_skill):
			if(_charge_select):
				hostile3.HP -= Hero.ATK*3 - hostile3.DEF
				SqlController.database.update_rows("hostiles", "name = 'hostile3'", {"atk": hostile3.ATK, "max_att": 2, "def": hostile3.DEF, "max_def": 100, "hp": $Hostiles/Slime3.HP, "max_hp": $Hostiles/Slime3.MaxHP})
				Hero.Rage -= 5
				turn += 1
				print(turn)
				$Martials.visible = false
				$Options.visible = true
				$Options/AttackMenu/Fight_button.grab_focus()
				_charge_select = false
				is_skill = !is_skill
			elif(_taunt_select):
				slime3_taunt = true
				Hero.Rage -= 10
				turn += 1
				$"Effects/Slime3_effect/Taunt-Icon".visible = true
				print(turn)
				$Martials.visible = false
				$Options.visible = true
				$Options/AttackMenu/Fight_button.grab_focus()
				_taunt_select = false
				is_skill = !is_skill
			if(_Defensive_attack_select):
				hostile3.HP -= Hero.ATK*2 - hostile3.DEF
				SqlController.database.update_rows("hostiles", "name = 'hostile3'", {"atk": hostile3.ATK, "max_att": 2, "def": hostile3.DEF, "max_def": 100, "hp": $Hostiles/Slime3.HP, "max_hp": $Hostiles/Slime3.MaxHP})
				Hero.Rage -= 5
				Hero.DEF += 10
				SqlController.database.update_rows("allies", "name = 'hero'", {"lvl": 1, "exp": 1, "gold": Global.currency, "atk": Hero.ATK, "max_att": Hero.ATK, "def": Hero.DEF, "max_def": 100, "hp": Hero.HP, "max_hp": $Allies/Hero.MaxHP, "resource": 2})
				_defense_token = 1
				turn += 1
				$"Effects/Hero_effect/Defensive-Icon".visible = true
				print(turn)
				$Martials.visible = false
				$Options.visible = true
				$Options/AttackMenu/Fight_button.grab_focus()
				is_skill = !is_skill
				_Defensive_attack_select = false
			if(_bloodlust_select):
				if(_bloodlust_token == 0):
					Hero.ATK += 10
					SqlController.database.update_rows("allies", "name = 'hero'", {"lvl": 1, "exp": 1, "gold": Global.currency, "atk": Hero.ATK, "max_att": Hero.ATK, "def": Hero.DEF, "max_def": 100, "hp": Hero.HP, "max_hp": $Allies/Hero.MaxHP, "resource": 2})
				hostile3.HP -= Hero.ATK*4 - hostile3.DEF
				SqlController.database.update_rows("hostiles", "name = 'hostile1'", {"atk": hostile1.ATK, "max_att": 2, "def": hostile1.DEF, "max_def": 100, "hp": $Hostiles/Slime.HP, "max_hp": $Hostiles/Slime.MaxHP})
				Hero.Rage -= 40
				_bloodlust_token = 1
				turn += 1
				$"Effects/Hero_effect/Bloodlust-Icon".visible = true
				print(turn)
				$Martials.visible = false
				$Options.visible = true
				$Options/AttackMenu/Fight_button.grab_focus()
				is_skill = !is_skill
				_bloodlust_select = false
			if(_decimate_select):
				hostile3.HP -= Hero.ATK*15
				SqlController.database.update_rows("hostiles", "name = 'hostile1'", {"atk": hostile1.ATK, "max_att": 2, "def": hostile1.DEF, "max_def": 100, "hp": $Hostiles/Slime.HP, "max_hp": $Hostiles/Slime.MaxHP})
				Hero.DEF -= 20
				SqlController.database.update_rows("allies", "name = 'hero'", {"lvl": 1, "exp": 1, "gold": Global.currency, "atk": Hero.ATK, "max_att": Hero.ATK, "def": Hero.DEF, "max_def": 100, "hp": Hero.HP, "max_hp": $Allies/Hero.MaxHP, "resource": 2})
				if(_defense_token > 0):
					Hero.DEF -= 10
					SqlController.database.update_rows("allies", "name = 'hero'", {"lvl": 1, "exp": 1, "gold": Global.currency, "atk": Hero.ATK, "max_att": Hero.ATK, "def": Hero.DEF, "max_def": 100, "hp": Hero.HP, "max_hp": $Allies/Hero.MaxHP, "resource": 2})
				_decimate_token = 1
				turn += 1
				$"Effects/Hero_effect/Decimate-Icon".visible = true
				print(turn)
				$Martials.visible = false
				$Options.visible = true
				$Options/AttackMenu/Fight_button.grab_focus()
				is_skill = !is_skill
				_decimate_select = false
			if(_fireball_select):
				hostile3.HP -= Mage.ATK*2 - hostile3.DEF
				SqlController.database.update_rows("hostiles", "name = 'hostile1'", {"atk": hostile1.ATK, "max_att": 2, "def": hostile1.DEF, "max_def": 100, "hp": $Hostiles/Slime.HP, "max_hp": $Hostiles/Slime.MaxHP})
				if(_fireball_token3 == 0):
					_fireball_token3 = 1
				Mage.Mana -= 10
				turn += 1
				$"Effects/Slime3_effect/Fireball-Icon".visible = true
				print(turn)
				$Spells.visible = false
				$Options.visible = true
				$Options/AttackMenu/Fight_button.grab_focus()
				is_skill = !is_skill
				_fireball_select = false
			if(_thunder_select):
				if(_thunder_token3 == 0):
					hostile1.DEF -= 10
					SqlController.database.update_rows("hostiles", "name = 'hostile1'", {"atk": hostile1.ATK, "max_att": 2, "def": hostile1.DEF, "max_def": 100, "hp": $Hostiles/Slime.HP, "max_hp": $Hostiles/Slime.MaxHP})
				hostile3.HP -= Mage.ATK*10 - hostile3.DEF
				SqlController.database.update_rows("hostiles", "name = 'hostile1'", {"atk": hostile1.ATK, "max_att": 2, "def": hostile1.DEF, "max_def": 100, "hp": $Hostiles/Slime.HP, "max_hp": $Hostiles/Slime.MaxHP})
				_thunder_token3 = 1
				Mage.Mana -= 40
				turn += 1
				$"Effects/Slime3_effect/Thunder-Icon".visible = true
				print(turn)
				$Spells.visible = false
				$Options.visible = true
				$Options/AttackMenu/Fight_button.grab_focus()
				is_skill = !is_skill
				_thunder_select = false
			#thief combos
			if(_envenom_select):
				hostile2.HP -= Thief.ATK*(Thief.Combo*2) - hostile2.DEF
				SqlController.database.update_rows("hostiles", "name = 'hostile2'", {"atk": hostile2.ATK, "max_att": 2, "def": hostile2.DEF, "max_def": 100, "hp": $Hostiles/Slime2.HP, "max_hp": $Hostiles/Slime2.MaxHP})
				if(_envenom_token2 == 0):
					_envenom_token2 = 1
					_envenom_used_combo2 = Thief.Combo
				Thief.Combo = 0
				turn += 1
				$"Effects/Slime3_effect/Envenom-Icon".visible = true
				print(turn)
				$Combos.visible = false
				$Options.visible = true
				$Options/AttackMenu/Fight_button.grab_focus()
				is_skill = !is_skill
				_envenom_select = false
			if (_eviscerate_select):
				hostile3.HP -= Thief.ATK*(Thief.Combo) - hostile3.DEF
				SqlController.database.update_rows("hostiles", "name = 'hostile3'", {"atk": hostile3.ATK, "max_att": 2, "def": hostile3.DEF, "max_def": 100, "hp": $Hostiles/Slime3.HP, "max_hp": $Hostiles/Slime3.MaxHP})
				Thief.Combo = 0
				turn += 1
				print(turn)
				$Combos.visible = false
				$Options.visible = true
				$Options/AttackMenu/Fight_button.grab_focus()
				is_skill = !is_skill
				_eviscerate_select = false
			
			if(_rupture_select):
				hostile3.HP -= Thief.ATK*0.3*(Thief.Combo*2) - hostile3.DEF
				SqlController.database.update_rows("hostiles", "name = 'hostile3'", {"atk": hostile3.ATK, "max_att": 2, "def": hostile3.DEF, "max_def": 100, "hp": $Hostiles/Slime3.HP, "max_hp": $Hostiles/Slime3.MaxHP})
				if(_rupture_token3 == 0):
					_rupture_token3 = 1
					_rupture_used_combo1 = Thief.Combo
				Thief.Combo = 0
				turn += 1
				$"Effects/Slime3_effect/Bleed-Icon".visible = true
				print(turn)
				$Combos.visible = false
				$Options.visible = true
				$Options/AttackMenu/Fight_button.grab_focus()
				is_skill = !is_skill
				_rupture_select = false
			
			if(_night_blade_select):
				hostile3.HP -= Thief.ATK * Thief.Combo - hostile3.DEF
				SqlController.database.update_rows("hostiles", "name = 'hostile3'", {"atk": hostile3.ATK, "max_att": 2, "def": hostile3.DEF, "max_def": 100, "hp": $Hostiles/Slime3.HP, "max_hp": $Hostiles/Slime3.MaxHP})
				_night_blade_token = 1
				Thief.Combo = 0
				turn += 1
				$"Effects/Thief_effect/Night-Blade-Icon".visible = true
				print(turn)
				$Combos.visible = false
				$Options.visible = true
				$Options/AttackMenu/Fight_button.grab_focus()
				is_skill = !is_skill
				_night_blade_select = false
			
			if(_shadowstrike_select):
				hostile3.HP -= Thief.ATK*0.3*(Thief.Combo*2) - hostile3.DEF
				SqlController.database.update_rows("hostiles", "name = 'hostile3'", {"atk": hostile3.ATK, "max_att": 2, "def": hostile3.DEF, "max_def": 100, "hp": $Hostiles/Slime3.HP, "max_hp": $Hostiles/Slime3.MaxHP})
				if(_shadowstrike_token3 == 0):
					_shadowstrike_token3 = 1
				Thief.Combo = 0
				turn += 1
				$"Effects/Slime3_effect/Shadowstrike-Icon".visible = true
				print(turn)
				$Combos.visible = false
				$Options.visible = true
				$Options/AttackMenu/Fight_button.grab_focus()
				is_skill = !is_skill
				_shadowstrike_select = false
	else:
		print("enemy down")

func _on_hero_pressed() -> void:
	if(_heal_I_select):
		Hero.HP += Hero.MaxHP*0.2
		SqlController.database.update_rows("allies", "name = 'hero'", {"lvl": 1, "exp": 1, "gold": Global.currency, "atk": Hero.ATK, "max_att": Hero.ATK, "def": Hero.DEF, "max_def": 100, "hp": Hero.HP, "max_hp": $Allies/Hero.MaxHP, "resource": 2})
		print("HEAL: " + str(Mage.MaxHP*0.1))
		Mage.Mana -= 10
		turn += 1
		print(turn)
		$Spells.visible = false
		$Options.visible = true
		$Options/AttackMenu/Fight_button.grab_focus()
		is_skill = !is_skill
		_heal_I_select = false
	if(_empower_select):
		if(_empower_token3 == 0):
			Hero.ATK += 10
			SqlController.database.update_rows("allies", "name = 'hero'", {"lvl": 1, "exp": 1, "gold": Global.currency, "atk": Hero.ATK, "max_att": Hero.ATK, "def": Hero.DEF, "max_def": 100, "hp": Hero.HP, "max_hp": $Allies/Hero.MaxHP, "resource": 2})
			Hero.Rage += 5
		_empower_token1 = 1
		Mage.Mana -= 35
		turn += 1
		$"Effects/Hero_effect/Empower-Icon".visible = true
		print(turn)
		$Spells.visible = false
		$Options.visible = true
		$Options/AttackMenu/Fight_button.grab_focus()
		is_skill = !is_skill
		_empower_select = false
	if(_resistance_select):
		if(_resistance_token1 == 0):
			Hero.DEF += 10
			SqlController.database.update_rows("allies", "name = 'hero'", {"lvl": 1, "exp": 1, "gold": Global.currency, "atk": Hero.ATK, "max_att": Hero.ATK, "def": Hero.DEF, "max_def": 100, "hp": Hero.HP, "max_hp": $Allies/Hero.MaxHP, "resource": 2})
		_resistance_token1 = 1
		Mage.Mana -= 20
		turn += 1
		$"Effects/Hero_effect/Resistance-Icon".visible = true
		print(turn)
		$Spells.visible = false
		$Options.visible = true
		$Options/AttackMenu/Fight_button.grab_focus()
		is_skill = !is_skill
		_resistance_select = false

func _on_mage_pressed() -> void:
	if(_heal_I_select):
		Mage.HP += Mage.MaxHP*0.2
		SqlController.database.update_rows("allies", "name = 'mage'", {"lvl": 1, "exp": 1, "gold": Global.currency, "atk": Mage.ATK, "max_att": Mage.ATK, "def": Mage.DEF, "max_def": 100, "hp": Mage.HP, "max_hp": $Allies/Mage.MaxHP, "resource": 2})
		print("HEAL: " + str(Mage.MaxHP*0.1))
		Mage.Mana -= 10
		turn += 1
		print(turn)
		$Spells.visible = false
		$Options.visible = true
		$Options/AttackMenu/Fight_button.grab_focus()
		is_skill = !is_skill
		_heal_I_select = false
	if(_empower_select):
		if(_empower_token2 == 0):
			Mage.ATK += 10
			SqlController.database.update_rows("allies", "name = 'mage'", {"lvl": 1, "exp": 1, "gold": Global.currency, "atk": Mage.ATK, "max_att": Mage.ATK, "def": Mage.DEF, "max_def": 100, "hp": Mage.HP, "max_hp": $Allies/Mage.MaxHP, "resource": 2})
		_empower_token2 = 1
		Mage.Mana -= 30
		turn += 1
		$"Effects/Mage_effect/Empower-Icon".visible = true
		print(turn)
		$Spells.visible = false
		$Options.visible = true
		$Options/AttackMenu/Fight_button.grab_focus()
		is_skill = !is_skill
		_empower_select = false
	if(_resistance_select):
		if(_resistance_token2 == 0):
			Mage.DEF += 10
			SqlController.database.update_rows("allies", "name = 'mage'", {"lvl": 1, "exp": 1, "gold": Global.currency, "atk": Mage.ATK, "max_att": Mage.ATK, "def": Mage.DEF, "max_def": 100, "hp": Mage.HP, "max_hp": $Allies/Mage.MaxHP, "resource": 2})
		_resistance_token2 = 1
		Mage.Mana -= 20
		turn += 1
		$"Effects/Mage_effect/Resistance-Icon".visible = true
		print(turn)
		$Spells.visible = false
		$Options.visible = true
		$Options/AttackMenu/Fight_button.grab_focus()
		is_skill = !is_skill
		_resistance_select = false

func _on_thief_pressed() -> void:
	if(_heal_I_select):
		Thief.HP += Thief.MaxHP*0.2
		SqlController.database.update_rows("allies", "name = 'thief'", {"lvl": 1, "exp": 1, "gold": Global.currency, "atk": Thief.ATK, "max_att": Thief.ATK, "def": Thief.DEF, "max_def": 100, "hp": Thief.HP, "max_hp": $Allies/Thief.MaxHP, "resource": 2})
		print("HEAL: " + str(Mage.MaxHP*0.1))
		Mage.Mana -= 10
		turn += 1
		print(turn)
		$Spells.visible = false
		$Options.visible = true
		$Options/AttackMenu/Fight_button.grab_focus()
		is_skill = !is_skill
		_heal_I_select = false
	if(_empower_select):
		if(_empower_token3 == 0):
			Thief.ATK += 10
			SqlController.database.update_rows("allies", "name = 'thief'", {"lvl": 1, "exp": 1, "gold": Global.currency, "atk": Thief.ATK, "max_att": Thief.ATK, "def": Thief.DEF, "max_def": 100, "hp": Thief.HP, "max_hp": $Allies/Thief.MaxHP, "resource": 2})
			Thief.Combo += 1
		_empower_token3 = 1
		Mage.Mana -= 35
		turn += 1
		$"Effects/Thief_effect/Empower-Icon".visible = true
		print(turn)
		$Spells.visible = false
		$Options.visible = true
		$Options/AttackMenu/Fight_button.grab_focus()
		is_skill = !is_skill
		_empower_select = false
	if(_resistance_select):
		if(_resistance_token3 == 0):
			Thief.DEF += 10
			SqlController.database.update_rows("allies", "name = 'thief'", {"lvl": 1, "exp": 1, "gold": Global.currency, "atk": Thief.ATK, "max_att": Thief.ATK, "def": Thief.DEF, "max_def": 100, "hp": Thief.HP, "max_hp": $Allies/Thief.MaxHP, "resource": 2})
		_resistance_token3 = 1
		Mage.Mana -= 20
		turn += 1
		$"Effects/Thief_effect/Resistance-Icon".visible = true
		print(turn)
		$Spells.visible = false
		$Options.visible = true
		$Options/AttackMenu/Fight_button.grab_focus()
		is_skill = !is_skill
		_resistance_select = false

func _on_item_button_gui_input(event):
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT and event.is_pressed():
			attackMenu.visible = !attackMenu.visible
			inventory.visible = true

func _on_attack_menu_button_pressed(button: BaseButton) -> void:
	match button.name:
		"HeroInventory":
			print("Hero")
			hero = !hero
		"MageInventory":
			print("Mage")
			mage = !mage
		"ThiefInventory":
			print("Thief")
			thief = !thief


func _on_quit_pressed() -> void:
	if inventory.visible == true:
		inventory.visible = false
		attackMenu.visible = true
func apply_item_effect(item):
	match(turn):
		0:
			turn += 1
			$Top/Players/Hero_label/Hero_status.text = "Item"
			
			match item["effect"]:
				"Healing":
					if Hero.Hp < 100:
						Hero.HP += 10
						SqlController.database.update_rows("allies", "name = 'hero'", {"lvl": 1, "exp": 1, "gold": Global.currency, "atk": Hero.ATK, "max_att": Hero.ATK, "def": Hero.DEF, "max_def": 100, "hp": Hero.HP, "max_hp": $Allies/Hero.MaxHP, "resource": 2})
						print("HP increase to ", Hero.HP)
						inventory.visible = false
						attackMenu.visible = true
					if Hero.HP >= 100:
						Hero.HP = 100
						SqlController.database.update_rows("allies", "name = 'hero'", {"lvl": 1, "exp": 1, "gold": Global.currency, "atk": Hero.ATK, "max_att": Hero.ATK, "def": Hero.DEF, "max_def": 100, "hp": Hero.HP, "max_hp": $Allies/Hero.MaxHP, "resource": 2})
						inventory.visible = false
						attackMenu.visible = true
				"Stamina":
					Hero.Rage += 15
					inventory.visible = false
					attackMenu.visible = true
				"dagger":
					Hero.ATK += 20
					SqlController.database.update_rows("allies", "name = 'hero'", {"lvl": 1, "exp": 1, "gold": Global.currency, "atk": Hero.ATK, "max_att": Hero.ATK, "def": Hero.DEF, "max_def": 100, "hp": Hero.HP, "max_hp": $Allies/Hero.MaxHP, "resource": 2})
					inventory.visible = false
					attackMenu.visible = true
				_:
					print("There is no effect for this item")
		1:
			turn += 1
			$Top/Players/Mage_label/Mage_status.text = "Item"
			
			match item["effect"]:
				"Healing":
					if Mage.Hp < 100:
						Mage.HP += 10
						SqlController.database.update_rows("allies", "name = 'mage'", {"lvl": 1, "exp": 1, "gold": Global.currency, "atk": Mage.ATK, "max_att": Mage.ATK, "def": Mage.DEF, "max_def": 100, "hp": Mage.HP, "max_hp": $Allies/Mage.MaxHP, "resource": 2})
						print("HP increase to ", Mage.HP)
						inventory.visible = false
						attackMenu.visible = true
					if Mage.HP >= 100:
						Mage.HP = 100
						SqlController.database.update_rows("allies", "name = 'mage'", {"lvl": 1, "exp": 1, "gold": Global.currency, "atk": Mage.ATK, "max_att": Mage.ATK, "def": Mage.DEF, "max_def": 100, "hp": Mage.HP, "max_hp": $Allies/Mage.MaxHP, "resource": 2})
				"Mana":
					Mage.Mana += 15
					inventory.visible = false
					attackMenu.visible = true
				"Stamina":
					Mage.Rage += 15
					inventory.visible = false
					attackMenu.visible = true
				_:
					print("There is no effect for this item")
		2:
			turn += 1
			$Top/Players/Thief_label/Thief_status.text = "item"
			match item["effect"]:
				"Healing":
					if Thief.Hp < 100:
						Thief.HP += 10
						SqlController.database.update_rows("allies", "name = 'thief'", {"lvl": 1, "exp": 1, "gold": Global.currency, "atk": Thief.ATK, "max_att": Thief.ATK, "def": Thief.DEF, "max_def": 100, "hp": Mage.HP, "max_hp": $Allies/Thief.MaxHP, "resource": 2})
						print("HP increase to ", Mage.HP)
						inventory.visible = false
						attackMenu.visible = true
					if Thief.HP >= 100:
						Thief.HP = 100
						inventory.visible = false
						attackMenu.visible = true
				_:
					print("There is no effect for this item")
		_:
			print("???")
