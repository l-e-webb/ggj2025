class_name Constants extends Node

const MAX_BUBBLE_SCALE = 0.9999
const MAX_BUBBLE_DURATION = 25.
const BUBBLE_SCALE_SPEED_FACTOR = 0.5
const BUBBLE_MIN_SCALE = 0.2

const PLAIN_BUBBLE_RISE_ACCEL = 3.
const PLAIN_BUBBLE_RISE_MAX_SPEED = 2.
const PLAIN_BUBBLE_DRIFT_AMPLITUDE = 0.5
const PLAIN_BUBBLE_DRIFT_FREQUENCY = 1.5

const PLAIN_BUBBLE_RISE_TRANS = Tween.TRANS_SINE
const PLAIN_BUBBLE_RISE_EASE = Tween.EASE_IN
const PLAIN_BUBBLE_RISE_DURATION = 9
const PLAIN_BUBBLE_RISE_TARGET = -800

const PLAIN_BUBBLE_DRIFT_TRANS = Tween.TRANS_SINE
const PLAIN_BUBBLE_DRIFT_EASE = Tween.EASE_IN_OUT
const PLAIN_BUBBLE_DRIFT_OFFSET = 80
const PLAIN_BUBBLE_DRIFT_DURATION = 2.5

const BUBBLE_WAND_COOLDOWN = 1.5

const PLAYER_HORIZONTAL_SPEED = 300.
const PLAYER_FLOOR_JUMP_VELOCITY = 450.
const PLAYER_AIR_JUMP_VELOCITY = 400.
# If the player presses jump before landing on a platform but lands within this
# many seconds, or if a player presses jump after walking off a platform within
# this many seconds, it counts as a jump on the ground. This is a quality of life
# improvement so that the player doesn't have the "But I pressed jump!!?#$!?"
# experience.
const PLAYER_JUMP_BUFFER_TIME = 0.1
# This many seconds must elapse after a floor jump before an air jump can be
# executed. Stops players from accidentally wasting their air jump when mashing
# the jump button.
const MIN_TIME_BEFORE_SECOND_JUMP = 0.25
