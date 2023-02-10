extends Control

onready var heartuiempty=$HeartUIEmpty
onready var heartuifull=$HeartUIFUll
onready var shielduiempty=$ShieldUIEmpty
onready var shielduifull=$ShieldUIFULL
onready var timer=$Timer

func _ready():
	heartuiempty.rect_size.x=Playerstats.max_health*15
	heartuifull.rect_size.x=Playerstats.health*15
	shielduiempty.rect_size.x=Playerstats.max_shield*15
	shielduifull.rect_size.x=Playerstats.shield*15
	


func _on_player_health_changed():
	heartuiempty.rect_size.x=Playerstats.max_health*15
	heartuifull.rect_size.x=Playerstats.health*15
	shielduiempty.rect_size.x=Playerstats.max_shield*15
	shielduifull.rect_size.x=Playerstats.shield*15
	if Playerstats.shield<Playerstats.max_shield:
		timer.start()

func _on_Timer_timeout():
	Playerstats.shield=min(Playerstats.shield+1,Playerstats.max_shield)
	shielduiempty.rect_size.x=Playerstats.max_shield*15
	shielduifull.rect_size.x=Playerstats.shield*15
	if Playerstats.shield==Playerstats.max_shield:
		timer.stop()
	pass # Replace with function body.


func _on_InventuryUI_shield_changed():
	Playerstats.shield=Playerstats.max_shield
	shielduiempty.rect_size.x=Playerstats.max_shield*15
	shielduifull.rect_size.x=Playerstats.shield*15
	pass # Replace with function body.
