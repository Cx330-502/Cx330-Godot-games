extends Node2D


var Grasseffect=preload("res://Effects/GrassEffect.tscn")


func _on_Hurtboxes_area_entered(area):
	var grasseffect=Grasseffect.instance()
	get_parent().add_child(grasseffect)
	grasseffect.global_position=global_position
	queue_free()
