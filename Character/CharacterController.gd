extends CharacterBody3D



var sprint = 0
# Get the gravity from the project settings to be synced with RigidBody nodes.
@onready var Head = $character_head
@export var sensitivity = 0.2
@export var sprint_speed = 5
@export var SPEED = 5.0
@export var vel_smooth = 0.3
@export var gravity = 15
@export var jump = 7

func _ready():
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	
func _process(delta):
	$character_head/character_head_eyes/GUI/FPS_Counter.text = "FPS: " + str(round(1/delta))

func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y -= gravity * delta

	# Handle Jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = jump

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var input_dir = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	var direction = (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	sprint = 0
	if Input.is_key_pressed(KEY_SHIFT):
		sprint = sprint_speed
	velocity.x = lerp(velocity.x, direction.x * (SPEED + sprint), vel_smooth)
	velocity.z = lerp(velocity.z, direction.z * (SPEED + sprint), vel_smooth)

	move_and_slide()
	
	
func _input(event):
#Needs mouse controls to be finalised
	if event is InputEventMouseMotion:
		rotate_y(deg_to_rad(-event.relative.x*sensitivity))
		Head.rotate_x(deg_to_rad(-event.relative.y*sensitivity))
		Head.rotation.x = clamp(Head.rotation.x, deg_to_rad(-90), deg_to_rad(90))


