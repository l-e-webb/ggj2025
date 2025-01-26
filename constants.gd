class_name Constants extends Node

const MAX_BUBBLE_SCALE = 0.9999
const MAX_BUBBLE_DURATION = 25.
const BUBBLE_SCALE_SPEED_FACTOR = 0.5
const BUBBLE_MIN_SCALE = 0.4

const PLAIN_BUBBLE_RISE_TRANS = Tween.TRANS_SINE
const PLAIN_BUBBLE_RISE_EASE = Tween.EASE_IN
const PLAIN_BUBBLE_RISE_DURATION = 8
const PLAIN_BUBBLE_RISE_TARGET = -800

const PLAIN_BUBBLE_DRIFT_TRANS = Tween.TRANS_SINE
const PLAIN_BUBBLE_DRIFT_EASE = Tween.EASE_IN_OUT
const PLAIN_BUBBLE_DRIFT_OFFSET = 80
const PLAIN_BUBBLE_DRIFT_DURATION = 2.5

const GUM_BUBBLE_RISE_TRANS = Tween.TRANS_SINE
const GUM_BUBBLE_RISE_EASE = Tween.EASE_IN
const GUM_BUBBLE_RISE_DURATION = 12
const GUM_BUBBLE_RISE_TARGET = -800

const GUM_BUBBLE_DRIFT_TRANS = Tween.TRANS_SINE
const GUM_BUBBLE_DRIFT_EASE = Tween.EASE_IN_OUT
const GUM_BUBBLE_DRIFT_OFFSET = 80
const GUM_BUBBLE_DRIFT_DURATION = 2.5

const GUM_BUBBLE_ROTATION_SPEED = PI/2

const ELEVATOR_BUBBLE_RISE_TRANS = Tween.TRANS_SINE
const ELEVATOR_BUBBLE_RISE_EASE = Tween.EASE_IN_OUT
const ELEVATOR_BUBBLE_RISE_DURATION = 4.5
const ELEVATOR_BUBBLE_RISE_TARGET = 150

const ELEVATOR_BUBBLE_DESCEND_TRANS = Tween.TRANS_SINE
const ELEVATOR_BUBBLE_DESCEND_EASE = Tween.EASE_IN
const ELEVATOR_BUBBLE_DESCEND_DURATION = 6
const ELEVATOR_BUBBLE_DESCEND_TARGET = 1500

const ELEVATOR_BUBBLE_DRIFT_TRANS = Tween.TRANS_SINE
const ELEVATOR_BUBBLE_DRIFT_EASE = Tween.EASE_IN_OUT
const ELEVATOR_BUBBLE_DRIFT_OFFSET = 40
const ELEVATOR_BUBBLE_DRIFT_DURATION = 3

const BUBBLE_WAND_COOLDOWN = 1.5

const PLAYER_HORIZONTAL_SPEED = 225.
const PLAYER_FLOOR_JUMP_VELOCITY = 350.
const PLAYER_AIR_JUMP_VELOCITY = 300.
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
