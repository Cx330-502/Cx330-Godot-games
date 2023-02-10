extends YSort
var mob1=preload("res://Enemies/Bat.tscn")
var mob2=preload("res://Enemies/Rat.tscn")
var mob3=preload("res://Enemies/Skeleton.tscn")
var mob4=preload("res://Enemies/Zombie.tscn")
onready var mobs=$mobs



func _on_Timer_timeout():
	var i=rand_range(1,10)
	if i<=3:
		var mob=mob1.instance()
		mobs.add_child(mob)
		mob.ahh=false
		mob.global_position=$Position2D.global_position
		
	elif i<=6:
		var mob=mob2.instance()
		mobs.add_child(mob)
		mob.ahh=false
		mob.global_position=$Position2D.global_position
	elif i<=8:
		var mob=mob3.instance()
		mobs.add_child(mob)
		mob.ahh=false
		mob.global_position=$Position2D.global_position
	elif i<=9:
		var mob=mob4.instance()
		mobs.add_child(mob)
		mob.ahh=false
		mob.global_position=$Position2D.global_position
	var j=rand_range(1,10)
	if j<=3:
		var mob=mob1.instance()
		mobs.add_child(mob)
		mob.ahh=false
		mob.global_position=$Position2D2.global_position
	elif j<=6:
		var mob=mob2.instance()
		mobs.add_child(mob)
		mob.ahh=false
		mob.global_position=$Position2D2.global_position
	elif j<=8:
		var mob=mob3.instance()
		mobs.add_child(mob)
		mob.ahh=false
		mob.global_position=$Position2D2.global_position
	elif j<=9:
		var mob=mob4.instance()
		mobs.add_child(mob)
		mob.ahh=false
		mob.global_position=$Position2D2.global_position
	var k=rand_range(1,10)
	if k<=3:
		var mob=mob1.instance()
		mobs.add_child(mob)
		mob.ahh=false
		mob.global_position=$Position2D3.global_position
	elif k<=6:
		var mob=mob2.instance()
		mobs.add_child(mob)
		mob.ahh=false
		mob.global_position=$Position2D3.global_position
	elif k<=8:
		var mob=mob3.instance()
		mobs.add_child(mob)
		mob.ahh=false
		mob.global_position=$Position2D3.global_position
	elif k<=9:
		var mob=mob4.instance()
		mobs.add_child(mob)
		mob.ahh=false
		mob.global_position=$Position2D3.global_position
	var l=rand_range(1,10)
	if l<=3:
		var mob=mob1.instance()
		mobs.add_child(mob)
		mob.ahh=false
		mob.global_position=$Position2D4.global_position
	elif l<=6:
		var mob=mob2.instance()
		mobs.add_child(mob)
		mob.ahh=false
		mob.global_position=$Position2D4.global_position
	elif l<=8:
		var mob=mob3.instance()
		mobs.add_child(mob)
		mob.ahh=false
		mob.global_position=$Position2D4.global_position
	elif l<=9:
		var mob=mob4.instance()
		mobs.add_child(mob)
		mob.ahh=false
		mob.global_position=$Position2D4.global_position
	var m=rand_range(1,10)
	if m<=3:
		var mob=mob1.instance()
		mobs.add_child(mob)
		mob.ahh=false
		mob.global_position=$Position2D5.global_position
	elif m<=6:
		var mob=mob2.instance()
		mobs.add_child(mob)
		mob.ahh=false
		mob.global_position=$Position2D5.global_position
	elif m<=8:
		var mob=mob3.instance()
		mobs.add_child(mob)
		mob.ahh=false
		mob.global_position=$Position2D5.global_position
	elif m<=9:
		var mob=mob4.instance()
		mobs.add_child(mob)
		mob.ahh=false
		mob.global_position=$Position2D5.global_position




func _on_Area2D_body_entered(body):
	$StaticBody2D/CollisionShape2D.set_deferred("disabled",false)
	$Boss.alive=true
	$Timer.start()
	pass # Replace with function body.



func _on_Boss_game_over():
	var dialogic=Dialogic.start("结束")
	dialogic.connect('dialogic_signal',get_node("/root/world"),"dialogic_end")
	add_child(dialogic)
	get_tree().paused=true
	pass # Replace with function body.


func _on_mobs_rebirth_area_body_entered(body):
	$StaticBody2D/CollisionShape2D.set_deferred("disabled",true)
	$Timer.stop()
	for ele in mobs.get_children():
		ele.queue_free()
	pass # Replace with function body.
