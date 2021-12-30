# revoke_grants.sql
A  script for Postgres which will allow you to revoke all grants from a user (for all objects)
before deleting a user

After executing it, do:

drop owned by user;
DROP USER user;
