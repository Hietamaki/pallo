extends KinematicBody2D

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

onready var lauta_koko = get_node("kuva").get_texture().get_size()

func _input(ev):
	
	# Mouse in viewport coordinates
	
	if (ev.type==InputEvent.MOUSE_BUTTON):
		print("Mouse Click/Unclick at: ",ev.pos)
	elif (ev.type==InputEvent.MOUSE_MOTION):
		set_pos(Vector2(ev.pos.x, get_pos().y))
		#print("Mouse Motion at: ",ev.pos)
	elif (ev.type==InputEvent.KEY):
		if (Input.is_action_pressed("ui_cancel")):
			get_tree().quit()


func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)
	set_process_input(true)


func VenytaLautaa(pituus):
	
	if(get_scale().x * pituus < 4 and get_scale().x * pituus > 0.5):
		scale(Vector2(pituus, 1))
		lauta_koko.x = get_node("kuva").get_texture().get_size().x * get_scale().x
	print ("Laudan venytys: "+(str(get_scale().x)))
