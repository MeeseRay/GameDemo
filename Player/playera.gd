extends CharacterBody2D

@export var JumpPower : float = -500.0
@export var DashSpeed : float = 900.0
@export var WalkSpeed : float = 200.0
@export var RunSpeed : float = 400.0
@export var GRAVITY : float = 950.0
var Speed
var CanDoubleJump = true


func _physics_process(delta):
	# Implements gravity.
	if not is_on_floor():
		velocity.y += delta * GRAVITY
	
	# Handles Jump.
	if Input.is_action_just_pressed("jump") and is_on_floor():
		CanDoubleJump = true
		velocity.y = JumpPower
		velocity.x = Speed
	elif Input.is_action_just_pressed("jump") and !is_on_floor() and CanDoubleJump:
		CanDoubleJump = false
		velocity.y = JumpPower
		velocity.x = Speed
		
	# Handles Sprinting.
	if Input.is_action_pressed("sprint"):
		Speed = RunSpeed
		$AnimatedSprite2D.play("run")
	else:
		Speed = WalkSpeed
		$AnimatedSprite2D.stop()
		
	# Handles Movement.
	var direction = Input.get_axis("move_left", "move_right")
	velocity.x = direction * Speed
	if velocity.x < 0:
		$AnimatedSprite2D.flip_h = true
	else:
		$AnimatedSprite2D.flip_h = false
	
	# Handles Dashing.
	if Input.is_action_pressed("dash"):
		velocity.x = direction * DashSpeed
	
	move_and_slide()
	
