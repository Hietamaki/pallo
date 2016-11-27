
extends Node2D

const PALLON_NOPEUS = 4
const PELIALUE_X = 1010
const PELIALUE_Y = 600
var pallo_suunta = Vector2(2, PALLON_NOPEUS)
var tiilet = Array()
var tippuu = Array()
var supervoima = false
onready var pallo = get_node("pallo")
onready var lauta = get_node("lauta")
onready var tiili_malli = get_node("tiili")
onready var lauta_koko = lauta.get_texture().get_size()
onready var tiili_koko = tiili_malli.get_texture().get_size()
onready var soundit = get_node("soundit")
var level_number = 1

func _input(ev):
	
	# Mouse in viewport coordinates
	
	if (ev.type==InputEvent.MOUSE_BUTTON):
		print("Mouse Click/Unclick at: ",ev.pos)
	elif (ev.type==InputEvent.MOUSE_MOTION):
		lauta.set_pos(Vector2(ev.pos.x, lauta.get_pos().y))
		#print("Mouse Motion at: ",ev.pos)
	elif (ev.type==InputEvent.KEY):
		if (Input.is_action_pressed("ui_cancel")):
			get_tree().quit()


func _fixed_process(delta):
	
	for tiili in tiilet:
		
		var tiili_alue = Rect2(tiili.get_pos() - tiili_koko / 2, tiili_koko)
		
		if (tiili_alue.has_point(pallo.get_pos())):
			tiilet.erase(tiili)
			tiili.queue_free()
			if (!supervoima):
				pallo_suunta = Vector2(pallo_suunta.x, -pallo_suunta.y)
			soundit.play("blomp")
			print (tiilet.size())
			if (!tiilet.size()):
				level_number += 1
				GeneroiKentta(level_number)
				print("LÄPI"+str(level_number))
			elif (randi() % 2):
				LuoSuper(tiili_alue.pos+tiili_koko/2)
	
	var lauta_alue = Rect2(lauta.get_pos() - lauta_koko / 2, lauta_koko)
	
	if (lauta_alue.has_point(pallo.get_pos())):
		var osuu_kohtaan = (pallo.get_pos().x - lauta.get_pos().x) / 10
		pallo_suunta = Vector2(osuu_kohtaan, -PALLON_NOPEUS)
		soundit.play("blomp2")
		#VenytaLautaa(1.5)
		print ("OK"+str(pallo.get_pos().y))
	if (pallo.get_pos().y < 10):
		pallo_suunta = Vector2(pallo_suunta.x, PALLON_NOPEUS)
	if (pallo.get_pos().x < 10):
		pallo_suunta = Vector2(2, pallo_suunta.y)
	if (pallo.get_pos().x > PELIALUE_X):
		pallo_suunta = Vector2(-2, pallo_suunta.y)
	if (pallo.get_pos().y > PELIALUE_Y):
		pallo.set_pos(Vector2(PELIALUE_Y -100, 300))
		VenytaLautaa(0.9)
	
	var pallo_sijainti = pallo.get_pos()
	pallo.set_pos(pallo_sijainti + pallo_suunta)
	
	for i in tippuu:
		i.move_local_y(2)
		if (i.get_pos().y > PELIALUE_Y):
			tippuu.erase(i)
			i.queue_free()
		if (lauta_alue.has_point(i.get_pos())):
			tippuu.erase(i)
			i.queue_free()
			
			if (i.get_name().substr(1,6) == "super1"):
				VenytaLautaa(1.1)
			elif (supervoima == false):
				supervoima = true
				pallo =get_node("superpallo")
				pallo.set_pos(get_node("pallo").get_pos())
				get_node("pallo").hide()
				

func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)
	set_process_input(true)
	set_fixed_process(true)
	GeneroiKentta(1)

const X_PALIKKA = 50
const Y_PALIKKA = 20

func GeneroiKentta(level_name):
	
	var kentta = LataaKenttaData(level_name)
	print (kentta)
	var rivi = 0
	var solu = 0
	#for i in range(10):
	for i in range(kentta.length()):
		var point = kentta.substr(i,1)
		
		if (point == "a"):
			var tiili = tiili_malli.duplicate()
			tiili.set_pos(Vector2(44 + solu * X_PALIKKA, Y_PALIKKA + rivi * Y_PALIKKA))
			#tiili.set_pos(Vector2(X_PALIKKA + randi() % 20 * X_PALIKKA, Y_PALIKKA + randi() % 20 * Y_PALIKKA))
			get_node(".").add_child(tiili)
			#print(tiili.get_texture().get_name() + " " + str(tiili.get_pos().y) + " "+str(tiili.is_hidden()) + str(tiili.get_parent()))
			tiilet.append(tiili)
		
		solu += 1
		
		if (point == "\n"):
			rivi += 1
			solu = 0
		
		
func LataaKenttaData(kentta):
	randomize()
	var file = File.new()
	file.open("res://levels/"+str(kentta), file.READ)
	var sisalto = file.get_as_text()
	file.close()
	print ("super"+str((randi() % 5) % 2))
	return sisalto

func VenytaLautaa(pituus):
	
	if(lauta.get_scale().x * pituus < 4 and lauta.get_scale().x * pituus > 0.5):
		lauta.scale(Vector2(pituus, 1))
		lauta_koko.x = lauta.get_texture().get_size().x * lauta.get_scale().x
	print ("Laudan venytys: "+(str(lauta.get_scale().x)))

func LuoSuper(kohta):
	var super = get_node("super"+str(randi() % 2 + 1)).duplicate()
	super.set_pos(kohta)
	get_node(".").add_child(super)
	tippuu.append(super)