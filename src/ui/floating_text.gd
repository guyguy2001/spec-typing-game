# floating_text.gd
extends Label

func _ready() -> void:
    var tween = create_tween()
    tween.set_parallel(true)
    tween.tween_property(self, "position:y", position.y - 50, 1.0).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_OUT)
    tween.tween_property(self, "modulate:a", 0.0, 1.0).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_IN)
    tween.chain().tween_callback(queue_free)

func setup(value: String, color: Color) -> void:
    text = value
    modulate = color
