extends CharacterBody3D


const JUMP_VELOCITY = 4.5

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")
@onready var Head = $character_head
@export var sensitivity = 0.2
@export var sprint = 10
@export var SPEED = 5.0

func _ready():
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	
func _process(delta):
	$character_head/character_head_eyes/GUI/FPS_Counter.text = "FPS: " + str(1/delta)

func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y -= gravity * delta

	# Handle Jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var input_dir = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	var direction = (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	if direction:
		if Input.is_key_pressed(KEY_SHIFT):
			velocity.x = direction.x * (SPEED + sprint)
			velocity.z = direction.z * (SPEED + sprint)
		else:
			velocity.x = direction.x * SPEED
			velocity.z = direction.z * SPEED

	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.z = move_toward(velocity.z, 0, SPEED)

	move_and_slide()
	
func _input(event):
#Needs mouse controls to be finalised
	if event is InputEventMouseMotion:
		rotate_y(deg_to_rad(-event.relative.x*sensitivity))
		Head.rotate_x(deg_to_rad(-event.relative.y*sensitivity))
		Head.rotation.x = clamp(Head.rotation.x, deg_to_rad(-90), deg_to_rad(90))
