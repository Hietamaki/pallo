extends KinematicBody2D

const PALLON_NOPEUS = 300
const PELIALUE_X = 1010
const PELIALUE_Y = 600

onready var lauta = get_node("../lauta")
onready var soundit = get_node("../soundit")

var pallo_suunta = Vector2(2, 4)
var supervoima = false
var aloitus = true
var aika_viimeksi = 0

func _ready():
	set_fixed_process(true)

func _fixed_process(delta):
	
	if (is_colliding()):
		
		var tormaaja = get_collider()
		
		if (tormaaja == lauta):
			Pongauta()
		else:
			#oletetaan tiileksi, koska muuta ei ole
			soundit.play("blomp")

			var normaali = get_collision_normal()
			
			if (!supervoima):
				#olettaa kaikkien tasojen olevan vaaka- tai kohtisuoria
				if (abs(normaali.x) < abs(normaali.y)):
					pallo_suunta = Vector2(pallo_suunta.x, -pallo_suunta.y)
				else:
					pallo_suunta = Vector2(-pallo_suunta.x, pallo_suunta.y)
			
			if (tormaaja.Osuma()):
				tormaaja.free()
				if (get_tree().get_nodes_in_group("tiilet").size() < 2):
					get_node("/root/peli").GeneroiKentta()

		
	if (get_pos().y < 10):
		pallo_suunta = Vector2(pallo_suunta.x, 4)
	if (get_pos().x < 10):
		pallo_suunta = Vector2(2, pallo_suunta.y)
	if (get_pos().x > PELIALUE_X):
		pallo_suunta = Vector2(-2, pallo_suunta.y)
	if (get_pos().y > PELIALUE_Y):
		aloitus = true
		lauta.Venyta(0.9)
		Supermode(false)
	
	if (!aloitus):
		pallo_suunta = pallo_suunta.normalized() * PALLON_NOPEUS * delta
		move(pallo_suunta)
	else:
		var sijainti = lauta.get_pos()
		sijainti.y -= 25
		set_pos(sijainti)
	
	if (OS.get_ticks_msec() > aika_viimeksi + PALLO_KOSKEMATTOMANA_MSEC):
		set_shape_as_trigger(0, false)

const PALLO_KOSKEMATTOMANA_MSEC = 300

func Pongauta():
	
	if (OS.get_ticks_msec() > aika_viimeksi + PALLO_KOSKEMATTOMANA_MSEC):
		soundit.play("blomp2")
		
		var leveys = lauta.get_scale().x;
		var osuu_kohtaan = (get_pos().x - lauta.get_pos().x) / leveys / 6
		pallo_suunta = Vector2(osuu_kohtaan, -pallo_suunta.y)
		aika_viimeksi = OS.get_ticks_msec()
		set_shape_as_trigger(0, true)

func Supermode(super_paalle = true):
	if (super_paalle == false):
		supervoima = false
		get_node("superpallo").hide()
		get_node("kuva").show()
	else:
		get_node("kuva").hide()
		get_node("superpallo").show()
		supervoima = true