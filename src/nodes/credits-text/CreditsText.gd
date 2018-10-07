extends RichTextLabel

export (String, FILE) var credits_filepath

func _ready():
	var credits_file = File.new()
	credits_file.open(credits_filepath, credits_file.READ)
	var credits_text = credits_file.get_as_text()
	if credits_text != "":
		clear()
		push_align(RichTextLabel.ALIGN_CENTER)
		add_text(credits_text)
		pop()
	credits_file.close()