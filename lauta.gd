extends KinematicBody2D

func _input(ev):
	
	if (ev.type==InputEvent.MOUSE_BUTTON):
		print("Mouse Click/Unclick at: ",ev.pos)
	elif (ev.type==InputEvent.MOUSE_MOTION):
		set_pos(Vector2(ev.pos.x, get_pos().y))
	
	#ei varsinaisesti kuulu tänne, mutta menköön
	elif (ev.type==InputEvent.KEY):
		if (Input.is_action_pressed("ui_cancel")):
			get_tree().quit()

func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)
	set_process_input(true)

func Venyta(pituus):
	
	if(get_scale().x * pituus < 4 and get_scale().x * pituus > 0.5):
		scale(Vector2(pituus, 1))
	#print ("Laudan venytys: "+(str(get_scale().x)))
