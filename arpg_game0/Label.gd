extends Label
onready var timer=$Timer

func show_label(value,time):
	show()
	text=value
	timer.start(time)

func _on_Timer_timeout():
	hide()
	pass # Replace with function body.
