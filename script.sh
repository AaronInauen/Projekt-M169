#!/bin/bash

# Passwörter einlesen
read -p "Bitte geben Sie das Passwort für die Docker-DB ein: " password
read -p "Bitte geben Sie das Passwort für die lokale-DB ein: " password2

# Docker Compose ausführen
docker-compose up -d

# Warten, bis die Container gestartet sind
sleep 200

# MySQL-Dump erstellen
sudo mysqldump --password=$password2 moodle > dump4-1-2.sql

sleep 30

# Dump in den MySQL-Container laden
sudo docker cp /home/vmadmin/NewMoodle/dump4-1-2.sql newmoodle_db_1:/var/lib/mysql


sleep 10

# Bestehende Moodle DB wird gelöscht und wieder erstellt
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

# Es wird gesagt was gemacht werden muss
echo "Öffnen Sie http://localhost:80 in ihrem Browser und führen Sie das Datenbankupgrade aus."

# Ausgabe einer Nachricht
echo "Das Skript wird pausiert. Drücken Sie Enter, um fortzufahren."

# Warten auf Benutzereingabe
read

# Fortsetzung des Skripts
echo "Fortsetzung des Skripts..."

# Moodle-Daten in Container verschieben
sudo cp -r /var/www/moodledata/* /var/lib/docker/volumes/newmoodle_moodledata/_data

