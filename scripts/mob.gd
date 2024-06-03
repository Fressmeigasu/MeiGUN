extends CharacterBody2D

@onready var player = get_node("/root/Game/Player")
signal enemy_died()

var health = 1

const speed : float = 200
func _ready():
	$Slime.play_walk()
	
	
func _physics_process(delta):
	var direction = global_position.direction_to(player.global_position)
	velocity = direction * speed
	move_and_slide()
	
func take_damage():
	$Slime.play_hurt()
	health -= 1
	if health <= 0:
		queue_free()
		enemy_died.emit()
		
		const smoke_scene = preload("res://assets/smoke_explosion/smoke_explosion.tscn")
		var smoke = smoke_scene.instantiate()
		get_parent().add_child(smoke)
		smoke.global_position = global_position



func drop_loot():
	pass


func _on_enemy_died():
	const coin_scene = preload("res://scenes/coin.tscn")
	var coin = coin_scene.instantiate()
	get_parent().call_deferred("add_child", coin)
	coin.global_position = global_position
