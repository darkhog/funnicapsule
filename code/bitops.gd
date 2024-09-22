extends Node

class_name bitops

# Check if a bit flag is set
static func isFlagSet(num: int, bit: int) -> bool:
	return (num & (1 << bit)) != 0

# Raise bitflag
static func raiseBitFlag(num: int, bit: int) -> int:
	return num | (1 << bit)

# Clear bitflag
static func clearBitFlag(num: int, bit: int) -> int:
	return num & ~(1 << bit)

static func toggleBitFlag(num: int, bit: int) -> int:
	if (isFlagSet(num,bit)):
		return clearBitFlag(num,bit)
	else:
		return raiseBitFlag(num,bit)

# Set bitflag
static func setBitFlag(num: int, bit: int, on: bool) -> int:
	if on:
		return raiseBitFlag(num,bit)
	else:
		return clearBitFlag(num,bit)
