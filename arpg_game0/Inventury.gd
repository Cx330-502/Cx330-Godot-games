extends Resource

class_name Inventury

export(Array,Resource) var items

signal items_changed
var drag_data
func set_item(item_index,item):
	var current_item=items[item_index]
	items[item_index] = item
	emit_signal("items_changed",[item_index])
	return current_item


func remove_item(item_index):
	var current_item=items[item_index]
	items[item_index]=null
	emit_signal("items_changed",[item_index])
	return current_item


func swap_items(item_index,target_item_index):
	var target_item=items[target_item_index]
	var item=items[item_index]
	items[target_item_index]=item
	items[item_index]=target_item
	emit_signal("items_changed",[item_index,target_item_index])

func creat_item(item):
	var item_index=items.find(null)
	var current_item=items[item_index] 
	items[item_index]=item
	emit_signal("items_changed",[item_index])
	return current_item
