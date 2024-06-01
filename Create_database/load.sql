-- Load data into the 'basics_imdb' table
\COPY public.basics_imdb(tconst, titletype, primarytitle, originaltitle, isadult, startyear, endyear, runtimeminutes)
FROM 'C:\Users\admin\Desktop\saimural_lalla_vjampala_phase_2\Create_and_Load_Database\Data\basics_imdb.tsv'
WITH (FORMAT csv, DELIMITER E'\t', HEADER true, NULL 'NULL');

-- Load data into the 'names_imdb' table
\COPY public.names_imdb(nconst, primaryname, birthyear, deathyear)
FROM 'C:\Users\admin\Desktop\saimural_lalla_vjampala_phase_2\Create_and_Load_Database\Data\names_imdb.tsv'
WITH (FORMAT csv, DELIMITER E'\t', HEADER true, NULL 'NULL');

-- Load data into the 'akas_imdb' table
\COPY public.akas_imdb(titleid, ordering, title, region, language, type, attribute, isoriginaltitle)
FROM 'C:\Users\admin\Desktop\saimural_lalla_vjampala_phase_2\Create_and_Load_Database\Data\akas_imdb.tsv'
WITH (FORMAT csv, DELIMITER E'\t', HEADER true, NULL 'NULL');

-- Load data into the 'directors_imdb' table
\COPY public.directors_imdb(tconst, nconst)
FROM 'C:\Users\admin\Desktop\saimural_lalla_vjampala_phase_2\Create_and_Load_Database\Data\directors_imdb.tsv'
WITH (FORMAT csv, DELIMITER E'\t', HEADER true, NULL 'NULL');

-- Load data into the 'episode_imdb' table
\COPY public.episode_imdb(tconst, parenttconst, seasonnumber, episodenumber)
FROM 'C:\Users\admin\Desktop\saimural_lalla_vjampala_phase_2\Create_and_Load_Database\Data\episode_imdb.tsv'
WITH (FORMAT csv, DELIMITER E'\t', HEADER true, NULL 'NULL');

-- Load data into the 'genres_imdb' table
\COPY public.genres_imdb(tconst, genre)
FROM 'C:\Users\admin\Desktop\saimural_lalla_vjampala_phase_2\Create_and_Load_Database\Data\genres_imdb.tsv'
WITH (FORMAT csv, DELIMITER E'\t', HEADER true, NULL 'NULL');

-- Load data into the 'knownfortitles_imdb' table
\COPY public.knownfortitles_imdb(nconst, knownfortitle)
FROM 'C:\Users\admin\Desktop\saimural_lalla_vjampala_phase_2\Create_and_Load_Database\Data\knownfortitles_imdb.tsv'
WITH (FORMAT csv, DELIMITER E'\t', HEADER true, NULL 'NULL');

-- Load data into the 'primaryprofession_imdb' table
\COPY public.primaryprofession_imdb(nconst, primaryprofession)
FROM 'C:\Users\admin\Desktop\saimural_lalla_vjampala_phase_2\Create_and_Load_Database\Data\primaryprofession_imdb.tsv'
WITH (FORMAT csv, DELIMITER E'\t', HEADER true, NULL 'NULL');

-- Load data into the 'principals_imdb' table
\COPY public.principals_imdb(tconst, ordering, nconst, category, job, characters)
FROM 'C:\Users\admin\Desktop\saimural_lalla_vjampala_phase_2\Create_and_Load_Database\Data\principals_imdb.tsv'
WITH (FORMAT csv, DELIMITER E'\t', HEADER true, NULL 'NULL');

-- Load data into the 'ratings_imdb' table
\COPY public.ratings_imdb(tconst, averagerating, numvotes)
FROM 'C:\Users\admin\Desktop\saimural_lalla_vjampala_phase_2\Create_and_Load_Database\Data\ratings_imdb.tsv'
WITH (FORMAT csv, DELIMITER E'\t', HEADER true, NULL 'NULL');

-- Load data into the 'writers_imdb' table
\COPY public.writers_imdb(tconst, nconst)
FROM 'C:\Users\admin\Desktop\saimural_lalla_vjampala_phase_2\Create_and_Load_Database\Data\writers_imdb.tsv'
WITH (FORMAT csv, DELIMITER E'\t', HEADER true, NULL 'NULL');