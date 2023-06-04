# Projekt-M169
## Altes Moodle unter Port 8080 laufen lassen:
1. Bei folgender Datei den Port auf 8080 anpassen (z.B. mit sudo nano): /etc/apache2/ports.conf
2. Bei folgender Datei den Port auf 8080 anpassen: /etc/apache2/sites-enabled/000-default.conf
3. Bei folgender Datei den Port 8080 ergänzen (bei wwwroot = 'http://localhost'): /var/www/html/config.php
4. Damit die Änderungen übernommen werden, muss der Apache-Server neu gestartet werden (z.B. mit diesem Befehl: /etc/init.d/apache2 restart

## Neues Moodle in Betrieb nehmen:
1.	Folgende 4 Dateien müssen auf den (Ubuntu) Host in den Pfad /home/vmadmin/NewMoodle kopiert werden (der Ordner NewMoodle muss zuvor manuell erstellt werden):
- db_password.txt
- docker-compose.yml
- Dump.sh
- script.sh

***Hinweis: Da die Dateien von Windows zu Ubuntu kopiert werden, können Probleme beim Ausführen der Datei «script.sh» auftreten. Dies kann man umgehen, wenn man den Inhalt der script.sh-Datei kopiert. Dann eine neue Datei erstellt und dort den Inhalt einfügt. Wichtig ist, dass die neue Datei denselben Namen hat und sich im gleichen Pfad wie die anderen Dateien befindet.***
2.	Wenn diese kopiert wurden, müssen die Berechtigungen so angepasst werden, dass alle Dateien ausgeführt werden können. Wir sind darum im Terminal in den Ordner gewechselt werden, in welchen die Dateien kopiert wurden. Danach kann man mit folgendem Befehl allen Dateien (in diesem Ordner) volle Berechtigungen geben: chmod 777 *.* 
3.	Damit man Dockercompose verwenden kann, muss es zuerst installiert werden. Wir haben dafür diesen Befehl im Terminal ausgeführt: sudo apt install docker-compose
4.	Sobald Docker-Compose installiert ist, kann das script.sh mit dem Befehl ./script.sh ausgeführt werden.
5.	Während dem Ausführen des Scripts werden zwei Passwörter abgefragt. Die Passwörter lauten:
- Docker-DB: Secret
- Lokale-DB: Riethuesli>12345
6.	Es kann sein, dass das Script manchmal für ein paar Minuten stehen bleibt. Dies ist aber normal, da das Script manchmal automatisch pausiert wird, bis z.B. die Moodle-Datenbank eingefügt wird.
7.	Anweisungen des Scripts befolgen. Man wird aufgefordert, den Browser zu öffnen, um dort die Moodle Datenbank zu updaten:
8.	Moodle über Port 80 öffnen (http://localhost:80)
9.	Mit «Continue» fortfahren.
10.	Danach ganz nach unten scrollen und wieder auf «Continue» drücken:
11.	Im nächsten Fenster wieder ganz nach unten scrollen und mit «Upgrade Moodle database now» fortfahren. (Dieser Schritt kann einige Minuten in Anspruch nehmen)
12.	Sobald unten die Schaltfläche «Continue» erscheint, kann wieder fortgefahren werden:
13.	Danach öffnet sich ein Anmeldefenster. Dort kann man sich mit dem Benutzernamen (vmadmin) und dem Passwort (Riethuesli>12345) anmelden:
14.	Sobald man sich angemeldet hat, muss man neue Einstellungen bestätigen. Für diesen Schritt kann man auf der Seite ganz nach unten Scrollen und «Save changes» drücken.
15.	Auf der nächsten Seite muss man eine E-Mail-Adresse für den Support des Moodles eingeben und mit «save changes» bestätigen. 
16.	Nun ist das Update abgeschlossen
17.	Danach kann man wieder zum Terminal wechseln und das Script fortsetzen, indem man die Enter-Taste drückt. 
18.	Sobald man die Enter-Taste gedrückt hat, dauert es wenige Sekunden, bis das Script abgeschlossen ist. 
19.	Man kann das Moodle über http://localhost:80 erreichen.
20.	Demo Moodle erreichbar auf Port 80

***HINWEIS: Eine detailliertere Anleitung befindet sich in unsere Dokumentation (M169_Realisierung_ABS.docx)***
