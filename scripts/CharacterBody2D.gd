extends CharacterBody2D
var score = 0
signal health_depleted
signal level_up


var level : int = 1
var health: float = 100.0
const speed: int = 500
var max_health = health
@export var max_health_limit : float

func _physics_process(delta):
	#directions
	var direction = Input.get_vector("left", "right", "forward", "backward")
	velocity = direction * speed
	move_and_slide()
	if velocity.length() > 0.0 :
		%HappyBoo.play_walk_animation()
	else:
		%HappyBoo.play_idle_animation()

#damages
	const damage_rate = 5.0
	var overlap_mobs = %HurtBox.get_overlapping_bodies()
	if overlap_mobs.size() > 0:
		health -= damage_rate * overlap_mobs.size() * delta
	#death
	if health <= 0.0 :
		health_depleted.emit()
		
	#levels
	var xp = score / level
	if xp >= 10:
		level += 1
		score = 0
		level_up.emit()
		
	$ProgressBar.value = health

func coin_picked_up(coin_Value):
	score += coin_Value
	print("Score = " + str(score))

func _on_level_up():
	max_health *= level
	print( "maxHealth = "+ str(max_health))
	health = max_health
	print("health = " + str(health))
	if max_health >= max_health_limit:
		max_health = max_health_limit
		health = max_health_limit
	%ProgressBar.max_value = max_health


