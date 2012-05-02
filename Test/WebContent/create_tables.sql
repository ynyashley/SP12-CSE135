CREATE TABLE countries (
    c_id          SERIAL PRIMARY KEY,
    country  TEXT
);

CREATE TABLE majors (
    m_id          SERIAL PRIMARY KEY,
    major  TEXT
);

CREATE TABLE specializations (
    s_id          SERIAL PRIMARY KEY,
    specialization  TEXT
);

CREATE TABLE universities (
    u_id          SERIAL PRIMARY KEY,
    country_state TEXT,
    university  TEXT	
);