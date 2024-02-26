class_name LineItem
extends HBoxContainer

func set_label(string: String):
	%Label.text = string

func set_value(value: String):
	%DiscountsAppliedLabel.text = value
