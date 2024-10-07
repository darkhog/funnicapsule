extends Node

const FLAG_HASGUN :int= 0
const FLAG_CUTSCENELOCK :int= 1
const FLAG_2 :int= 2
const FLAG_3 :int= 3
const FLAG_4 :int= 4
const FLAG_5 :int= 5
const FLAG_6 :int= 6
const FLAG_7 :int= 7
const FLAG_8 :int= 8
const FLAG_9 :int= 9
const FLAG_10 :int= 10
const FLAG_11 :int= 11
const FLAG_12 :int= 12
const FLAG_13 :int= 13
const FLAG_14 :int= 14
const FLAG_15 :int= 15
const FLAG_16 :int= 16
const FLAG_17 :int= 17
const FLAG_18 :int= 18
const FLAG_19 :int= 19
const FLAG_20 :int= 20
const FLAG_21 :int= 21
const FLAG_22 :int= 22
const FLAG_23 :int= 23
const FLAG_24 :int= 24
const FLAG_25 :int= 25
const FLAG_26 :int= 26
const FLAG_27 :int= 27
const FLAG_28 :int= 28
const FLAG_29 :int= 29
const FLAG_30 :int= 30
const FLAG_31 :int= 31
const MAX_HP:float=100
var playerPosition:Vector3
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
func DebugPrint(thing) ->void:
	print(thing)
	consolelog+="\n" + str(thing)
func ResetGame()->void:
	playerflags=0
	playerHealth = MAX_HP
	playername = "Capsule"
	playerLives = 3
	score = 0
	lockCamera = true
func ExtractFileNextToExe(filename:String)->void:
	var inFile:FileAccess=FileAccess.open(filename,FileAccess.READ)
	var outFile:FileAccess=FileAccess.open(OS.get_executable_path().get_base_dir()+"/"+filename.get_file(),FileAccess.WRITE)
	var buffer:PackedByteArray=inFile.get_buffer(inFile.get_length())
	outFile.store_buffer(buffer)
	outFile.flush()
	outFile.close()
	inFile.close()
	
