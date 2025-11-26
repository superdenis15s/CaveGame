extends CharacterBody2D

@export var BASE_SPEED: float = 300
@export var BASE_JUMP_VELOCITY: float = 300

@export var jumps: int = 1
var jumps_left: int = 0
var jump_timer: bool = false

var x_modifier = 1
var y_modifier = 1
var gravity = g.gravity

func _ready() -> void:
	pass

func _physics_process(_delta: float) -> void:
	###################
	# PLAYER CONTROLS #
	###################
	
	velocity.x = 0
	
	# Gravity
	# Apply on floor or before terminal velocity is reached
	if !is_on_floor() or velocity.y < 55:
		velocity.y += gravity
	
	# Left
	if Input.is_action_pressed("a"):
		velocity.x = -BASE_SPEED*x_modifier
	# Right
	if Input.is_action_pressed("d"):
		velocity.x = BASE_SPEED*x_modifier
	if Input.is_action_pressed("a") and Input.is_action_pressed("d"):
		velocity.x = 0
	
	# Jump Handling
	if is_on_floor():
		jumps_left = jumps
	# Jump if key pressed, has jumps remaining and no cooldown
	if (Input.is_action_pressed("space") or Input.is_action_pressed("w")) and (jumps_left) and (!jump_timer):
		# Start Cooldown
		$JumpTimer.start()
		jump_timer = true
		
		# Jump
		jumps_left -= 1
		velocity.y = -BASE_JUMP_VELOCITY*y_modifier
	
	move_and_slide()


func _on_jump_timer_timeout() -> void:
	jump_timer = false
