hugo
#lftp ftp://149.202.147.247 -u fotographic@fotographicparets.com,f3VWh$JMgU7Y -e "set ftp:ssl-allow false; set ftp:use-feat false;mirror --parallel=3 --delete --verbose -R /Users/abibiano/sites/fotographicparets/public /; bye"
lftp -e 'set ftp:ssl-allow false; set ftp:use-feat false; set ftp:passive-mode off; open ftp://149.202.147.247 -u fotographic@fotographicparets.com,f3VWh$JMgU7Y; mirror --parallel=3 --delete --verbose -R /Users/abibiano/projects/private/web/afparets_web_fotographicparets/public /; quit'
