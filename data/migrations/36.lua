function onUpdateDatabase()
	db.query("ALTER TABLE `players` ADD `equiped` text NOT NULL DEFAULT ''")
	return true
end