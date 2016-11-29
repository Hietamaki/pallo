extends KinematicBody2D

func _ready():
	add_to_group("voima")
	set_fixed_process(true)

func _fixed_process(delta):
	
	move(Vector2(0, 2))
	
	if (get_pos().y > get_node("../pallo").PELIALUE_Y):
		queue_free()
		
		#if (get_name().substr(1,6) == "super1"):
		#	lauta.VenytaLautaa(1.1)
		#elif (supervoima == false):
		#	supervoima = true
			#pallo =get_node("superpallo")
			#pallo.set_pos(get_node("pallo").get_pos())
			#get_node("pallo").hide()

func LuoSuper(kohta):
	var super = get_node("../super"+str(randi() % 2 + 1)).duplicate()
	super.set_pos(kohta)
	get_node("..").add_child(super)
	#tippuu.append(super)