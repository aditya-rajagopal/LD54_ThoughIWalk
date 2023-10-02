extends PointLight2D

@export var distortion: float = 0.05
@export var pulse_rate: float = 1
@export var pulse_amplitude: float = 0.005
var base_texture_scale: float
var amplitude: float
var base_position: Vector2
# Called when the node enters the scene tree for the first time.
func _ready():
	base_texture_scale = texture_scale
	base_position = position
	amplitude = pulse_amplitude * base_texture_scale
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var new_position: Vector2
	new_position.x = (randf() * 2.0 - 1.0) * distortion
	new_position.y = (randf() * 2.0 - 1.0) * distortion
	position = lerp(position, base_position+new_position, 0.05)
	
	var current_time = Time.get_ticks_msec()/1000.0
	texture_scale = sin(current_time * 2 * PI * pulse_rate) * amplitude + base_texture_scale
	pass
