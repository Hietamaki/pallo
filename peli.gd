extends Node2D

const X_PALIKKA = 50
const Y_PALIKKA = 20

onready var tiili_malli = get_node("tiili")
onready var soundit = get_node("soundit")

var level_number = 1

func _ready():
	randomize()
	set_fixed_process(true)
	GeneroiKentta(1)

func GeneroiKentta(level_name = false):
	
	if (level_name == false):
		level_number += 1
		level_name = level_number
	
	var kentta = LataaKenttaData(level_name)
	print (kentta)
	var rivi = 0
	var solu = 0
	
	for i in range(kentta.length()):
		var point = kentta.substr(i,1)
		
		if (point == "a"):
			var tiili = tiili_malli.duplicate()
			tiili.set_pos(Vector2(44 + solu * X_PALIKKA, Y_PALIKKA + rivi * Y_PALIKKA))
			#tiili.set_pos(Vector2(X_PALIKKA + randi() % 20 * X_PALIKKA, Y_PALIKKA + randi() % 20 * Y_PALIKKA))
			get_node("/root/peli").add_child(tiili)
			tiili.add_to_group("tiilet")
		
		solu += 1
		
		if (point == "\n"):
			rivi += 1
			solu = 0
		
func LataaKenttaData(kentta):
	
	var file = File.new()
	file.open("res://levels/"+str(kentta), file.READ)
	var sisalto = file.get_as_text()
	file.close()
	return sisalto