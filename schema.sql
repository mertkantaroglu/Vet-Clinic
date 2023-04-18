CREATE TABLE animals (
  id SERIAL PRIMARY KEY,
  name VARCHAR(100),
  date_of_birth DATE,
  escape_attempts INTEGER,
  neutered BOOLEAN,
  weight_kg DECIMAL(5,2),
  species_id INTEGER REFERENCES species(id),
  owner_id INTEGER REFERENCES owners(id)
  );

CREATE TABLE owners (
  id SERIAL PRIMARY KEY,
  full_name VARCHAR(255),
  age INTEGER,
);

CREATE TABLE species (
  id SERIAL PRIMARY KEY,
  name VARCHAR(255)
);

CREATE TABLE vets (
  id SERIAL PRIMARY KEY,
  name VARCHAR(255),
  age INTEGER,
  date_of_graduation DATE
);

CREATE TABLE specializations (
  vet_id INTEGER REFERENCES vets(id),
  species_id INTEGER REFERENCES species(id),
  PRIMARY KEY (vet_id, species_id)
);

CREATE TABLE visits (
  id SERIAL PRIMARY KEY,
  animal_id INTEGER REFERENCES animals(id),
  vet_id INTEGER REFERENCES vets(id),
  visit_date DATE
);

-- Add Email column to Owners table
ALTER TABLE owners ADD COLUMN email VARCHAR(120);

-- Decrease the execution time for animal_id query
CREATE INDEX animal_index ON visits(animal_id);

  -- Check the execution time
explain analyze SELECT COUNT(*) FROM visits where animal_id = 4;

-- Decrease the execution time for vet_id query
CREATE INDEX vet_id_index ON visits(vet_id)
INCLUDE (id, animal_id, visit_date)
WHERE vet_id=2;

  -- Check the execution time
explain analyze SELECT * FROM visits where vet_id = 2;