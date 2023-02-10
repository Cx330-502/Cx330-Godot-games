extends StaticBody2D
var money:int
var player_in:bool=false
onready var sprite2=$Sprite2
onready var moneyui=get_node("/root/world/CanvasLayer/MoneyUI")
signal money_collect

func _on_Area2D_body_entered(body):
	if body==get_node("/root/world/YSort/player"):
		player_in=true
		sprite2.visible=true
	pass # Replace with function body.


func _on_Area2D_body_exited(body):
	if body==get_node("/root/world/YSort/player"):
		sprite2.visible=false
		player_in=false
	pass # Replace with function body.

func _input(event):
	if player_in:
		if event.is_action_pressed("interact"):
			moneyui.set_money(money)
			emit_signal("money_collect")
			queue_free()
