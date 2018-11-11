extends Node

signal setting_changed(setting_string, new_val)

const setting_filename = "user://settings.json"

var settings_file = File.new()

var _settings = {
	"audio": true
}

func _ready():
	connect("tree_exiting", self, "_on_Settings_tree_exiting")
	get_tree().connect("tree_changed", self, "_on_Settings_tree_changed")
	if settings_file.file_exists(setting_filename):
		settings_file.open(setting_filename, File.READ)
		_settings = parse_json(settings_file.get_as_text())
	settings_file.close()

func _on_Settings_tree_changed():
	print("Updating")
	for setting_name in _settings.keys():
		emit_signal("setting_changed", setting_name, _settings[setting_name])

func _on_Settings_tree_exiting():
	dump_settings()

func dump_settings():
	settings_file.open(setting_filename, File.WRITE)
	settings_file.store_string(to_json(_settings))
	settings_file.close()

func set_setting(setting_name, new_val):
	_settings[setting_name] = new_val
	emit_signal("setting_changed", setting_name, new_val)

func get_setting(setting_name):
	return _settings[setting_name]