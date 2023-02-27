function onUpdateDatabase()
	print("MyAcc - Database Update #4 (polls)")
	print("Create table if not exist: z_polls")
	db.query("CREATE TABLE IF NOT EXISTS `z_polls` (\z
		`id` int(11) NOT NULL,\z
		`question` varchar(255) NOT NULL,\z
		`description` varchar(255) NOT NULL,\z
		`end` int(11) NOT NULL DEFAULT 0,\z
		`start` int(11) NOT NULL DEFAULT 0,\z
		`answers` int(11) NOT NULL DEFAULT 0,\z
		`votes_all` int(11) NOT NULL DEFAULT 0\z
	) ENGINE=InnoDB DEFAULT CHARSET=utf8")

	print("Create table if not exist: z_polls_answers")
	db.query("CREATE TABLE IF NOT EXISTS `z_polls_answers` (\z
		`poll_id` int(11) NOT NULL,\z
		`answer_id` int(11) NOT NULL,\z
		`answer` varchar(255) NOT NULL,\z
		`votes` int(11) NOT NULL DEFAULT 0\z
	) ENGINE=InnoDB DEFAULT CHARSET=utf8")

	print("ALTER TABLE: z_polls")
	db.query("ALTER TABLE `z_polls` ADD PRIMARY KEY (`id`)")
	db.query("ALTER TABLE `z_polls` MODIFY `id` int(11) NOT NULL AUTO_INCREMENT")
	return true
end