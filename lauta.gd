extends KinematicBody2D

func _ready():
	set_fixed_process(true)
	set_process_input(true)
	Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)

func _input(ev):
	
	if (ev.type==InputEvent.MOUSE_BUTTON):
		get_parent().get_node("pallo").aloitus = false
		print("Mouse Click/Unclick at: ",ev.pos)
	elif (ev.type==InputEvent.MOUSE_MOTION):
		move_to(Vector2(ev.pos.x, 570))
	
	#ei varsinaisesti kuulu tänne, mutta menköön
	elif (ev.type==InputEvent.KEY):
		if (Input.is_action_pressed("ui_cancel")):
			get_tree().quit()

func _fixed_process(delta):
	if (is_colliding()):
		if ("voima" in get_collider().get_groups()):
			get_collider().SuperEfekti()
		else:
			#pallo
			get_collider().Pongauta()
	
func Venyta(pituus):
	
	if(get_scale().x * pituus < 4 and get_scale().x * pituus > 0.5):
		scale(Vector2(pituus, 1))
	#print ("Laudan venytys: "+(str(get_scale().x)))
