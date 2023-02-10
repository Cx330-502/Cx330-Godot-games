extends StaticBody2D

var player_in:bool=false
onready var sprite2=$Sprite2
onready var popuppanel=$CanvasLayer/PopupPanel

	
func _input(event):
	if player_in and get_tree().paused==false:
		if event.is_action_pressed("interact"):
			get_tree().paused=true
			popuppanel.popup_centered()


func _on_detect_player_body_entered(body):
	if body==get_node("/root/world/YSort/player"):
		player_in=true
		sprite2.visible=true
	pass # Replace with function body.


func _on_detect_player_body_exited(body):
	if body==get_node("/root/world/YSort/player"):
		sprite2.visible=false
		player_in=false
	pass # Replace with function body.

func _on_PopupPanel_popup_hide():
	get_tree().paused=false
	pass # Replace with function body.
