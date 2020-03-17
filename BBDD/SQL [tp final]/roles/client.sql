/*
=============================================================================================================================
role: client
=============================================================================================================================
*/

CREATE ROLE client WITH NOINHERIT LOGIN REPLICATION ENCRYPTED PASSWORD 'client';
GRANT SELECT, INSERT, UPDATE, DELETE ON TABLE apikey, finaluser, client TO client;
GRANT SELECT, INSERT, UPDATE ON TABLE queryhistory TO client;
GRANT SELECT ON TABLE plan TO client;