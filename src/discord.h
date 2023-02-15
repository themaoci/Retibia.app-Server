//created by TheMaoci

#ifndef FS_DISCORD_H_1
#define FS_DISCORD_H_1
#include "../include/dpp/dpp.h"

class Discord {
public:
	Discord();
	~Discord();

	Discord(const Discord&) = delete;
	Discord& operator=(const Discord&) = delete;

	int post(const std::string& url, const std::string& data);
	int webhook(const std::string& wh_url, const std::string& text);

};

#endif
