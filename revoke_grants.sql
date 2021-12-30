DO $do$
DECLARE
    sch text;
BEGIN
    FOR sch IN SELECT nspname FROM pg_namespace
    LOOP
        EXECUTE format($$ REVOKE ALL PRIVILEGES ON ALL TABLES IN SCHEMA %I FROM "user" $$, sch);
	      EXECUTE format($$ REVOKE ALL PRIVILEGES ON ALL SEQUENCES IN SCHEMA %I FROM "user" $$, sch);
	      EXECUTE format($$ REVOKE ALL PRIVILEGES ON ALL FUNCTIONS IN SCHEMA %I FROM "user" $$, sch);
        EXECUTE format($$ REVOKE ALL PRIVILEGES ON SCHEMA %I FROM "user" $$, sch);
        EXECUTE format($$ ALTER DEFAULT PRIVILEGES IN SCHEMA %I REVOKE ALL ON SEQUENCES FROM "user" $$, sch);
        EXECUTE format($$ ALTER DEFAULT PRIVILEGES IN SCHEMA %I REVOKE ALL ON TABLES FROM "user" $$, sch);
        EXECUTE format($$ ALTER DEFAULT PRIVILEGES IN SCHEMA %I REVOKE ALL ON FUNCTIONS FROM "user" $$, sch);
        EXECUTE format($$ REVOKE USAGE ON SCHEMA %I FROM "user" $$, sch);
        EXECUTE format($$ REASSIGN OWNED BY user TO postgres $$, sch);
    END LOOP;
END;
$do$;
