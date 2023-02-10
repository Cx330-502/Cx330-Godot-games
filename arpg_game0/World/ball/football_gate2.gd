extends Node2D

signal left_gate_entered()


func _on_Area2D_body_entered(body):
	if body==get_node("/root/world/YSort/football_field/football"):
		body.out_flag=true
		emit_signal("left_gate_entered")
