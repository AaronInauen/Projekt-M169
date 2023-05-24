#!/bin/bash

# Docker Compose ausführen
docker-compose up -d

# Warten, bis die Container gestartet sind
sleep 10

# MySQL-Dump erstellen
sudo mysqldump --password='Riethuesli>12345' moodle > dump.sql

# Dump in den MySQL-Container laden
docker cp /home/vmadmin/dump4-2.sql vmadmin_db_1:/var/lib/mysql

sleep 300

docker exec -i vmadmin_db_1 -c "mysql -u root --password=root -e 'DROP DATABASE moodle; CREATE DATABASE moodle;'"

# In den MySQL-Container wechseln und den Dump importieren
docker exec -i vmadmin_db_1 -u root --password=root moodle < ./dump.sql

# Aufräumen: Lokalen Dump entfernen
rm dump.sql
