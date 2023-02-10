extends GridContainer

onready var label=get_node("/root/world/CanvasLayer/Label")
onready var shop=get_node("/root/world/CanvasLayer/Shop")
onready var healthui=get_node("/root/world/CanvasLayer/HealthUI")
onready var player=get_node("/root/world/YSort/player")
onready var player_hurtbox=get_node("/root/world/YSort/player/Hurtboxes")
onready var label1=$TextureRect1/TextureRect/Label2
onready var label2=$TextureRect2/TextureRect/Label2
onready var label3=$TextureRect3/TextureRect/Label2
onready var label4=$TextureRect4/TextureRect/Label2
onready var timer1=$Timer
var prop0=[0,0,0,0]

func set_prop(value,num):
	if num<0:
		if prop0[value-1]+num<0:
			label.show_label("您的药水已耗尽",1.5)
		else:
			prop0[value-1]+=num
			drink(value)
	if num>0:
		prop0[value-1]+=num
	label1.text=str(prop0[0])
	label2.text=str(prop0[1])
	label3.text=str(prop0[2])
	label4.text=str(prop0[3])


func drink(value):
	match value:
		1:
			Playerstats.health=min(Playerstats.health+3,Playerstats.max_health)
			healthui._on_player_health_changed()
		2:
			Playerstats.health=min(Playerstats.health+6,Playerstats.max_health)
			healthui._on_player_health_changed()
		3:
			player.speed_level+=1
			timer1.start(10)
		4:
			player_hurtbox.start_invincibility(5)

func _on_Timer_timeout():
	player.speed_level-=1
	pass # Replace with function body.

func _input(event):
	if event.is_action_pressed("prop_1"):
		set_prop(1,-1)
	if event.is_action_pressed("prop_2"):
		set_prop(2,-1)
	if event.is_action_pressed("prop_3"):
		set_prop(3,-1)
	if event.is_action_pressed("prop_4"):
		set_prop(4,-1)
