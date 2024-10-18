extends CharacterBody2D


var speed : int = 500
var accel : int  = 1
var health : float = 1000

@onready var nav = $NavigationAgent2D

signal Boss_Died
var new_pattern : PatternCircle = PatternCircle.new()


func _physics_process(_delta):
	while health > 0:
		get_tree().create_timer(10.0).timeout
		shoots()
		get_tree().create_timer(1.0).timeout
		move()
	
	move_and_slide()


func move():
	var direction = Vector3()
	nav.target_position = Vector2(randi_range(0, 1000), randi_range(0,1000))
	direction = nav.get_next_path_position() - global_position
	direction = direction.normalized()
	velocity = velocity.lerp(direction * speed, accel)

func _on_move_timer_timeout():
	move()

func take_damage(amount):
	health -= amount
	if health <= 0:
		queue_free()
		Boss_Died.emit()
		
		const smoke_scene = preload("res://assets/smoke_explosion/smoke_explosion.tscn")
		var smoke = smoke_scene.instantiate()
		get_parent().add_child(smoke)
		smoke.global_position = global_position
	print("Boss took damage")
	print("Boss Health: " + str(health))

func shoots():
	#new_pattern.offset = Vector2i(20,20)
	#new_pattern.bullet = "2"
	#new_pattern.nbr = 10
	#Spawning.new_pattern("two", new_pattern)
	Spawning.spawn($BulletSpawnPoint, "one", "first")


func _on_shoot_timer_timeout():
	shoots()
