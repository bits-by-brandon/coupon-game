class_name ExplosionManager
extends Node2D

const explostion_particles = preload("res://scenes/explosion/explosion_particles.tscn")

func _ready():
	Events.explode_requested.connect(_on_explode_requested)

func _on_explode_requested(explosion_position: Vector2) -> void:
	var explosion = explostion_particles.instantiate()
	explosion.global_position = explosion_position
	explosion.finished.connect(func (): explosion.queue_free())
	explosion.emitting = true
	add_child(explosion)