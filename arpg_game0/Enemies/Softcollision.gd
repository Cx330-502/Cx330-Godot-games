extends Area2D


func is_colliding():
	var areas=get_overlapping_areas()
	return areas.size()>0
	

func get_push_vector():
	var push_vector:Vector2=Vector2.ZERO
	var areas=get_overlapping_areas()
	if areas.size()>0:
		var area=areas[0]
		push_vector=area.global_position.direction_to(global_position)
		push_vector=push_vector.normalized()
		if push_vector==Vector2.ZERO:
			push_vector=Vector2.RIGHT
	return push_vector
