function onUpdateDatabase()
	db.query("ALTER TABLE `myaac_monsters` ADD `looktypeasitem` smallint(5) NOT NULL DEFAULT 0")
	return true
end