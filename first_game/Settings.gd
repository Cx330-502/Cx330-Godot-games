extends CanvasLayer

signal difficult1
signal difficult2
signal difficult3
signal player_speedlevel_up
signal player_speedlevel_down
signal mob_speedlevel_up
signal mob_speedlevel_down

func _ready():
	$Settings/OptionButton.add_item($Settings/Node2D/label1.text,1)
	$Settings/OptionButton.add_item($Settings/Node2D/label2.text,2)
	$Settings/OptionButton.add_item($Settings/Node2D/label3.text,3)

func _on_up_pressed():
	emit_signal("player_speedlevel_up")


func _on_down_pressed():
	emit_signal("player_speedlevel_down")



func _on_mobup_pressed():
	emit_signal("mob_speedlevel_up")


func _on_mobdown_pressed():
	emit_signal("mob_speedlevel_down")


func _on_OptionButton_item_selected(index):
	if index==0:
		emit_signal("difficult1")
	if index==1:
		emit_signal("difficult2")
	if index==2:
		emit_signal("difficult3")
