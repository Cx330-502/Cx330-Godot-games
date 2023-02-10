extends CanvasLayer

signal start_game
signal restart_game
var button_purpose:String


func _on_statrbutton_pressed():
	if button_purpose=="start":
		button_purpose="restart"
		$statrbutton.text="我不信邪\n！再来！"
		$statrbutton.margin_right=$statrbutton.rect_size.x/2
		$statrbutton.margin_left=0-$statrbutton.rect_size.x/2
		$statrbutton.hide()
		$statrbutton.disabled=true
		get_parent().gaming=true
		emit_signal("start_game")
	elif button_purpose=="restart":
		button_purpose="start"
		$statrbutton.text="!开始!"
		$statrbutton.margin_right=$statrbutton.rect_size.x/2
		$statrbutton.margin_left=0-$statrbutton.rect_size.x/2
		emit_signal("restart_game")

func update_score(score):
	$score_label.text=str(score)

func show_message(message):
	$message_label.show()
	$message_label.text=message
	$message_label.margin_left=0-$message_label.rect_size.x/2
	$message_label.margin_right=$message_label.rect_size.x/2

func _input(event):
	if !get_parent().gaming:
		if Input.is_action_pressed("ui_select"):
			_on_statrbutton_pressed()

