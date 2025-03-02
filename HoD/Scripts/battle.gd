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

#idk
@onready var tim = $Timer
@onready var usage_panel = $UsagePanel
@onready var details_panel = $DetailsPanel
@onready var hero_inventory = $UsagePanel/HeroButton/HeroInventoryUI
@onready var mage_inventory = $UsagePanel/MageButton/MageInventoryUI
@onready var thief_inventory = $UsagePanel/ThiefButton/ThiefInventoryUI

signal interacted(jezus: bool)

var is_fight = false
var is_skill = false
var is_item = false
var is_guard = false
var is_flee = false

var finished_action = false

var selected_hostile = 0
var slime1_select = false
var slime2_select = false
var slime3_select = false

var _charge_select = false

var turn = 0



func _ready() -> void:
	_options_menu.button_focus(0)

func _physics_process(delta: float) -> void:
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

	#Option focus fix
	if(!is_fight && !is_skill && !is_item && !is_guard && !is_flee):
		if (!$Options/AttackMenu/Fight_button.has_focus() and !$Options/AttackMenu/Flee_button.has_focus() and !$Options/AttackMenu/Guard_button.has_focus() and !$Options/AttackMenu/Item_button.has_focus() and !$Options/AttackMenu/Skill_button.has_focus()):
			$Options/AttackMenu/Fight_button.grab_focus()
	
	#Enemy attack
	if(turn >= 3):
		tim.set_wait_time(1.5)
		$Options.visible = false
		for i in 3:
			var rnd = randi_range(0, 2)
			match rnd:
				0:
					match turn:
						3:
							Hero.HP -= hostile1.ATK - Hero.DEF
							print("s1 hit h")
						4:
							Hero.HP -= hostile2.ATK - Hero.DEF
							print("s2 hit h")
						5:
							Hero.HP -= hostile3.ATK - Hero.DEF
							print("s3 hit h")
				1:
					match turn:
						3:
							Mage.HP -= hostile1.ATK - Mage.DEF
							print("s1 hit m")
						4:
							Mage.HP -= hostile2.ATK - Mage.DEF
							print("s2 hit m")
						5:
							Mage.HP -= hostile3.ATK - Mage.DEF
							print("s3 hit m")
				2:
					match turn:
						3:
							Thief.HP -= hostile1.ATK - Thief.DEF
							print("s1 hit t")
						4:
							Thief.HP -= hostile2.ATK - Thief.DEF
							print("s2 hit t")
						5:
							Thief.HP -= hostile3.ATK - Thief.DEF
							print("s3 hit t")
				_:
					print("D:")
			turn += 1
			wait(1.5)
		turn = 0
		$Top/Players/Hero_label/Hero_status.text = ""
		$Top/Players/Mage_label/Mage_status.text = ""
		$Top/Players/Thief_label/Thief_status.text = ""
		$Options.visible = true

#misc
func _on_v_box_container_button_focused(button: BaseButton) -> void:
	pass

func wait(seconds: float) -> void:
	await get_tree().create_timer(seconds).timeout


#main sequence
func _on_v_box_container_button_pressed(button: BaseButton) -> void:
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
			print("Válasszon karaktert! ")
			is_item = !is_item
		"Guard_button":
			print("Guard")
			is_guard = !is_guard
		"Flee_button":
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
			if(Hero.Rage >= 5):
				hostile1.grab_focus()
				_charge_select = true
			else:
				$Top/Players/Hero_label/Hero_status.text = "Not enough Rage"
				$Martials.visible = false
				$Options.visible = true
				$Options/AttackMenu/Fight_button.grab_focus()
				is_skill = !is_skill

func _on_spell_menu_button_pressed(button: BaseButton) -> void:
		match button.name:
			"Fireball":
				print("owo")
				turn += 1
				print(turn)
				$Spells.visible = false
				$Options.visible = true
				$Options/AttackMenu/Fight_button.grab_focus()
				is_skill = !is_skill


func _on_combo_menu_button_pressed(button: BaseButton) -> void:
		match button.name:
			"Envenom":
				print("owo")
				turn += 1
				print(turn)
				$Combos.visible = false
				$Options.visible = true
				$Options/AttackMenu/Fight_button.grab_focus()
				is_skill = !is_skill


#enemy functions
func _on_slime_pressed() -> void:
	if(is_fight):
		match turn:
				0:
					hostile1.HP -= Hero.ATK - hostile1.DEF
					if (Hero.Rage < 100):
						Hero.Rage += 5
					turn += 1
					print(turn)
				1:
					hostile1.HP -= Mage.ATK/2 - hostile1.DEF
					turn += 1
					print(turn)
				2:
					hostile1.HP -= Thief.ATK - hostile1.DEF
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
		if(_charge_select):
			hostile1.HP -= Hero.ATK*3 - hostile1.DEF
			Hero.Rage -= 5
			turn += 1
			print(turn)
			$Martials.visible = false
			$Options.visible = true
			$Options/AttackMenu/Fight_button.grab_focus()
			is_skill = !is_skill

func _on_slime_2_pressed() -> void:
	if(is_fight):
		match turn:
				0:
					hostile2.HP -= Hero.ATK - hostile2.DEF
					if (Hero.Rage < 100):
						Hero.Rage += 5
					turn += 1
					print(turn)
				1:
					hostile2.HP -= Mage.ATK/2 - hostile2.DEF
					turn += 1
					print(turn)
				2:
					hostile2.HP -= Thief.ATK - hostile2.DEF
					turn += 1
					print(turn)
				_:
					print("o_o")
					print(turn)
		hostile2.release_focus()
		$Options.visible = true
		$Options/AttackMenu/Fight_button.grab_focus()
		is_fight = !is_fight


func _on_slime_3_pressed() -> void:
	if(is_fight):
		match turn:
				0:
					hostile3.HP -= Hero.ATK - hostile3.DEF
					if (Hero.Rage < 100):
						Hero.Rage += 5
					turn += 1
					print(turn)
				1:
					hostile3.HP -= Mage.ATK/2 - hostile3.DEF
					turn += 1
					print(turn)
				2:
					hostile3.HP -= Thief.ATK - hostile3.DEF
					turn += 1
					print(turn)
				_:
					print("o_o")
					print(turn)
		hostile3.release_focus()
		$Options.visible = true
		$Options/AttackMenu/Fight_button.grab_focus()
		is_fight = !is_fight



#Inventory things
func _on_item_button_mouse_entered():
	usage_panel.visible = false
	details_panel.visible = true


func _on_item_button_mouse_exited() -> void:
	details_panel.visible = false


func _on_item_button_gui_input(event):
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT and event.is_pressed():
			usage_panel.visible = !usage_panel.visible
	


func _on_hero_button_pressed() -> void:
	hero_inventory.visible = true
	


func _on_mage_button_pressed() -> void:
	mage_inventory.visible = true


func _on_thief_button_pressed() -> void:
	thief_inventory.visible = true
	

func _on_kilep_hero_pressed() -> void:
	hero_inventory.visible = false
	

func _on_kilep_mage_pressed() -> void:
	mage_inventory.visible = false
	


func _on_kilep_thief_pressed() -> void:
	thief_inventory.visible = false
	
