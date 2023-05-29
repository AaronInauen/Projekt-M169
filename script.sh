#!/bin/bash

# Passwörter einlesen
read -p "Bitte geben Sie das Passwort für die Docker-DB ein: " password
read -p "Bitte geben Sie das Passwort für die lokale-DB ein: " password2

# Docker Compose ausführen
docker-compose up -d

# Warten, bis die Container gestartet sind
sleep 300

# MySQL-Dump erstellen
sudo mysqldump --password=$password2 moodle > dump4-1-2.sql

sleep 30

# Dump in den MySQL-Container laden
docker cp /home/vmadmin/NewMoodle/dump4-1-2.sql newmoodle_db_1:/var/lib/mysql

sleep 10

docker exec -i newmoodle_db_1 bash -c "mysql -u root --password=$password -e 'DROP DATABASE moodle; CREATE DATABASE moodle;'"

# In den MySQL-Container wechseln und den Dump importieren
docker exec -i newmoodle_db_1 mysql -u root --password=$password moodle < ./dump4-1-2.sql

# Aufräumen: Lokalen Dump entfernen
rm dump4-1-2.sql

# Cronjobskript einfügen und Rechte anpassen
sudo docker cp /home/vmadmin/NewMoodle/Dump.sh newmoodle_db_1:/var/lib/mysql/
docker exec newmoodle_db_1 chmod 760 /var/lib/mysql/Dump.sh

# Cronjob erstellen
sudo su <<suON
echo "0 22 * * * docker exec newmoodle_db_1 /var/lib/mysql/Dump.sh" &>>/var/spool/cron/crontabs/root
suON
