extends Area2D
var player_in:bool=false
onready var sprite2=$Sprite
onready var healthui=get_node("/root/world/CanvasLayer/HealthUI")


func _input(event):
	if player_in:
		if event.is_action_pressed("interact"):
			var dialogic=Dialogic.start("泉水")
			dialogic.connect('dialogic_signal',self,"dialogic_end")
			add_child(dialogic)
			get_tree().paused=true

func dialogic_end(value):
	if value=="泉水":
		get_tree().paused=false
		Playerstats.health=Playerstats.max_health
		healthui._on_player_health_changed()


func _on_lake_body_entered(body):
	if body==get_node("/root/world/YSort/player"):
		player_in=true
		sprite2.visible=true
	pass # Replace with function body.


func _on_lake_body_exited(body):
	if body==get_node("/root/world/YSort/player"):
		sprite2.visible=false
		player_in=false
	pass # Replace with function body.
