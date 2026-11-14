extends CharacterBody2D


const SPEED = 1500
var jump_velocity = -400.0
var jump_strength = -20
var charging_jump = false
var overboard = false
var bounce = true 
func _physics_process(delta: float) -> void:
	if Globals.charging_jump == true and Globals.overboard == false:
		Globals.jump_velocity += Globals.jump_strength
		print(Globals.jump_velocity)
		if Globals.jump_velocity <= -2000:
			Globals.jump_velocity = 0
			overboard = true
			print("overborad")
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta
	if is_on_floor() and bounce == true:
		print(jump_velocity)
		velocity.y = Globals.jump_velocity + 200
		Globals.jump_velocity = Globals.jump_velocity/2
		print(Globals.jump_velocity)
		
		if Globals.jump_velocity >= -10:
			bounce = false
			Globals.jump_velocity = -400
			
				#elif is_on_floor():
		#bounce = true
		#$BounceTimer.start()
		#velocity += -get_gravity() * delta
		
	
	# Handle jump.
	if Input.is_action_just_pressed("Jump") and is_on_floor():
		Globals.charging_jump = true
	if Input.is_action_just_released("Jump") and Globals.charging_jump == true:
		Globals.charging_jump = false
		bounce = true
		velocity.y = Globals.jump_velocity
		
		Globals.overboard = false
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction := Input.get_axis("Strafe Left", "Strafe Right")
	rotation = global_position.direction_to(get_global_mouse_position()).angle()
	#rotation = global_position.direction_to(get_global_mouse_position()).angle()
	#direction = global_position.direction_to(get_global_mouse_position())
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()


func _on_bounce_timer_timeout() -> void:
	bounce = true
	

	
