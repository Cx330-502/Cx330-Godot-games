extends Label

var right_score:int=0
var left_score:int=0

signal Footballgame_over

onready var label1=$Label1
onready var label2=$Label2
onready var label3=$Label3

func _ready():
	text=" : "
	label3.visible=false
	update_score()


func update_score():
	label1.text=str(left_score)
	label2.text=str(right_score)
	if left_score==3:
		label3.visible=true
		label3.set("custom_colors/font_color",Color.red)
		label3.text="你输啦！"
		emit_signal("Footballgame_over")
	elif right_score==3:
		label3.visible=true
		label3.set("custom_colors/font_color",Color.blue)
		label3.text="你赢啦！"
		emit_signal("Footballgame_over")


func _on_football_gate_right_gate_entered():
	if get_parent().competition_in: 
		left_score+=1
		update_score()


func _on_football_gate2_left_gate_entered():
	if get_parent().competition_in: 
		right_score+=1
		update_score()


func reset_score():
	label3.visible=false
	right_score=0
	left_score=0
	update_score()
