#!/bin/bash 
# Script zur automatischen erzeugung von SQLdumps mit automatischer Benennung der Datei
# Datenbankzugangsdaten 
MYSQL_USER="root" 
MYSQL_PASSWORD="Secret" 
MYSQL_DATABASE="moodle" 
# Verzeichnis, in dem die Sicherungsdatei gespeichert wird 
BACKUP_DIR="var/lib/mysql" 
# Dateinamen für die Sicherungsdatei 
BACKUP_FILENAME="$MYSQL_DATABASE-$(date +%Y-%m-%d_%H-%M-%S)-UTC.sql" 
# MySQL-Dump-Befehl 
mysqldump -u $MYSQL_USER -p$MYSQL_PASSWORD $MYSQL_DATABASE > $BACKUP_DIR/$BACKUP_FILENAME 
# Erfolgsmeldung 
echo "MySQL-Dump erfolgreich erstellt: $BACKUP_FILENAME"
