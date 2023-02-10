extends Node

var score:int
export (PackedScene) var Mob
signal game_over
var gaming:bool
var settings_on:bool
var player_speed_level:int
var mob_speed_level:int
var ability:int
var best_score:int
var difficulty:int
var score_level:int
func _ready():
	$HUD.button_purpose="start"
	settings("hide")
	settings_on=false
	gaming=false
	$music_back.play()
	player_speed_level=3
	mob_speed_level=3
	ability=0
	best_score=0;
	$player_speed.text="角色速度："+str(player_speed_level)
	$mob_speed.text="怪物速度："+str(mob_speed_level)
	$best_score.text="最佳成绩："+str(best_score)
	difficulty=1;
	$mob_birth_path.curve.add_point(Vector2(0,0),Vector2( 0, 0 ),Vector2( 0, 0 ))
	$mob_birth_path.curve.add_point(Vector2(get_viewport().size.x,0),Vector2( 0, 0 ),Vector2( 0, 0 ))
	$mob_birth_path.curve.add_point(Vector2(get_viewport().size.x,get_viewport().size.y),Vector2( 0, 0 ),Vector2( 0, 0 ))
	$mob_birth_path.curve.add_point(Vector2(0,get_viewport().size.y),Vector2( 0, 0 ),Vector2( 0, 0 ))
	$mob_birth_path.curve.add_point(Vector2(0,0),Vector2( 0, 0 ),Vector2( 0, 0 ))
	$HUD/pictures.hide()
	$Startposition.position=Vector2(get_viewport().size.x/2,get_viewport().size.y/2+150)
	$player.position=$Startposition.position
	$player.show()

func _on_StartTimer_timeout():
	$MobTimer.start()
	$ScoreTimer.start()
	$HUD/message_label.hide()
	$player.set_deferred("monitoring",true)
	score_level=0


func _on_MobTimer_timeout():
	$mob_birth_path/mob_birth_place.set_offset(randi())
	$mob_birth_path.curve.clear_points()
	$mob_birth_path.curve.add_point(Vector2(0,0),Vector2( 0, 0 ),Vector2( 0, 0 ))
	$mob_birth_path.curve.add_point(Vector2(get_viewport().size.x,0),Vector2( 0, 0 ),Vector2( 0, 0 ))
	$mob_birth_path.curve.add_point(Vector2(get_viewport().size.x,get_viewport().size.y),Vector2( 0, 0 ),Vector2( 0, 0 ))
	$mob_birth_path.curve.add_point(Vector2(0,get_viewport().size.y),Vector2( 0, 0 ),Vector2( 0, 0 ))
	$mob_birth_path.curve.add_point(Vector2(0,0),Vector2( 0, 0 ),Vector2( 0, 0 ))
	var mob=Mob.instance()
	add_child(mob)
	mob.speed_min=str(50*(mob_speed_level-1))
	mob.speed_min=str(50*mob_speed_level)
	mob.position=$mob_birth_path/mob_birth_place.position
	var direction=$mob_birth_path/mob_birth_place.rotation+PI/2
	direction+=rand_range(-PI/4,PI/4)
	mob.rotation=direction
	mob.set_linear_velocity(Vector2(rand_range(mob.speed_min,mob.speed_max),0).rotated(direction))

func _on_ScoreTimer_timeout():
	score+=1
	if score>=20 && score_level==0:
		score_level+=1
		ability+=1
	if score>=40 && score_level==1:
		score_level+=1
		ability+=2
	$Settings/Settings/ability/abilities.text=str(ability)
	$HUD.update_score(score)
	$HUD/message_label.hide()

func _on_player_hit():
	emit_signal("game_over")
	if score>best_score:
		best_score=score
	$best_score.text="最佳成绩："+str(best_score)
	$MobTimer.stop()
	$ScoreTimer.stop()
	$HUD/pictures/pictures.position=Vector2(get_viewport().size.x/2,get_viewport().size.y/2-30)
	if score<20:
		$HUD.show_message("小菜鸡死了吧")
		$HUD/pictures/pictures.animation="0"
		$HUD/pictures.show()
	elif score<40:
		$HUD.show_message("诶呦，不错呦")
		$HUD/pictures/pictures.animation="20"
		$HUD/pictures.show()
	else:
		$HUD.show_message("大佬，大佬")
		$HUD/pictures/pictures.animation="40"
		$HUD/pictures.show()
	score=0
	$player/Particles2D.emitting=false
	$music_dead.play()
	$HUD/statrbutton.show()
	$HUD/statrbutton.disabled=false
	gaming=false


func _on_HUD_start_game():
	$StartTimer.start()
	$HUD.show_message("准备好了吗？")
	$Settings2.funhide()
	settings("hide")
	settings_on=false
	$player/Particles2D.emitting=true
	$player.start_game($Startposition.position)

func _on_HUD_restart_game():
	$HUD.show_message("准备好躲藏！")
	$HUD.update_score(score)
	$HUD/pictures.hide()
	$Startposition.position=Vector2(get_viewport().size.x/2,get_viewport().size.y/2+150)
	$player.position=$Startposition.position
	$player.show()



func _on_Button_pressed():
	if settings_on:
		settings("hide")
		settings_on=false
	else:
		settings("show")
		settings_on=true

func settings(state):
	if state=="show":
		$Settings/Settings.show()
		$Settings/Settings/player/down.disabled=false
		$Settings/Settings/player/up.disabled=false
		$Settings/Settings/mob/down.disabled=false
		$Settings/Settings/mob/up.disabled=false
	elif state=="hide":
		$Settings/Settings.hide()
		$Settings/Settings/player/down.disabled=true
		$Settings/Settings/player/up.disabled=true
		$Settings/Settings/mob/down.disabled=true
		$Settings/Settings/mob/up.disabled=true



func _on_Settings_mob_speedlevel_down():
	if mob_speed_level>3:
		ability+=1
		mob_speed_level-=1
	elif mob_speed_level>0 && ability>0:
		ability-=1
		mob_speed_level-=1
	$player_speed.text="角色速度："+str(player_speed_level)
	$mob_speed.text="怪物速度："+str(mob_speed_level)
	$Settings/Settings/ability/abilities.text=str(ability)
	$Settings/Settings/mob/speed_level.text=str(mob_speed_level)
	$Settings/Settings/player/speed_level.text=str(player_speed_level)

func _on_Settings_mob_speedlevel_up():
	if mob_speed_level<3:
		ability+=1
		mob_speed_level+=1
	elif ability>0:
		ability-=1
		mob_speed_level+=1
	$player_speed.text="角色速度："+str(player_speed_level)
	$mob_speed.text="怪物速度："+str(mob_speed_level)
	$Settings/Settings/ability/abilities.text=str(ability)
	$Settings/Settings/mob/speed_level.text=str(mob_speed_level)
	$Settings/Settings/player/speed_level.text=str(player_speed_level)

func _on_Settings_player_speedlevel_down():
	if player_speed_level>3:
		ability+=1
		player_speed_level-=1
	elif player_speed_level>0 && ability>0:
		ability-=1
		player_speed_level-=1
	$player_speed.text="角色速度："+str(player_speed_level)
	$mob_speed.text="怪物速度："+str(mob_speed_level)
	$Settings/Settings/ability/abilities.text=str(ability)
	$Settings/Settings/mob/speed_level.text=str(mob_speed_level)
	$Settings/Settings/player/speed_level.text=str(player_speed_level)
	$player.speed=str(50*player_speed_level)

func _on_Settings_player_speedlevel_up():
	if player_speed_level<3:
		ability+=1
		player_speed_level+=1
	elif ability>0:
		ability-=1
		player_speed_level+=1
	$player_speed.text="角色速度："+str(player_speed_level)
	$mob_speed.text="怪物速度："+str(mob_speed_level)
	$Settings/Settings/ability/abilities.text=str(ability)
	$Settings/Settings/mob/speed_level.text=str(mob_speed_level)
	$Settings/Settings/player/speed_level.text=str(player_speed_level)
	$player.speed=str(50*player_speed_level)


func _on_Settings_difficult1():
	difficulty=1
	$MobTimer.wait_time=0.45
func _on_Settings_difficult2():
	difficulty=2
	$MobTimer.wait_time=0.3
func _on_Settings_difficult3():
	difficulty=3
	$MobTimer.wait_time=0.1
