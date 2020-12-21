# intermedial-comparison
## Requirements / Developed on
* PHP 7.4.11 (req, dev)
* Composer 2.0.7 (req, dev)
* mysql 8.0.19 (req, dev)
* macOS 11.0.1 (dev)
## Installation
### Application
#### 1st-way
* unpack "ict_eschweiler_full"
* cd /src/public
* php -S localhost:8000
* run on Browser (Chrome, Firefox, Safari) via "localhost:8000" 
#### 2nd-way
* unpack "ict_eschweiler_composer"
* ROOT-DIRECTORY of Project ->  "php composer.phar install"
* cd /src/public
* php -S localhost:8000 
* run on Browser (Chrome, Firefox, Safari) via "localhost:8000"
### Database
#### Statements
* "CREATE DATABASE ict;"
* "CREATE USER 'ict'@'localhost' IDENTIFIED BY 'ict';
* "GRANT ALL PRIVILEGES ON ict.* TO 'ict'@'localhost'"
* "FLUSH PRIVILEGES;"
#### Import
* import ict.sql to ict-database from terminal from root directory of project
* "mysql -u ict -p ict < ict.sql"
### Using
* browse on left side the pages as transcriptions or faksimile
* browse on right side to get the Chunkviewer
## Notes
* all faksimile are from copyright-free Bilderberg (University of Cologne)
* chunks and other markups are not always accurate and serve the purpose of showcase

