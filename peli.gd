
extends Node2D

onready var tiili_malli = get_node("tiili")
#onready var tiili_koko = tiili_malli.get_texture().get_size()

var tiilet = Array()
var level_number = 1
onready var soundit = get_node("soundit")

func _ready():
	set_fixed_process(true)
	GeneroiKentta(1)

const X_PALIKKA = 50
const Y_PALIKKA = 20


func GeneroiKentta(level_name = false):
	
	if (level_name == false):
		level_number += 1
		level_name = level_number
	
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
			get_node("/root/peli").add_child(tiili)
			#print(tiili.get_texture().get_name() + " " + str(tiili.get_pos().y) + " "+str(tiili.is_hidden()) + str(tiili.get_parent()))
			#tiilet.append(tiili)
			tiili.add_to_group("tiilet")
		
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