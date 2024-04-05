extends Node2D

func push_enemy_away(enemy: Node2D, push_speed: float):
  var direction_to_enemy = (enemy.global_transform.origin - global_transform.origin)
  direction_to_enemy.y = 0;
  direction_to_enemy = direction_to_enemy.normalized()

  var motion = direction_to_enemy * push_speed
  var collision = enemy.move_and_collide(motion)
  if collision:
    # Enemy take damage here
    pass