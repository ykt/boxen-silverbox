class people::ykt::dev::mysql {
	include mysql

	mysql::db { 'mydb': }
}