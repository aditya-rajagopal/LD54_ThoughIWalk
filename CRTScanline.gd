extends ColorRect

@export var max_delay: float = 10.0

var next_time: float = 0.0 
var change_param: bool = true
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func TimeInSec():
	return Time.get_ticks_msec()/1000.0

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if change_param:
		var delay = randf_range(1.0, max_delay)
		material.set("shader_param/_delay", delay)
		next_time = TimeInSec() + delay
		change_param = false
	
	if next_time - TimeInSec() <= 0.0:
		change_param = true
	pass
