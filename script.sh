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

# Dump in den MySQL-Container laden
docker cp /home/vmadmin/dump4-1-2.sql vmadmin_db_1:/var/lib/mysql

sleep 10

docker exec -i vmadmin_db_1 bash -c "mysql -u root --password=$password -e 'DROP DATABASE moodle; CREATE DATABASE moodle;'"

# In den MySQL-Container wechseln und den Dump importieren
docker exec -i vmadmin_db_1 mysql -u root --password=$password moodle < ./dump4-1-2.sql

# Aufräumen: Lokalen Dump entfernen
rm dump4-1-2.sql
