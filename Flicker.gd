extends SpotLight3D

var audio_spectrum
var volume

# Called when the node enters the scene tree for the first time.
func _ready():
	pass
#	audio_spectrum = AudioServer.get_bus_channels(1)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
#	volume = audio_spectrum.get_magnitude_for_frequency_range(0, 10000).length()
#	self.light_energy = volume
