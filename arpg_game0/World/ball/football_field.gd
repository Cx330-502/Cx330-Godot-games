extends YSort

onready var npc_boy=$NPC_boy
onready var label=$Label
onready var boy_position=$Boy_position
onready var timer=$Timer
onready var prop=get_node("/root/world/CanvasLayer/prop")
onready var healthui=get_node("/root/world/CanvasLayer/HealthUI")
onready var label2=get_node("/root/world/CanvasLayer/Label")
var competition_in:bool=false

func _on_Label_Footballgame_over():
	if label.right_score==3:
		var dialogic=Dialogic.start("小孩_win")
		dialogic.connect('dialogic_signal',self,"dialogic_end")
		get_tree().paused=true
		add_child(dialogic)
	else:
		var dialogic=Dialogic.start("小孩_lose")
		dialogic.connect('dialogic_signal',self,"dialogic_end")
		get_tree().paused=true
		add_child(dialogic)
	competition_in=false
	timer.start()


func _on_Timer_timeout():
	label.reset_score()
	timer.stop()

func dialogic_end(value):
	if value=="lose":
		get_tree().paused=false
	elif value=="win":
		var i=rand_range(1,13)
		if i==9 :
			prop.set_prop(3,1)
			label2.show_label("你获得了轻灵药水",1.5)
		elif i==10 :
			prop.set_prop(4,1)
			label2.show_label("你获得了无敌药水",1.5)
		elif i>10:
			Playerstats.max_health+=1
			Playerstats.health=Playerstats.max_health
			healthui._on_player_health_changed()
			label2.show_label("你获得了圣血药",1.5)
		elif i<6 :
			prop.set_prop(1,1)
			label2.show_label("你获得了小血药",1.5)
		else :
			prop.set_prop(2,1)
			label2.show_label("你获得了大血药",1.5)
		get_tree().paused=false
