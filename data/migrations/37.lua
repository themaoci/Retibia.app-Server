function onUpdateDatabase()
	db.query("ALTER TABLE `myaac_monsters` ADD `looktype` smallint(5) NOT NULL DEFAULT 0")
	db.query("ALTER TABLE `myaac_monsters` ADD `looktype_body` smallint(3) NOT NULL DEFAULT 0")
	db.query("ALTER TABLE `myaac_monsters` ADD `looktype_head` smallint(3) NOT NULL DEFAULT 0")
	db.query("ALTER TABLE `myaac_monsters` ADD `looktype_legs` smallint(3) NOT NULL DEFAULT 0")
	db.query("ALTER TABLE `myaac_monsters` ADD `looktype_feet` smallint(3) NOT NULL DEFAULT 0")
	db.query("ALTER TABLE `myaac_monsters` ADD `corpselook` int(7) NOT NULL DEFAULT 0")

	db.query("ALTER TABLE `myaac_spells` ADD `maglevel` int(11) NOT NULL DEFAULT 0")
	db.query("ALTER TABLE `myaac_spells` ADD `cqclevel` int(11) NOT NULL DEFAULT 0")
	db.query("ALTER TABLE `myaac_spells` ADD `distancelevel` int(11) NOT NULL DEFAULT 0")
	db.query("ALTER TABLE `myaac_spells` ADD `flag_noLevelCheck` tinyint(1) NOT NULL DEFAULT 0")
	db.query("ALTER TABLE `myaac_spells` ADD `flag_onlyOneRequired` tinyint(1) NOT NULL DEFAULT 0")
	return true
end