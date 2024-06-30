extends Node

# Check if a bit flag is set
static func isFlagSet(num: int, bit: int) -> bool:
	return (num & (1 << bit)) != 0

# Raise bitflag
static func raiseBitFlag(num: int, bit: int) -> int:
	return num | (1 << bit)

# Clear bitflag
static func clearBitFlag(num: int, bit: int) -> int:
	return num & ~(1 << bit)

# Set bitflag
static func setBitFlag(num: int, bit: int, on: bool) -> int:
	if on:
		return raiseBitFlag(num,bit)
	else:
		return clearBitFlag(num,bit)
