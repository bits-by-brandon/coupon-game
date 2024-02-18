class_name ItemData
extends Resource

enum Category {
	None,
	Frozen,
	Drink,
	Desert,
	Fruit,
	Meat,
	Clothes,
	Tech
}

enum Shape {
	Circle,
	Rectangle,
	Square,
	Cylinder,
	Pill,
	Triangle
}

enum Company {
	Fellogs,
	SpecificMills,
	Restle,
	BananaDemocracy,
	YoMami,
	ChokinCola,
	WallFart,
	WorstBuy,
	BurgerQueen,
	Tesalad,
	WindowSoft
}

enum ItemColor {
	Red,
	Blue,
	Green,
	Yellow,
}

enum Season {
	Spring,
	Summer,
	Fall,
	Winter
}

@export var name := "Item"
@export var price := 1.00
@export var categories : Array[Category] = []
@export var valid_companies : Array[Company] = []
@export var colors : Array[ItemColor] = []
@export var seasons : Array[Season] = []
@export var expiration : int
@export var texture : Texture2D