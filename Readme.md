Pour lancer ce serveur il vous faut juste des artifacts, crée une base de donner ainsi qu'un fichier nommé :

server_private.cfg 

contenant :

## You CAN edit the following:
sv_enforceGameBuild 3258 #mp2024_01	- Bottom Dollar Bounties
sv_licenseKey ""
sv_maxclients 48
endpoint_add_tcp "0.0.0.0:30120"
endpoint_add_udp "0.0.0.0:30120"
set steam_webApiKey "none"
set resources_useSystemChat true

## Add system admins
add_ace group.admin command allow # allow all commands
add_ace group.admin command.quit deny # but don't allow quit
add_principal identifier.fivem: group.admin #fivem:VotreID
add_principal identifier.discord: group.admin # discord:VotreID

et mysql_connection_string "user=root;password=12345;host=localhost;port=3306;database=fivem"