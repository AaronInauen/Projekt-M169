# Projekt-M169
## Altes Moodle unter Port 8080 laufen lassen:
1. Bei folgender Datei den Port auf 8080 anpassen: /etc/apache2/ports.conf
2. Bei folgender Datei den Port auf 8080 anpassen: /etc/apache2/sites-enabled/000-default.conf
3. Bei folgender Datei den Port 8080 ergänzen (bei wwwroot = 'http://localhost'): /var/www/html/config.php

## Neues Moodle in Betrieb nehmen:
1. Folgende Dateien in einen Ordner (z.B. /home/vmadmin/) auf dem (Ubuntu) Host kopieren:
    - db_password.txt
    - docker-compose.yml
    - Dump.sh
    - script.sh
2. Danach die Datei "script.sh" mit folgendem Befehl im Terminal ausführen: sudo ./sript.sh
3. Es dauert ca. 6-7min bis das Script fertig ausgeführt ist. 
4. Das Moodle ist nun unter http://localhost:80 erreichbar.

***HINWEIS: Eine detailliertere Anleitung befindet sich in unsere Dokumentation (M169_Realisierung_ABS.docx)***
