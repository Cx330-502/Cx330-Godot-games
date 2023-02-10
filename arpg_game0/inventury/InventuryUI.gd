extends WindowDialog
var weapon_inventury=preload("res://inventury/weapons/Weapon_Inventury.tres")
var shield_inventury=preload("res://inventury/shield/Shield_Inventury.tres")
var shoes_inventury=preload("res://inventury/shoes/Shoes_Inventury.tres")
#onready var label=$Label
onready var player=get_node("/root/world/YSort/player")
onready var extra=get_node("/root/world/YSort/player/HitboxPivot/SwordHitbox")
onready var tabcontainer=$TabContainer
var weapon_speed:int=0
var shield_speed:int=0
var shoes_speed:int=0
var shield_defence:int=0
var shoes_defence:int=0
signal shield_changed

func _ready():
	tabcontainer.set_tab_title(0,"            武器            ")
	tabcontainer.set_tab_title(1,"            防具            ")
	tabcontainer.set_tab_title(2,"            鞋子            ")
	pass

func _on_weapon_container_equipment_changed():
	if weapon_inventury.items[8]==null:
		$Label.text="名称:"+"无"+"\n"+"攻击力:"+"0"+"\n"+"防御力:"+"0"+"\n"+"敏捷:"+"0"+"\n"
	else:
		$Label.text="名称:"+str(weapon_inventury.items[8].name)+"\n"+"攻击力:"+str(weapon_inventury.items[8].damage)+"\n"+"防御力:"+str(weapon_inventury.items[8].defence)+"\n"+"敏捷:"+str(weapon_inventury.items[8].speed)
		weapon_speed=weapon_inventury.items[8].speed
		player.speed_level=weapon_speed+shield_speed+shoes_speed
		if player.speed_level>=2:
			player.quick=true
		else:
			player.quick=false
		extra.extra_damage=weapon_inventury.items[8].damage
		if extra.extra_damage==3:
			player.quick_attack=true
		else:
			player.quick_attack=false

func _on_shield_container_equipment_changed():
	if shield_inventury.items[8]==null:
		$Label.text="名称:"+"无"+"\n"+"攻击力:"+"0"+"\n"+"防御力:"+"0"+"\n"+"敏捷:"+"0"+"\n"
	else:
		$Label.text="名称:"+str(shield_inventury.items[8].name)+"\n"+"攻击力:"+str(shield_inventury.items[8].damage)+"\n"+"防御力:"+str(shield_inventury.items[8].defence)+"\n"+"敏捷:"+str(shield_inventury.items[8].speed)
		shield_speed=shield_inventury.items[8].speed
		shield_defence=shield_inventury.items[8].defence
		player.speed_level=weapon_speed+shield_speed+shoes_speed
		if player.speed_level>=2:
			player.quick=true
		else:
			player.quick=false
		Playerstats.max_shield=shield_defence+shoes_defence
		emit_signal("shield_changed")

func _on_shoes_container_equipment_changed():
	if shoes_inventury.items[8]==null:
		$Label.text="名称:"+"无"+"\n"+"攻击力:"+"0"+"\n"+"防御力:"+"0"+"\n"+"敏捷:"+"0"+"\n"
	else:
		$Label.text="名称:"+str(shoes_inventury.items[8].name)+"\n"+"攻击力:"+str(shoes_inventury.items[8].damage)+"\n"+"防御力:"+str(shoes_inventury.items[8].defence)+"\n"+"敏捷:"+str(shoes_inventury.items[8].speed)
		shoes_speed=shoes_inventury.items[8].speed
		shoes_defence=shoes_inventury.items[8].defence
		player.speed_level=weapon_speed+shield_speed+shoes_speed
		if player.speed_level>=2:
			player.quick=true
		else:
			player.quick=false
		Playerstats.max_shield=shield_defence+shoes_defence
		emit_signal("shield_changed")


func _on_TabContainer_tab_changed(tab):
	match tab:
		0:
			if weapon_inventury.items[8]==null:
				$Label.text="名称:"+"无"+"\n"+"攻击力:"+"0"+"\n"+"防御力:"+"0"+"\n"+"敏捷:"+"0"+"\n"
			else:
				$Label.text="名称:"+str(weapon_inventury.items[8].name)+"\n"+"攻击力:"+str(weapon_inventury.items[8].damage)+"\n"+"防御力:"+str(weapon_inventury.items[8].defence)+"\n"+"敏捷:"+str(weapon_inventury.items[8].speed)
		1:
			if shield_inventury.items[8]==null:
				$Label.text="名称:"+"无"+"\n"+"攻击力:"+"0"+"\n"+"防御力:"+"0"+"\n"+"敏捷:"+"0"+"\n"
			else:
				$Label.text="名称:"+str(shield_inventury.items[8].name)+"\n"+"攻击力:"+str(shield_inventury.items[8].damage)+"\n"+"防御力:"+str(shield_inventury.items[8].defence)+"\n"+"敏捷:"+str(shield_inventury.items[8].speed)
		2:
			if shoes_inventury.items[8]==null:
				$Label.text="名称:"+"无"+"\n"+"攻击力:"+"0"+"\n"+"防御力:"+"0"+"\n"+"敏捷:"+"0"+"\n"
			else:
				$Label.text="名称:"+str(shoes_inventury.items[8].name)+"\n"+"攻击力:"+str(shoes_inventury.items[8].damage)+"\n"+"防御力:"+str(shoes_inventury.items[8].defence)+"\n"+"敏捷:"+str(shoes_inventury.items[8].speed)
	pass # Replace with function body.
