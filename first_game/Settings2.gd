extends CanvasLayer
var iscracked:bool
var isshow:bool
var peoplename=["ACE","白哥哥","樊哥哥","翰宝","康少","老社长","宋学长","王雅晨","小涛涛","小霄霄","院士","真姐姐"]
var peoplenum:int

func _ready():
	iscracked=false
	isshow=false
	funhide()
	$Settings2/cracked/OptionButton.add_item($Settings2/Node2D/Label0.text,0)
	$Settings2/cracked/OptionButton.add_item($Settings2/Node2D/Label1.text,1)
	$Settings2/cracked/OptionButton.add_item($Settings2/Node2D/Label2.text,2)
	$Settings2/cracked/OptionButton.add_item($Settings2/Node2D/Label3.text,3)
	$Settings2/cracked/OptionButton.add_item($Settings2/Node2D/Label4.text,4)
	$Settings2/cracked/OptionButton.add_item($Settings2/Node2D/Label5.text,5)
	$Settings2/cracked/OptionButton.add_item($Settings2/Node2D/Label6.text,6)
	$Settings2/cracked/OptionButton.add_item($Settings2/Node2D/Label7.text,7)
	$Settings2/cracked/OptionButton.add_item($Settings2/Node2D/Label8.text,8)
	$Settings2/cracked/OptionButton.add_item($Settings2/Node2D/Label9.text,9)
	$Settings2/cracked/OptionButton.add_item($Settings2/Node2D/Label10.text,10)
	$Settings2/cracked/OptionButton.add_item($Settings2/Node2D/Label11.text,11)
	$Settings2/cracked/OptionButton.select(8)
	peoplenum=8
	$Settings2/TextureRect.texture=load("res://name_"+str(peoplenum)+".png")
	get_node("/root/main/player/AnimatedSprite").animation=str(peoplenum)
	get_node("/root/main/player/Particles2D").texture=$Settings2/TextureRect.texture


func funshow():
	$Settings2.show()
	if iscracked==false:
		$Settings2/uncracked.show()
		$Settings2/cracked.hide()
		$Settings2/Label.text="输入激活码，开启新世界"
		$Settings2/Label.show()
		$Settings2/uncracked/sureButton.disabled=false
		$Settings2/cracked/OptionButton.disabled=true
	else:
		$Settings2/uncracked.hide()
		$Settings2/cracked.show()
		$Settings2/Label.text="新世界已开启"
		$Settings2/Label.show()
		$Settings2/uncracked/sureButton.disabled=true
		$Settings2/cracked/OptionButton.disabled=false

func funhide():
	$Settings2.hide()
	$Settings2/uncracked/sureButton.disabled=true
	$Settings2/cracked/OptionButton.disabled=true

func _on_sureButton_pressed():
	if $Settings2/uncracked/code.text=="CT是个小胖几":
		iscracked=true
		funshow()
	else: $Settings2/uncracked/code.text="激活码错误"


func _on_Button2_pressed():
	if isshow==false:
		isshow=true
		funshow()
	else:
		isshow=false
		funhide()


func _on_OptionButton_item_selected(index):
	peoplenum=index
	$Settings2/TextureRect.texture=load("res://name_"+str(peoplenum)+".png")
	get_node("/root/main/player/AnimatedSprite").animation=str(peoplenum)
	get_node("/root/main/player/Particles2D").texture=$Settings2/TextureRect.texture
	
