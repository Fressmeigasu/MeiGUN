extends CharacterBody2D

@onready var player = get_node("/root/Game/Player")
signal enemy_died()

var health = 10

const speed : float = 200
func _ready():
	$Slime.play_walk()
	
	
func _physics_process(delta):
	var direction: Vector2 = global_position.direction_to(player.global_position)
	velocity = direction * speed
	move_and_slide()
	
func take_damage(amount):
	$Slime.play_hurt()
	health -= amount
	if health <= 0:
		queue_free()
		enemy_died.emit()
		
		const smoke_scene: PackedScene = preload("res://assets/smoke_explosion/smoke_explosion.tscn")
		var smoke: Node = smoke_scene.instantiate()
		get_parent().add_child(smoke)
		smoke.global_position = global_position



func drop_loot():
	pass


func _on_enemy_died():
	const coin_scene = preload("res://scenes/coin.tscn")
	var coin = coin_scene.instantiate()
	get_parent().call_deferred("add_child", coin)
	coin.global_position = global_position
	coin.add_to_group("Coins")
