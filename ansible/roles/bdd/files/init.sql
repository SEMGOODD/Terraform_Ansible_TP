CREATE TABLE IF NOT EXISTS ayoub (
    id SERIAL PRIMARY KEY,
    name VARCHAR(50) NOT NULL
);

INSERT INTO ayoub (name) VALUES ('Ayoub');
ALTER TABLE ayoub OWNER TO cytech_usr;