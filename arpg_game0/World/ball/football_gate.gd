extends Node2D

signal right_gate_entered()


func _on_Area2D_body_entered(body):
	if body==get_node("/root/world/YSort/football_field/football"):
		body.out_flag=true
		emit_signal("right_gate_entered")
