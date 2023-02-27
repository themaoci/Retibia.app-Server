function onUpdateDatabase()
	print("MyAcc - Database Update #3 (list of items plugin)")
	print("Create table if not exist: list_of_items")
	db.query("CREATE TABLE IF NOT EXISTS `list_of_items` (\z
		`id` int(11) NOT NULL,\z
		`name` varchar(100) COLLATE utf8_polish_ci NOT NULL,\z
		`description` varchar(1000) COLLATE utf8_polish_ci NOT NULL,\z
		`level` int(11) NOT NULL,\z
		`type` varchar(255) COLLATE utf8_polish_ci NOT NULL DEFAULT ''\z
	) ENGINE=MyISAM")
	return true
end