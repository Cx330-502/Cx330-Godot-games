extends WindowDialog
onready var label=get_node("/root/world/CanvasLayer/Label")
onready var prop=get_node("/root/world/CanvasLayer/prop")
onready var moneyui=get_node("/root/world/CanvasLayer/MoneyUI")
onready var healthui=get_node("/root/world/CanvasLayer/HealthUI")
onready var player=get_node("/root/world/YSort/player")
onready var button3=$GridContainer/Button3
onready var button6=$GridContainer/Button6
var num1=7
var num2=1

func _on_Button_pressed():
	if moneyui.money<25:
		label.show_label("您的金钱不足",1.5)
		return
	if prop.prop0[0]>=10:
		label.show_label("您已无法携带更多",1.5)
		return
	moneyui.set_money(-25)
	prop.set_prop(1,1)


func _on_Button2_pressed():
	if moneyui.money<60:
		label.show_label("您的金钱不足",1.5)
		return
	if prop.prop0[1]>=5:
		label.show_label("您已无法携带更多",1.5)
		return
	moneyui.set_money(-60)
	prop.set_prop(2,1)


func _on_Button3_pressed():
	if moneyui.money<200:
		label.show_label("您的金钱不足",1.5)
		return
	moneyui.set_money(-200)
	Playerstats.max_health+=1
	Playerstats.health=Playerstats.max_health
	healthui._on_player_health_changed()
	num1-=1
	if num1<=0:
		button3.disabled=true


func _on_Button4_pressed():
	if moneyui.money<100:
		label.show_label("您的金钱不足",1.5)
		return
	if prop.prop0[2]>=3:
		label.show_label("您已无法携带更多",1.5)
		return
	moneyui.set_money(-100)
	prop.set_prop(3,1)


func _on_Button5_pressed():
	if moneyui.money<250:
		label.show_label("您的金钱不足",1.5)
		return
	if prop.prop0[3]>=1:
		label.show_label("您已无法携带更多",1.5)
		return
	moneyui.set_money(-250)
	prop.set_prop(4,1)


func _on_Button6_pressed():
	if moneyui.money<500:
		label.show_label("您的金钱不足",1.5)
		return
	moneyui.set_money(-500)
	player.anti+=1
	num2-=1
	if num2==0:
		button6.disabled=true
