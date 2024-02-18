class_name ItemData
extends Resource

enum Category {
	FrozenFood,
	Drinks,
	Desserts,
	Fruit,
	Meat,
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
@export var base_price := 1.00
@export var price_variance := 1.00
@export var categories : Array[Category] = []
@export var valid_companies : Array[Company] = []
@export var colors : Array[ItemColor] = []
@export var shape : Shape
@export var seasons : Array[Season] = []
@export var expiration : int
@export var texture : Texture2D