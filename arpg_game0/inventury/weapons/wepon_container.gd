extends GridContainer

var weapon_inventury=preload("res://inventury/weapons/Weapon_Inventury.tres")
signal equipment_changed

func _ready():
	weapon_inventury.connect("items_changed",self,"on_item_changed")
	for item_index in weapon_inventury.items.size():
		update_slot(item_index)


func update_slot(item_index):
	var slot=get_child(item_index)
	var item=weapon_inventury.items[item_index]
	slot.update_item(item)
	emit_signal("equipment_changed")

func on_item_changed(indexes):
	for item_index in indexes:
		update_slot(item_index)

func _unhandled_input(event):
	if event is InputEventMouseButton:
		if event.button_index == BUTTON_LEFT and not event.pressed:
			if weapon_inventury.drag_data is Dictionary:
				weapon_inventury.set_item(weapon_inventury.drag_data.item_index,weapon_inventury.drag_data.item)
