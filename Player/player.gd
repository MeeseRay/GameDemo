extends CharacterBody2D

# Variables
@export var DashSpeed : float = 600.0
@export var WalkSpeed : float = 200.0
@export var RunSpeed : float = 400.0

var CanDoubleJump = true
var CanCoyoteJump = false
@export var JumpHeight : float = 100.0
@export var TimeToPeak : float = 0.4
@export var TimeToFall : float = 0.25
@export var JumpVelocity : float = ((2.0 * JumpHeight) / TimeToPeak) * -1.0
@export var JumpGravity : float = ((-2.0 * JumpHeight) / (TimeToPeak * TimeToPeak)) * -1.0
@export var FallGravity : float = ((-2.0 * JumpHeight) / (TimeToFall * TimeToFall)) * -1.0

var Speed
var CanDash = true




func _physics_process(delta):
	# Implements gravity.
	velocity.y += GetGravity() * delta
	var direction = Input.get_axis("move_left", "move_right")
	
	# Handles Jump.
	Jump()
	# Handles Sprinting.
	Sprint()
	# Handles Movement.
	Move(direction)
	# Handles Dash.
	Dash(direction)
	
	if velocity.x != 0:
		$AnimatedSprite2D.flip_v = false
		# See the note below about boolean assignment.
		$AnimatedSprite2D.flip_h = velocity.x < 0
	
	
	# Used for Coyote Jump.
	var WasOnFloor = is_on_floor()
	move_and_slide()
	var JustLeftLedge = WasOnFloor and !is_on_floor() and velocity.y >= 0
	if JustLeftLedge:
		CanCoyoteJump = true
		$CoyoteTime.start()
	
# Handles Jump input. 
func Jump():
	if is_on_floor() or CanCoyoteJump:
		if Input.is_action_just_pressed("jump"):
			CanDoubleJump = true
			velocity.y = JumpVelocity
	elif CanDoubleJump and !is_on_floor():
		if Input.is_action_just_pressed("jump"):
			velocity.y = JumpVelocity
			CanDoubleJump = false
	if Input.is_action_just_released("jump") and velocity.y < 0:
		$JumpTimer.start()
			
# Returns neccessary gravity.
func GetGravity():
	if velocity.y < 0.0:
		return JumpGravity
	else:
		return FallGravity
	
# Handles left and right input. 
func Move(direction):
	velocity.x = direction * Speed

# Handles sprint input. 
func Sprint():
	if Input.is_action_pressed("sprint"):
		$AnimatedSprite2D.animation = "Samurai_Run"
		$AnimatedSprite2D.play()
		Speed = RunSpeed
	else:
		Speed = WalkSpeed
	
# Handles dash input. 
func Dash(direction):
	if Input.is_action_just_pressed("dash") and CanDash:
		velocity.x = DashSpeed * direction
		$DashTimer.start()
		CanDash = false
		$DashCooldown.start()



func _on_dash_timer_timeout():
	var direction = Input.get_axis("move_left", "move_right")
	velocity.x = DashSpeed / direction
func _on_dash_cooldown_timeout():
	CanDash = true
func _on_coyote_time_timeout():
	CanCoyoteJump = false
func _on_jump_timer_timeout():
	velocity.y = -25
