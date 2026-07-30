@tool
extends RichTextEffect
class_name RichTextDialogue

var bbcode = "dialogue"

func _process_custom_fx(char_fx: CharFXTransform) -> bool:
	var scale = char_fx.env.get("scale", 1.5)
	var time = char_fx.env.get("time", 3.0)

	var x = char_fx.elapsed_time / time
	# Scale individual letters with easing!
	var eased_scale = scale * ease_out_elastic(x)
	char_fx.transform = char_fx.transform.scaled(Vector2(eased_scale, eased_scale))

	return true


func ease_out_elastic(x: float) -> float:
	var c4 = (2 * PI) / 3
	if x <= 0:
		return 0
	if x >= 1:
		return 1
	return pow(2, -10 * x) * sin((x * 10 - 0.75) * c4) + 1;
