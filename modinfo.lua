name = "In-game Mod Management"
description = "Access your mods from in-game. You can enable, disable, and configure your mods without exiting the game now.\nThe default key is set to \' next to the enter key"
author = "rawii22 & lord_of_les_ralph"
version = "1.0"
icon = "modicon.tex"
icon_atlas = "modicon.xml"

forumthread = ""

api_version = 10

priority = - 1
dst_compatible = true
all_clients_require_mod = true
client_only_mod = false

configuration_options = {
  {
    name = "KEY",
    label = "Mod Screen Shortcut",
    default = "\'",
    options = {
		{description = "A", data = "A"},
		{description = "B", data = "B"},
		{description = "C", data = "C"},
		{description = "D", data = "D"},
		{description = "E", data = "E"},
		{description = "F", data = "F"},
		{description = "G", data = "G"},
		{description = "H", data = "H"},
		{description = "I", data = "I"},
		{description = "J", data = "J"},
		{description = "K", data = "K"},
		{description = "L", data = "L"},
		{description = "M", data = "M"},
		{description = "N", data = "N"},
		{description = "O", data = "O"},
		{description = "P", data = "P"},
		{description = "Q", data = "Q"},
		{description = "R", data = "R"},
		{description = "S", data = "S"},
		{description = "T", data = "T"},
		{description = "U", data = "U"},
		{description = "V", data = "V"},
		{description = "W", data = "W"},
		{description = "X", data = "X"},
		{description = "Y", data = "Y"},
		{description = "Z", data = "Z"},
		{description = "[", data = "["},
		{description = "]", data = "]"},
		{description = "\\", data ="\\"},
		{description = ";", data = ";"},
		{description = "\'", data ="\'"},
		{description = "/", data = "/"},
		{description = "-", data = "-"},
		{description = "=", data = "="}
	}
  },
}