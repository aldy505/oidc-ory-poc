CREATE USER ory_kratos WITH PASSWORD 'ory_kratos';

CREATE DATABASE ory_kratos WITH OWNER = 'ory_kratos';

GRANT ALL ON DATABASE ory_kratos TO ory_kratos;

CREATE USER ory_hydra WITH PASSWORD 'ory_hydra';

CREATE DATABASE ory_hydra WITH OWNER = 'ory_hydra';

GRANT ALL ON DATABASE ory_hydra TO ory_hydra;