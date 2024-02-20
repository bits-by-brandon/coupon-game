class_name LineItem
extends HBoxContainer

func set_label(string : String):
	%Label.text = string

func set_value(value : float):
	%DiscountsAppliedLabel.text = "$%.2f" % [value]
