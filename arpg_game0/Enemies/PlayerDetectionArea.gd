extends Area2D

var player=null


func can_see_player():
	return player!=null

func _on_PlayDetectionArea_body_entered(body):
	player=body
	pass # Replace with function body.


# warning-ignore:unused_argument
func _on_PlayDetectionArea_body_exited(body):
	player=null
	pass # Replace with function body.
