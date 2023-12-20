CREATE TABLE IF NOT EXISTS login(
    userid TEXT PRIMARY KEY NOT NULL,
	password TEXT NOT NULL
);

CREATE TABLE IF NOT EXISTS todo(
    todoid INT PRIMARY KEY NOT NULL,
    todoname TEXT,
    image TEXT,
    studied BOOLEAN
);
