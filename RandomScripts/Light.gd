extends MeshInstance3D

@export var speed = 2

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	$"..".progress += speed * delta
