extends Node

const FLAG_HASGUN = 0
const FLAG_CUTSCENELOCK = 1
const FLAG_2 = 2
const FLAG_3 = 3
const FLAG_4 = 4
const FLAG_5 = 5
const FLAG_6 = 6
const FLAG_7 = 7
const FLAG_8 = 8
const FLAG_9 = 9
const FLAG_10 = 10
const FLAG_11 = 11
const FLAG_12 = 12
const FLAG_13 = 13
const FLAG_14 = 14
const FLAG_15 = 15
const FLAG_16 = 16
const FLAG_17 = 17
const FLAG_18 = 18
const FLAG_19 = 19
const FLAG_20 = 20
const FLAG_21 = 21
const FLAG_22 = 22
const FLAG_23 = 23
const FLAG_24 = 24
const FLAG_25 = 25
const FLAG_26 = 26
const FLAG_27 = 27
const FLAG_28 = 28
const FLAG_29 = 29
const FLAG_30 = 30
const FLAG_31 = 31
const MAX_HP:float=100

var consolelog:String = "Ready."
var playerflags:int
var playerHealth:float:
	set (value):
			playerHealth = value
			if playerHealth>MAX_HP:
				playerHealth = MAX_HP
var playername:String
var playerLives:int
var score:int
var lockCamera:bool = true
func DebugPrint(thing):
	print(thing)
	consolelog+="\n" + str(thing)
func ResetGame():
	playerflags=0
	playerHealth = MAX_HP
	playername = "Capsule"
	playerLives = 3
	score = 0
	lockCamera = true
