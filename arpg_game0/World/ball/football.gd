extends RigidBody2D

export var rotation_impulse:float=1000

var screensize:Vector2
var out_flag:bool=false


func _integrate_forces(state):
	if out_flag:
		state.transform.origin=$"../center_position".global_position
		state.linear_velocity=Vector2.ZERO
		out_flag=false



func _on_football_area_body_exited(body):
	if body==self:
		out_flag=true


func _on_football_body_entered(body):
	if body==get_node("/root/world/YSort/player"):
#		print("ahhhhh")
		apply_torque_impulse (rotation_impulse)
	pass # Replace with function body.
