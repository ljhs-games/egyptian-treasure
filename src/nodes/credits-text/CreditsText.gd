extends Label

export var scroll_rate = 40.0

var start_counter = 0.0

var credits = """
creikey
as
Team Lead and Programmer


Stving_artist
as
Lead Artist

Kathan Reddy
as
Artist

Music
by
Derek Fiechter

Doorknob Jiggle
by
Kyle1Katarn CC By 3.0

Death Sound
by
LittleRobot SoundFactory CC By 3.0

Key Get Sound
by
passAirmangrace CC By 3.0
"""

func _ready():
	set_process(true)
	if credits != "":
		self.text = credits

func _process(delta):
	if start_counter < 1.0:
		start_counter += delta
		return
	rect_global_position.y -= scroll_rate*delta
	if margin_bottom <= 500:
		set_process(false)