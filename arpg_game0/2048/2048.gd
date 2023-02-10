extends Node2D
onready var equip1=get_node("%shield1_2")
onready var equip2=get_node("%shield2_1")
onready var equip3=get_node("%shoes1_2")
onready var equip4=get_node("%shoes2_1")
onready var equip5=get_node("%sword2_1")
onready var equip6=get_node("%sword3_1")

# Declare member variables here. Examples:
var randinum
onready var tilemap2048=$Node2D/"2048TileMap"
onready var timer=$Timer
onready var label=$Label
onready var label2=$Label2
var player_in:bool=false
var point=[1,1,1,1,1]
var score:int=0
var highest_score:int=0
# Called when the node enters the scene tree for the first time.
func _ready():
	equip1.disable()
	equip2.disable()
	equip3.disable()
	equip4.disable()
	equip5.disable()
	equip6.disable()
	generate_block()
	update_score()


func update_score():
	if score>highest_score:
		highest_score=score
	label.text="分数："+str(score)
	label2.text="历史最高："+str(highest_score)
	if score>200 and point[0]==1:
		equip1.able()
		point[0]=0
	if score>400 and point[1]==1:
		equip3.able()
		point[1]=0
	if score>600 and point[2]==1:
		equip5.able()
		point[2]=0
	if score>800 and point[3]==1:
		equip4.able()
		point[3]=0
	if score>1000 and point[4]==1:
		equip2.able()
		equip6.able()
		point[4]=0



func _input(event):
	if player_in:
		if event.is_action_pressed("attack_up"):
			move_up()
			timer.start()
		elif event.is_action_pressed("attack_right"):
			move_right()
			timer.start()
		elif event.is_action_pressed("attack_down"):
			move_down()
			timer.start()
		elif event.is_action_pressed("attack_left"):
			move_left()
			timer.start()
		update_score()


func move_up():
	var pos
	var pos2:PoolVector2Array
	var pos3:Array
	var flag2:=1
	var pos0:Vector2
	var pos00:Vector2
	var id0
	var flag:int=1
	pos3.clear()
	pos2=PoolVector2Array(pos3)
	while flag!=0:
		flag=0
		pos=tilemap2048.get_used_cells ()
		for ele in pos:
			id0=tilemap2048.get_cellv(ele)
			if ele.y>0 and id0!=14:
				pos0=ele-Vector2.DOWN
				pos00=pos0-Vector2.DOWN
				if tilemap2048.get_cellv(pos0)==14:
					tilemap2048.set_cellv(pos0,id0)
					tilemap2048.set_cellv(ele,14)
					flag=1
				elif id0==tilemap2048.get_cellv(pos0) and id0!=tilemap2048.get_cellv(pos00):
					flag2=0
					for ele2 in pos2:
						if pos0==ele2 or ele==ele2:
							flag2=1
							break
					if flag2==0:
						tilemap2048.set_cellv(pos0,id0+1)
						tilemap2048.set_cellv(ele,14)
						score+=pow(2,id0)
						pos2.append(pos0)
						flag=1
	pass


func move_right():
	var pos
	var pos00
	var pos2:PoolVector2Array
	var pos3:Array
	var flag2=1
	var pos0:Vector2
	var id0
	var flag:int=1
	pos3.clear()
	pos2=PoolVector2Array(pos3)
	while flag!=0:
		flag=0
		pos=tilemap2048.get_used_cells ()
		for ele in pos:
			id0=tilemap2048.get_cellv(ele)
			if ele.x<3 and id0!=14:
				pos0=ele+Vector2.RIGHT
				pos00=pos0+Vector2.RIGHT
				if tilemap2048.get_cellv(pos0)==14:
					tilemap2048.set_cellv(pos0,id0)
					tilemap2048.set_cellv(ele,14)
					flag=1
				elif id0==tilemap2048.get_cellv(pos0) and id0!=tilemap2048.get_cellv(pos00):
					flag2=0
					for ele2 in pos2:
						if pos0==ele2 or ele==ele2:
							flag2=1
							break
					if flag2==0:
						tilemap2048.set_cellv(pos0,id0+1)
						tilemap2048.set_cellv(ele,14)
						score+=pow(2,id0)
						pos2.append(pos0)
						flag=1
	pass


func move_left():
	var pos
	var pos00
	var pos2:PoolVector2Array
	var pos3:Array
	var flag2=1
	var pos0:Vector2
	var id0
	var flag:int=1
	pos3.clear()
	pos2=PoolVector2Array(pos3)
	while flag!=0:
		flag=0
		pos=tilemap2048.get_used_cells ()
		for ele in pos:
			id0=tilemap2048.get_cellv(ele)
			if ele.x>0 and id0!=14:
				pos0=ele-Vector2.RIGHT
				pos00=pos0-Vector2.RIGHT
				if tilemap2048.get_cellv(pos0)==14:
					tilemap2048.set_cellv(pos0,id0)
					tilemap2048.set_cellv(ele,14)
					flag=1
				elif id0==tilemap2048.get_cellv(pos0) and id0!=tilemap2048.get_cellv(pos00):
					flag2=0
					for ele2 in pos2:
						if pos0==ele2 or ele==ele2:
							flag2=1
							break
					if flag2==0:
						tilemap2048.set_cellv(pos0,id0+1)
						tilemap2048.set_cellv(ele,14)
						score+=pow(2,id0)
						pos2.append(pos0)
						flag=1
	pass


func move_down():
	var pos
	var pos00
	var pos2:PoolVector2Array
	var pos3:Array
	var flag2=1
	var pos0:Vector2
	var id0
	var flag:int=1
	pos3.clear()
	pos2=PoolVector2Array(pos3)
	while flag!=0:
		flag=0
		pos=tilemap2048.get_used_cells ()
		for ele in pos:
			id0=tilemap2048.get_cellv(ele)
			if ele.y<3 and id0!=14:
				pos0=ele+Vector2.DOWN
				pos00=pos0+Vector2.DOWN
				if tilemap2048.get_cellv(pos0)==14:
					tilemap2048.set_cellv(pos0,id0)
					tilemap2048.set_cellv(ele,14)
					flag=1
				elif id0==tilemap2048.get_cellv(pos0) and id0!=tilemap2048.get_cellv(pos00):
					flag2=0
					for ele2 in pos2:
						if pos0==ele2 or ele==ele2:
							flag2=1
							break
					if flag2==0:
						tilemap2048.set_cellv(pos0,id0+1)
						tilemap2048.set_cellv(ele,14)
						score+=pow(2,id0)
						pos2.append(pos0)
						flag=1
	pass


func generate_block():
	var pos
	pos=tilemap2048.get_used_cells_by_id(14)
	if pos.size()>0:
		pos.shuffle()
		randinum=rand_range(0,9)
		if randinum<9:
			randinum=1
		else:
			randinum=2
#	print(pos,randinum)
		tilemap2048.set_cellv(pos[0],randinum)
	else:
		pos=tilemap2048.get_used_cells ()
		score=0
		for ele in pos:
			tilemap2048.set_cellv(ele,14)


func _on_Timer_timeout():
	generate_block()


func _on_play_area_body_entered(body):
	if body==get_node("/root/world/YSort/player"):
		player_in=true


func _on_play_area_body_exited(body):
	if body==get_node("/root/world/YSort/player"):
		player_in=false

