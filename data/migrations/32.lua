function onUpdateDatabase()
	print("MyAcc - Database Update #1")
	print("MyAcc - CREATE TABLE")
	-- CREATE TABLE IF EXIST SECTION
	print("Create if not exist: myaac_account_actions")
	db.query("CREATE TABLE IF NOT EXISTS `myaac_account_actions` (\z
		`account_id` int(11) NOT NULL,\z
		`ip` int(10) UNSIGNED NOT NULL DEFAULT 0,\z
		`ipv6` binary(16) NOT NULL DEFAULT '0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0',\z
		`date` int(11) NOT NULL DEFAULT 0,\z
		`action` varchar(255) NOT NULL DEFAULT ''\z
	) ENGINE=InnoDB DEFAULT CHARSET=utf8")
	print("Create if not exist: myaac_admin_menu")
	db.query("CREATE TABLE IF NOT EXISTS `myaac_admin_menu` (\z
		`id` int(11) NOT NULL,\z
		`name` varchar(255) NOT NULL DEFAULT '',\z
		`page` varchar(255) NOT NULL DEFAULT '',\z
		`ordering` int(11) NOT NULL DEFAULT 0,\z
		`flags` int(11) NOT NULL DEFAULT 0,\z
		`enabled` int(1) NOT NULL DEFAULT 1\z
	) ENGINE=InnoDB DEFAULT CHARSET=utf8")
	print("Create if not exist: myaac_bugtracker")
	db.query("CREATE TABLE IF NOT EXISTS `myaac_bugtracker` (\z
		`account` varchar(255) NOT NULL,\z
		`type` int(11) NOT NULL DEFAULT 0,\z
		`status` int(11) NOT NULL DEFAULT 0,\z
		`text` text NOT NULL,\z
		`id` int(11) NOT NULL DEFAULT 0,\z
		`subject` varchar(255) NOT NULL DEFAULT '',\z
		`reply` int(11) NOT NULL DEFAULT 0,\z
		`who` int(11) NOT NULL DEFAULT 0,\z
		`uid` int(11) NOT NULL,\z
		`tag` int(11) NOT NULL DEFAULT 0\z
	) ENGINE=InnoDB DEFAULT CHARSET=utf8")
	print("Create if not exist: myaac_changelog")
	db.query("CREATE TABLE IF NOT EXISTS `myaac_changelog` (\z
		`id` int(11) NOT NULL,\z
		`body` varchar(500) NOT NULL DEFAULT '',\z
		`type` tinyint(1) NOT NULL DEFAULT 0 COMMENT '1 - added, 2 - removed, 3 - changed, 4 - fixed',\z
		`where` tinyint(1) NOT NULL DEFAULT 0 COMMENT '1 - server, 2 - site',\z
		`date` int(11) NOT NULL DEFAULT 0,\z
		`player_id` int(11) NOT NULL DEFAULT 0,\z
		`hidden` tinyint(1) NOT NULL DEFAULT 0\z
	) ENGINE=InnoDB DEFAULT CHARSET=utf8")
	print("Create if not exist: myaac_config")
	db.query("CREATE TABLE IF NOT EXISTS `myaac_config` (\z
		`id` int(11) NOT NULL,\z
		`name` varchar(30) NOT NULL,\z
		`value` varchar(1000) NOT NULL\z
	) ENGINE=InnoDB DEFAULT CHARSET=utf8")
	print("Create if not exist: myaac_faq")
	db.query("CREATE TABLE IF NOT EXISTS `myaac_faq` (\z
		`id` int(11) NOT NULL,\z
		`question` varchar(255) NOT NULL DEFAULT '',\z
		`answer` varchar(1020) NOT NULL DEFAULT '',\z
		`ordering` int(11) NOT NULL DEFAULT 0,\z
		`hidden` tinyint(1) NOT NULL DEFAULT 0\z
	) ENGINE=InnoDB DEFAULT CHARSET=utf8")
	print("Create if not exist: myaac_forum")
	db.query("CREATE TABLE IF NOT EXISTS `myaac_forum` (\z
		`id` int(11) NOT NULL,\z
		`first_post` int(11) NOT NULL DEFAULT 0,\z
		`last_post` int(11) NOT NULL DEFAULT 0,\z
		`section` int(3) NOT NULL DEFAULT 0,\z
		`replies` int(20) NOT NULL DEFAULT 0,\z
		`views` int(20) NOT NULL DEFAULT 0,\z
		`author_aid` int(20) NOT NULL DEFAULT 0,\z
		`author_guid` int(20) NOT NULL DEFAULT 0,\z
		`post_text` text NOT NULL,\z
		`post_topic` varchar(255) NOT NULL DEFAULT '',\z
		`post_smile` tinyint(1) NOT NULL DEFAULT 0,\z
		`post_html` tinyint(1) NOT NULL DEFAULT 0,\z
		`post_date` int(20) NOT NULL DEFAULT 0,\z
		`last_edit_aid` int(20) NOT NULL DEFAULT 0,\z
		`edit_date` int(20) NOT NULL DEFAULT 0,\z
		`post_ip` varchar(32) NOT NULL DEFAULT '0.0.0.0',\z
		`sticked` tinyint(1) NOT NULL DEFAULT 0,\z
		`closed` tinyint(1) NOT NULL DEFAULT 0\z
	) ENGINE=InnoDB DEFAULT CHARSET=utf8")
	print("Create if not exist: myaac_forum_boards")
	db.query("CREATE TABLE IF NOT EXISTS `myaac_forum_boards` (\z
		`id` int(11) NOT NULL,\z
		`name` varchar(32) NOT NULL,\z
		`description` varchar(255) NOT NULL DEFAULT '',\z
		`ordering` int(11) NOT NULL DEFAULT 0,\z
		`guild` int(11) NOT NULL DEFAULT 0,\z
		`access` int(11) NOT NULL DEFAULT 0,\z
		`closed` tinyint(1) NOT NULL DEFAULT 0,\z
		`hidden` tinyint(1) NOT NULL DEFAULT 0\z
	) ENGINE=InnoDB DEFAULT CHARSET=utf8")
	print("Create if not exist: myaac_gallery")
	db.query("CREATE TABLE IF NOT EXISTS `myaac_gallery` (\z
		`id` int(11) NOT NULL,\z
		`comment` varchar(255) NOT NULL DEFAULT '',\z
		`image` varchar(255) NOT NULL,\z
		`thumb` varchar(255) NOT NULL,\z
		`author` varchar(50) NOT NULL DEFAULT '',\z
		`ordering` int(11) NOT NULL DEFAULT 0,\z
		`hidden` tinyint(1) NOT NULL DEFAULT 0\z
	) ENGINE=InnoDB DEFAULT CHARSET=utf8")
	print("Create if not exist: myaac_menu")
	db.query("CREATE TABLE IF NOT EXISTS `myaac_menu` (\z
		`id` int(11) NOT NULL,\z
		`template` varchar(255) NOT NULL,\z
		`name` varchar(255) NOT NULL,\z
		`link` varchar(255) NOT NULL,\z
		`blank` tinyint(1) NOT NULL DEFAULT 0,\z
		`color` varchar(6) NOT NULL DEFAULT '',\z
		`category` int(11) NOT NULL DEFAULT 1,\z
		`ordering` int(11) NOT NULL DEFAULT 0,\z
		`enabled` int(1) NOT NULL DEFAULT 1\z
	) ENGINE=InnoDB DEFAULT CHARSET=utf8")
	print("Create if not exist: myaac_monsters")
	db.query("CREATE TABLE IF NOT EXISTS `myaac_monsters` (\z
		`id` int(11) NOT NULL,\z
		`hidden` tinyint(1) NOT NULL DEFAULT 0,\z
		`name` varchar(255) NOT NULL,\z
		`mana` int(11) NOT NULL DEFAULT 0,\z
		`exp` int(11) NOT NULL,\z
		`health` int(11) NOT NULL,\z
		`speed_lvl` int(11) NOT NULL DEFAULT 1,\z
		`use_haste` tinyint(1) NOT NULL,\z
		`voices` text NOT NULL DEFAULT '',\z
		`immunities` varchar(255) NOT NULL DEFAULT '',\z
		`elements` text NOT NULL DEFAULT '',\z
		`summonable` tinyint(1) NOT NULL,\z
		`convinceable` tinyint(1) NOT NULL,\z
		`pushable` tinyint(1) NOT NULL DEFAULT 0,\z
		`canpushitems` tinyint(1) NOT NULL DEFAULT 0,\z
		`canwalkonenergy` tinyint(1) NOT NULL DEFAULT 0,\z
		`canwalkonpoison` tinyint(1) NOT NULL DEFAULT 0,\z
		`canwalkonfire` tinyint(1) NOT NULL DEFAULT 0,\z
		`runonhealth` tinyint(1) NOT NULL DEFAULT 0,\z
		`hostile` tinyint(1) NOT NULL DEFAULT 0,\z
		`attackable` tinyint(1) NOT NULL DEFAULT 0,\z
		`rewardboss` tinyint(1) NOT NULL DEFAULT 0,\z
		`defense` int(11) NOT NULL DEFAULT 0,\z
		`armor` int(11) NOT NULL DEFAULT 0,\z
		`canpushcreatures` tinyint(1) NOT NULL DEFAULT 0,\z
		`race` varchar(255) NOT NULL,\z
		`loot` text NOT NULL DEFAULT '',\z
		`summons` text NOT NULL DEFAULT ''\z
	) ENGINE=InnoDB DEFAULT CHARSET=utf8")
	print("Create if not exist: myaac_news")
	db.query("CREATE TABLE IF NOT EXISTS `myaac_news` (\z
		`id` int(11) NOT NULL,\z
		`title` varchar(100) NOT NULL,\z
		`body` text NOT NULL,\z
		`type` tinyint(1) NOT NULL DEFAULT 0 COMMENT '1 - news, 2 - ticker, 3 - article',\z
		`date` int(11) NOT NULL DEFAULT 0,\z
		`category` tinyint(1) NOT NULL DEFAULT 0,\z
		`player_id` int(11) NOT NULL DEFAULT 0,\z
		`last_modified_by` int(11) NOT NULL DEFAULT 0,\z
		`last_modified_date` int(11) NOT NULL DEFAULT 0,\z
		`comments` varchar(50) NOT NULL DEFAULT '',\z
		`article_text` varchar(300) NOT NULL DEFAULT '',\z
		`article_image` varchar(100) NOT NULL DEFAULT '',\z
		`hidden` tinyint(1) NOT NULL DEFAULT 0\z
	) ENGINE=InnoDB DEFAULT CHARSET=utf8")
	print("Create if not exist: myaac_news_categories")
	db.query("CREATE TABLE IF NOT EXISTS `myaac_news_categories` (\z
		`id` int(11) NOT NULL,\z
		`name` varchar(50) NOT NULL DEFAULT '',\z
		`description` varchar(50) NOT NULL DEFAULT '',\z
		`icon_id` int(2) NOT NULL DEFAULT 0,\z
		`hidden` tinyint(1) NOT NULL DEFAULT 0\z
	) ENGINE=InnoDB DEFAULT CHARSET=utf8")
	print("Create if not exist: myaac_notepad")
	db.query("CREATE TABLE IF NOT EXISTS `myaac_notepad` (\z
		`id` int(11) NOT NULL,\z
		`account_id` int(11) NOT NULL,\z
		`content` text NOT NULL\z
	) ENGINE=InnoDB DEFAULT CHARSET=utf8")
	print("Create if not exist: myaac_pages")
	db.query("CREATE TABLE IF NOT EXISTS `myaac_pages` (\z
		`id` int(11) NOT NULL,\z
		`name` varchar(30) NOT NULL,\z
		`title` varchar(30) NOT NULL,\z
		`body` text NOT NULL,\z
		`date` int(11) NOT NULL DEFAULT 0,\z
		`player_id` int(11) NOT NULL DEFAULT 0,\z
		`php` tinyint(1) NOT NULL DEFAULT 0 COMMENT '0 - plain html, 1 - php',\z
		`enable_tinymce` tinyint(1) NOT NULL DEFAULT 1 COMMENT '1 - enabled, 0 - disabled',\z
		`access` tinyint(2) NOT NULL DEFAULT 0,\z
		`hidden` tinyint(1) NOT NULL DEFAULT 0\z
	) ENGINE=InnoDB DEFAULT CHARSET=utf8")
	print("Create if not exist: myaac_spells")
	db.query("CREATE TABLE IF NOT EXISTS `myaac_spells` (\z
		`id` int(11) NOT NULL,\z
		`spell` varchar(255) NOT NULL DEFAULT '',\z
		`name` varchar(255) NOT NULL,\z
		`words` varchar(255) NOT NULL DEFAULT '',\z
		`category` tinyint(1) NOT NULL DEFAULT 0 COMMENT '1 - attack, 2 - healing, 3 - summon, 4 - supply, 5 - support',\z
		`type` tinyint(1) NOT NULL DEFAULT 0 COMMENT '1 - instant, 2 - conjure, 3 - rune',\z
		`level` int(11) NOT NULL DEFAULT 0,\z
		`maglevel` int(11) NOT NULL DEFAULT 0,\z
		`cqclevel` int(11) NOT NULL DEFAULT 0,\z
		`distancelevel` int(11) NOT NULL DEFAULT 0,\z
		`flag_noLevelCheck` tinyint(1) NOT NULL DEFAULT 0,\z
		`flag_onlyOneRequired` tinyint(1) NOT NULL DEFAULT 0,\z
		`mana` int(11) NOT NULL DEFAULT 0,\z
		`soul` tinyint(3) NOT NULL DEFAULT 0,\z
		`conjure_id` int(11) NOT NULL DEFAULT 0,\z
		`conjure_count` tinyint(3) NOT NULL DEFAULT 0,\z
		`reagent` int(11) NOT NULL DEFAULT 0,\z
		`item_id` int(11) NOT NULL DEFAULT 0,\z
		`premium` tinyint(1) NOT NULL DEFAULT 0,\z
		`vocations` varchar(100) NOT NULL DEFAULT '',\z
		`hidden` tinyint(1) NOT NULL DEFAULT 0\z
	) ENGINE=InnoDB DEFAULT CHARSET=utf8")
	print("Create if not exist: myaac_videos")
	db.query("CREATE TABLE IF NOT EXISTS `myaac_videos` (\z
		`id` int(11) NOT NULL,\z
		`title` varchar(100) NOT NULL DEFAULT '',\z
		`youtube_id` varchar(20) NOT NULL,\z
		`author` varchar(50) NOT NULL DEFAULT '',\z
		`ordering` int(11) NOT NULL DEFAULT 0,\z
		`hidden` tinyint(1) NOT NULL DEFAULT 0\z
	) ENGINE=InnoDB DEFAULT CHARSET=utf8")
	print("Create if not exist: myaac_visitors")
	db.query("CREATE TABLE IF NOT EXISTS `myaac_visitors` (\z
		`ip` varchar(16) NOT NULL,\z
		`lastvisit` int(11) NOT NULL DEFAULT 0,\z
		`page` varchar(2048) NOT NULL\z
	) ENGINE=InnoDB DEFAULT CHARSET=utf8")
	print("Create if not exist: myaac_weapons")
	db.query("CREATE TABLE IF NOT EXISTS `myaac_weapons` (\z
		`id` int(11) NOT NULL,\z
		`level` int(11) NOT NULL DEFAULT 0,\z
		`maglevel` int(11) NOT NULL DEFAULT 0,\z
		`vocations` varchar(100) NOT NULL DEFAULT ''\z
	) ENGINE=InnoDB DEFAULT CHARSET=utf8")

	print("MyAcc - INSERT INTO")
	print("Insert: myaac_config")
	db.query("INSERT INTO `myaac_config` (`id`, `name`, `value`) VALUES\z
	(1, 'database_version', '32'),\z
	(2, 'status_online', ''),\z
	(3, 'status_players', '0'),\z
	(4, 'status_playersMax', '0'),\z
	(5, 'status_lastCheck', '1677106159'),\z
	(6, 'status_uptime', '9669'),\z
	(7, 'status_monsters', '5416'),\z
	(8, 'status_playersTotal', '0'),\z
	(9, 'status_uptimeReadable', '2h 41m'),\z
	(10, 'status_motd', 'Entering the world...'),\z
	(11, 'status_mapAuthor', 'TheMaoci'),\z
	(12, 'status_mapName', 'rookgaard'),\z
	(13, 'status_mapWidth', '2048'),\z
	(14, 'status_mapHeight', '2048'),\z
	(15, 'status_server', 'TFS'),\z
	(16, 'status_serverVersion', '1.0.0 RT'),\z
	(17, 'status_clientVersion', '10.98'),\z
	(18, 'views_counter', '5538')")
	print("Insert: myaac_forum_boards")
	db.query("INSERT INTO `myaac_forum_boards` (`id`, `name`, `description`, `ordering`, `guild`, `access`, `closed`, `hidden`) VALUES\z
	(1, 'News', 'News commenting', 0, 0, 0, 1, 0),\z
	(2, 'Trade', 'Trade offers.', 1, 0, 0, 0, 0),\z
	(3, 'Quests', 'Quest making.', 2, 0, 0, 0, 0),\z
	(4, 'Pictures', 'Your pictures.', 3, 0, 0, 0, 0),\z
	(5, 'Bug Report', 'Report bugs there.', 4, 0, 0, 0, 0)")
	print("Insert: myaac_menu")
	db.query("INSERT INTO `myaac_menu` (`id`, `template`, `name`, `link`, `blank`, `color`, `category`, `ordering`, `enabled`) VALUES\z
	(100, 'tibiacom', 'Latest News', 'news', 0, 'ffffff', 1, 0, 1),\z
	(101, 'tibiacom', 'News Archive', 'news/archive', 0, 'ffffff', 1, 1, 1),\z
	(102, 'tibiacom', 'Changelog', 'changelog', 0, 'ffffff', 1, 2, 1),\z
	(103, 'tibiacom', 'Statistics', 'server/statistics', 0, 'ffffff', 7, 0, 1),\z
	(104, 'tibiacom', 'Limitations', 'server/limits', 0, 'ffffff', 7, 1, 1),\z
	(105, 'tibiacom', 'Account Management', 'account/manage', 0, 'ffffff', 2, 0, 1),\z
	(106, 'tibiacom', 'Create Account', 'account/create', 0, 'ffffff', 2, 1, 1),\z
	(107, 'tibiacom', 'Lost Account?', 'account/lost', 0, 'ffffff', 2, 2, 1),\z
	(108, 'tibiacom', 'Downloads', 'downloads', 0, 'ffffff', 2, 3, 1),\z
	(109, 'tibiacom', 'Report Bug', 'bugtracker', 0, 'ffffff', 3, 0, 1),\z
	(110, 'tibiacom', 'Characters', 'characters', 0, 'ffffff', 3, 1, 1),\z
	(111, 'tibiacom', 'Guilds', 'guilds', 0, 'ffffff', 3, 2, 1),\z
	(112, 'tibiacom', 'Players Online', 'online', 0, 'ffffff', 3, 3, 1),\z
	(113, 'tibiacom', 'Highscores', 'highscores', 0, 'ffffff', 3, 4, 1),\z
	(114, 'tibiacom', 'Last Deaths', 'lastkills', 0, 'ffffff', 3, 5, 1),\z
	(115, 'tibiacom', 'Houses', 'houses', 0, 'ffffff', 3, 6, 1),\z
	(116, 'tibiacom', 'Bans', 'bans', 0, 'ffffff', 3, 7, 1),\z
	(117, 'tibiacom', 'Team', 'team', 0, 'ffffff', 3, 8, 1),\z
	(118, 'tibiacom', 'Monsters', 'creatures', 0, 'ffffff', 5, 0, 1),\z
	(119, 'tibiacom', 'Spells', 'spells', 0, 'ffffff', 5, 1, 1),\z
	(120, 'tibiacom', 'Gallery', 'gallery', 0, 'ffffff', 5, 2, 1),\z
	(121, 'tibiacom', 'Houses', 'houses', 0, 'ffffff', 5, 3, 1),\z
	(122, 'tibiacom', 'Quests', 'tutorial/quests', 0, 'ffffff', 8, 0, 1),\z
	(123, 'tibiacom', 'Buy Points', 'points', 0, 'ffffff', 6, 0, 1),\z
	(124, 'tibiacom', 'Shop Offer', 'gifts', 0, 'ffffff', 6, 1, 1),\z
	(125, 'tibiacom', 'Shop History', 'gifts/history', 0, 'ffffff', 6, 2, 1)")
	print("Insert: myaac_news_categories")
	db.query("INSERT INTO `myaac_news_categories` (`id`, `name`, `description`, `icon_id`, `hidden`) VALUES\z
	(1, '', '', 0, 0),\z
	(2, '', '', 1, 0),\z
	(3, '', '', 2, 0),\z
	(4, '', '', 3, 0),\z
	(5, '', '', 4, 0)")
	print("Insert: myacc_pages")
	db.query("INSERT INTO `myaac_pages` (`id`, `name`, `title`, `body`, `date`, `player_id`, `php`, `enable_tinymce`, `access`, `hidden`) VALUES\z
	(1, 'downloads', 'Downloads', '<p> </p>\r\n<p> </p>\r\n<div style=\"text-align: center;\">We\'re using custom OTClient which you can download below.</div>\r\n<div style=\"text-align: center;\"> </div>\r\n<div style=\"text-align: center;\">Version x32</div>\r\n<div style=\"text-align: center;\"><a href=\"https://retibia.app/client/PublicBuild - Retibia x86.7z\">Download Client x32</a></div>\r\n<div style=\"text-align: center;\"> </div>\r\n<div style=\"text-align: center;\"><a href=\"https://retibia.app/client/ClientEncryptedSpritesOnly.7z\">Download Client x32 Sprites Only</a>        <a href=\"https://retibia.app/client/PublicBuild - Retibia x86 - without sprites.7z\">Download Client x32 (no sprites)</a></div>\r\n<div style=\"text-align: center;\"> </div>\r\n<div style=\"text-align: center;\">Version x64</div>\r\n<div style=\"text-align: center;\">Not Available in Test phase</div>', 0, 1, 0, 1, 1, 0),\z
	(2, 'commands', 'Commands', '<table style=\"border-collapse: collapse; width: 87.8471%; height: 57px;\" border=\"1\">\n<tbody>\n<tr style=\"height: 18px;\">\n<td style=\"width: 33.3333%; background-color: #505050; height: 18px;\"><span style=\"color: #ffffff;\"><strong>Words</strong></span></td>\n<td style=\"width: 33.3333%; background-color: #505050; height: 18px;\"><span style=\"color: #ffffff;\"><strong>Description</strong></span></td>\n</tr>\n<tr style=\"height: 18px; background-color: #f1e0c6;\">\n<td style=\"width: 33.3333%; height: 18px;\"><em>!example</em></td>\n<td style=\"width: 33.3333%; height: 18px;\">This is just an example</td>\n</tr>\n<tr style=\"height: 18px; background-color: #d4c0a1;\">\n<td style=\"width: 33.3333%; height: 18px;\"><em>!buyhouse</em></td>\n<td style=\"width: 33.3333%; height: 18px;\">Buy house you are looking at</td>\n</tr>\n<tr style=\"height: 18px; background-color: #f1e0c6;\">\n<td style=\"width: 33.3333%; height: 18px;\"><em>!aol</em></td>\n<td style=\"width: 33.3333%; height: 18px;\">Buy AoL</td>\n</tr>\n</tbody>\n</table>', 0, 1, 0, 1, 1, 0),\z
	(3, 'rules_on_the_page', 'Rules', '1. Names\na) Names which contain insulting (e.g. \"Bastard\"), racist (e.g. \"Nigger\"), extremely right-wing (e.g. \"Hitler\"), sexist (e.g. \"Bitch\") or offensive (e.g. \"Copkiller\") language.\nb) Names containing parts of sentences (e.g. \"Mike returns\"), nonsensical combinations of letters (e.g. \"Fgfshdsfg\") or invalid formattings (e.g. \"Thegreatknight\").\nc) Names that obviously do not describe a person (e.g. \"Christmastree\", \"Matrix\"), names of real life celebrities (e.g. \"Britney Spears\"), names that refer to real countries (e.g. \"Swedish Druid\"), names which were created to fake other players\' identities (e.g. \"Arieswer\" instead of \"Arieswar\") or official positions (e.g. \"System Admin\").\n\n2. Cheating\na) Exploiting obvious errors of the game (\"bugs\"), for instance to duplicate items. If you find an error you must report it to CipSoft immediately.\nb) Intentional abuse of weaknesses in the gameplay, for example arranging objects or players in a way that other players cannot move them.\nc) Using tools to automatically perform or repeat certain actions without any interaction by the player (\"macros\").\nd) Manipulating the client program or using additional software to play the game.\ne) Trying to steal other players\' account data (\"hacking\").\nf) Playing on more than one account at the same time (\"multi-clienting\").\ng) Offering account data to other players or accepting other players\' account data (\"account-trading/sharing\").\n\n3. Gamemasters\na) Threatening a gamemaster because of his or her actions or position as a gamemaster.\nb) Pretending to be a gamemaster or to have influence on the decisions of a gamemaster.\nc) Intentionally giving wrong or misleading information to a gamemaster concerning his or her investigations or making false reports about rule violations.\n\n4. Player Killing\na) Excessive killing of characters who are not marked with a \"skull\" on worlds which are not PvP-enforced. Please note that killing marked characters is not a reason for a banishment.\n\nA violation of the Tibia Rules may lead to temporary banishment of characters and accounts. In severe cases removal or modification of character skills, attributes and belongings, as well as the permanent removal of accounts without any compensation may be considered. The sanction is based on the seriousness of the rule violation and the previous record of the player. It is determined by the gamemaster imposing the banishment.\n\nThese rules may be changed at any time. All changes will be announced on the official website.', 0, 1, 0, 0, 1, 0)")

	print("MyAcc - ALTER TABLE")
	-- ALTER TABLE SECTION
	db.query("ALTER TABLE `myaac_account_actions` ADD KEY `account_id` (`account_id`);")
	db.query("ALTER TABLE `myaac_admin_menu` ADD PRIMARY KEY (`id`);")
	db.query("ALTER TABLE `myaac_bugtracker` ADD PRIMARY KEY (`uid`);")
	db.query("ALTER TABLE `myaac_changelog` ADD PRIMARY KEY (`id`)")
	db.query("ALTER TABLE `myaac_config` ADD PRIMARY KEY (`id`), ADD UNIQUE KEY `name` (`name`)")
	db.query("ALTER TABLE `myaac_faq` ADD PRIMARY KEY (`id`)")
	db.query("ALTER TABLE `myaac_forum` ADD PRIMARY KEY (`id`), ADD KEY `section` (`section`)")
	db.query("ALTER TABLE `myaac_forum_boards` ADD PRIMARY KEY (`id`)")
	db.query("ALTER TABLE `myaac_gallery` ADD PRIMARY KEY (`id`)")
	db.query("ALTER TABLE `myaac_menu` ADD PRIMARY KEY (`id`)")
	db.query("ALTER TABLE `myaac_pages` ADD PRIMARY KEY (`id`)")
	db.query("ALTER TABLE `myaac_menu` MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=126")
	
	return true
end


