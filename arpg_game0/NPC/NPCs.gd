extends YSort
onready var healthui=get_node("/root/world/CanvasLayer/HealthUI")
onready var acceptpopup=get_node("/root/world/CanvasLayer/AcceptDialog")
onready var moneyui=get_node("/root/world/CanvasLayer/MoneyUI")
onready var label=get_node("/root/world/CanvasLayer/Label")
onready var shop=get_node("/root/world/CanvasLayer/Shop")
onready var hitbox=get_node("/root/world/YSort/player/HitboxPivot/SwordHitbox")
var times:int=1
var kaigua:bool=false

func _on_NPC_player_interact():
	if times<6:
		var dialogic=Dialogic.start("占卜师")
		dialogic.connect('dialogic_signal',self,"dialogic_end")
		add_child(dialogic)
	else:
		var dialogic=Dialogic.start("占卜师_6")
		dialogic.connect('dialogic_signal',self,"dialogic_end")
		add_child(dialogic)
	get_tree().paused=true
	pass # Replace with function body.


func _on_NPC2_player_interact():
	var dialogic=Dialogic.start("商人")
	dialogic.connect('dialogic_signal',self,"dialogic_end")
	add_child(dialogic)
	get_tree().paused=true
	pass # Replace with function body.


func _on_NPC3_player_interact():
	var dialogic=Dialogic.start("医生")
	dialogic.connect('dialogic_signal',self,"dialogic_end")
	add_child(dialogic)
	get_tree().paused=true
	pass # Replace with function body.


func _on_NPC4_player_interact():
	var dialogic=Dialogic.start("情侣")
	dialogic.connect('dialogic_signal',self,"dialogic_end")
	add_child(dialogic)
	get_tree().paused=true
	pass # Replace with function body.


func _on_NPC5_player_interact():
	var dialogic=Dialogic.start("守卫")
	dialogic.connect('dialogic_signal',self,"dialogic_end")
	add_child(dialogic)
	get_tree().paused=true
	pass # Replace with function body.


func _on_NPC6_player_interact():
	var dialogic=Dialogic.start("情侣")
	dialogic.connect('dialogic_signal',self,"dialogic_end")
	add_child(dialogic)
	get_tree().paused=true
	pass # Replace with function body.


func _on_NPC7_player_interact():
	var dialogic=Dialogic.start("村长")
	dialogic.connect('dialogic_signal',self,"dialogic_end")
	add_child(dialogic)
	get_tree().paused=true
	pass # Replace with function body.


func _on_NPC9_player_interact():
	var dialogic=Dialogic.start("大叔")
	dialogic.connect('dialogic_signal',self,"dialogic_end")
	add_child(dialogic)
	get_tree().paused=true
	pass # Replace with function body.


func _on_NPC8_player_interact():
	var dialogic=Dialogic.start("运动的老人")
	dialogic.connect('dialogic_signal',self,"dialogic_end")
	add_child(dialogic)
	kaigua=true
	get_tree().paused=true
	pass # Replace with function body.

func dialogic_end(value):
	if value=="情侣" or value=="守卫" or value=="村长" or value=="大叔" or value=="运动的老人" or value=="占卜师_end0":
		get_tree().paused=false
		kaigua=false
	elif value=="占卜师":
		get_tree().paused=false
		if times<6:
			acceptpopup.popup_centered()
			get_tree().paused=true
	elif value=="医生":
		get_tree().paused=false
		Playerstats.health=Playerstats.max_health
		healthui._on_player_health_changed()
	elif value=="商人":
		shop.popup_centered()
	elif value=="占卜师_end":
		get_tree().paused=false
		times+=1


func _on_AcceptDialog_confirmed():
	get_tree().paused=false
	if moneyui.money>=20:
		moneyui.set_money(-20)
		match times:
			1:
				var dialogic=Dialogic.start("占卜师_1")
				dialogic.connect('dialogic_signal',self,"dialogic_end")
				add_child(dialogic)
				get_tree().paused=true

			2:
				var dialogic=Dialogic.start("占卜师_2")
				dialogic.connect('dialogic_signal',self,"dialogic_end")
				add_child(dialogic)
				get_tree().paused=true

			3:
				var dialogic=Dialogic.start("占卜师_3")
				dialogic.connect('dialogic_signal',self,"dialogic_end")
				add_child(dialogic)
				get_tree().paused=true

			4:
				var dialogic=Dialogic.start("占卜师_4")
				dialogic.connect('dialogic_signal',self,"dialogic_end")
				add_child(dialogic)
				get_tree().paused=true

			5:
				var dialogic=Dialogic.start("占卜师_5")
				dialogic.connect('dialogic_signal',self,"dialogic_end")
				add_child(dialogic)
				get_tree().paused=true
	else:
		label.show_label("您的金钱不足",3)
	pass # Replace with function body.

func _input(event):
	if kaigua and event.is_action_pressed("kaigua"):
		hitbox.damage=99
		Playerstats.max_health+=12
		Playerstats.health=Playerstats.max_health
		healthui._on_player_health_changed()


func _on_AcceptDialog_custom_action(action):
	get_tree().paused=false
	pass # Replace with function body.


func _on_AcceptDialog_popup_hide():
	get_tree().paused=false
	pass # Replace with function body.
