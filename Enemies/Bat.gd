extends KinematicBody2D

var knockback = Vector2.ZERO
const EnemyDeathEffect = preload("res://Effects/DeathEffect.tscn")
onready var stats = $Stats
onready var playerDetection = $PlayerDetectionZone
onready var sprite = $AnimatedSprite
onready var hurtbox = $Hurtbox
onready var soft_collision = $SoftCollision

export var ACCELERATION = 300
export var MAX_SPEED = 50
export var FRICTION = 200

var velocity = Vector2.ZERO

enum{
	IDLE,
	WANDER,
	CHASE
}

var state = IDLE

func _ready():
	pass

func _physics_process(delta):
	knockback = knockback.move_toward(Vector2.ZERO, FRICTION*delta)
	knockback = move_and_slide(knockback)
	
	match state:
		IDLE:
			velocity = velocity.move_toward(Vector2.ZERO, FRICTION*delta)
			seek_player()
		WANDER:
			pass
		CHASE:
			var player = playerDetection.player
			if player != null:
				var direction = (player.global_position - global_position).normalized()
				velocity = velocity.move_toward(direction * MAX_SPEED, ACCELERATION*delta)
				sprite.flip_h = velocity.x < 0
			else:
				state = IDLE
	
	if soft_collision.is_colliding():
		velocity += soft_collision.get_push_vector() *delta *400
	
	velocity = move_and_slide(velocity)

func _on_Hurtbox_area_entered(area):
	stats.health -= area.damage
	knockback = area.knockback_vector * 117
	hurtbox.create_hitEffect()
	


func _on_Stats_no_health():
	queue_free()
	var enemyDeathEffect = EnemyDeathEffect.instance()
	get_parent().add_child(enemyDeathEffect)
	enemyDeathEffect.global_position = global_position


func seek_player():
	if playerDetection.can_see_player():
		state = CHASE
