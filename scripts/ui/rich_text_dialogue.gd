@tool
extends RichTextEffect
class_name RichTextDialogue

var bbcode = "dialogue"

func _process_custom_fx(char_fx: CharFXTransform) -> bool:
	var scale = char_fx.env.get("scale", 1)
	var time = char_fx.env.get("time", 0.3)
	var speed = char_fx.env.get("speed", 0.0)

	# elapsed_time is shared by the whole label, so offset it by when this
	# character gets revealed: characters appear one interval apart.
	var interval = 1.0 / speed if speed > 0.0 else 0.0
	var elapsed = char_fx.elapsed_time - char_fx.range.x * interval

	var x = elapsed / time
	# Scale individual letters with easing!
	var alpha = ease_out_elastic(x)
	var eased_scale = scale * ease_out_elastic(x)
	char_fx.color.a = alpha
	char_fx.transform = char_fx.transform.scaled(Vector2(eased_scale, eased_scale))

	return true


func linear(x: float) -> float:
	if x <= 0:
		return 0
	if x >= 1:
		return 1
	return x


func ease_out_elastic(x: float) -> float:
	var c4 = (2 * PI) / 3
	if x <= 0:
		return 0
	if x >= 1:
		return 1
	return pow(2, -10 * x) * sin((x * 10 - 0.75) * c4) + 1;
