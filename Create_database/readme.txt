Title: IMDb Database Setup Instructions

Description: This README provides detailed instructions on how to set up and populate the IMDb database using PostgreSQL. The instructions include steps to create the database schema and load data from provided TSV files.

Requirements

 - PostgreSQL 12 or higher
 - Access to a Unix-like terminal (Linux, Mac OS, or Windows Subsystem for Linux)
 - gzip to decompress data files, if compressed


File List

 - create.sql - SQL script to create the database schema.
 - load.sql - SQL script to load data into the database from TSV files.
 - TSV data files (ensure these are decompressed if downloaded as .gz):

 basics_imdb.tsv
 names_imdb.tsv
 akas_imdb.tsv
 directors_imdb.tsv
 episode_imdb.tsv
 genres_imdb.tsv
 knownfortitles_imdb.tsv
 primaryprofession_imdb.tsv
 principals_imdb.tsv
 ratings_imdb.tsv
 writers_imdb.tsv

Step 1: Database and User Setup
 - Create PostgreSQL User (if required)

   sudo -u postgres createuser --interactive


 - Create Database

   sudo -u postgres createdb -O [username] imdb_db
   Replace [username] with the name of the new or existing database user.

Step 2: Create Database Schema

   Navigate to the directory containing create.sql
   cd path/to/sql_files

   Run the SQL Script
   psql -U username -d imdb_db -f create.sql
   Replace username with your PostgreSQL user.

Step 3: Loading Data

   Navigate to the directory containing load.sql
   cd path/to/sql_files

   Edit load.sql to correct paths to TSV files
   Open load.sql in a text editor.
   Ensure that paths to TSV files are absolute or correctly relative to the current directory.

   Run the Load Script
   psql -U username -d imdb_db -f load.sql
   Ensure that all paths in load.sql are correct as per your system setup.

Step 4: Verify Data Integrity

   Check Table Counts
   psql -U username -d imdb_db -c "SELECT COUNT(*) FROM basics_imdb;"
   Repeat for other tables to ensure data is loaded.


Issues:

 - Permission Issues: Make sure the PostgreSQL user has the right permissions.
 - Data Format Errors: Check the TSV files for any formatting inconsistencies especially if COPY fails.

