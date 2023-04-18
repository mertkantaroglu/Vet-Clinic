CREATE TABLE patients (
  id SERIAL PRIMARY KEY,
  name VARCHAR(255),
  date_of_birth DATE
);

CREATE TABLE medical_histories (
  id SERIAL PRIMARY KEY,
  admitted_at timestamp,
  patient_id INT REFERENCES patients(id),
  status VARCHAR(50)
);

CREATE TABLE invoices (
  id SERIAL PRIMARY KEY,
  total_amount DECIMAL,
  generated_at timestamp,
  payed_at timestamp,
  medical_history_id INT REFERENCES medical_histories(id)
);

CREATE TABLE treatments (
  id SERIAL PRIMARY KEY,
  type VARCHAR(50),
  name VARCHAR(255),
);

CREATE TABLE invoice_items (
  id SERIAL PRIMARY KEY,
  unit_price DECIMAL,
  quantity INT,
  total_price DECIMAL,
  invoice_id INT REFERENCES invoices(id),
  treatment_id INT REFERENCES treatments(id)
);

CREATE TABLE medical_histories_treatments (
  id SERIAL PRIMARY KEY,
  medical_history_id INT NOT NULL,
  treatment_id INT NOT NULL,
  CONSTRAINT fk_medical_histories_treatments_medical_histories
    FOREIGN KEY (medical_history_id) REFERENCES medical_histories(id),
  CONSTRAINT fk_medical_histories_treatments_treatments
    FOREIGN KEY (treatment_id) REFERENCES treatments(id)
);

CREATE INDEX patient_index ON medical_histories(patient_id);
CREATE INDEX treatment_index ON invoice_items(treatment_id);
CREATE INDEX medical_history_index ON invoices(medical_history_id);
CREATE INDEX invoice_index ON invoice_items(invoice_id);
CREATE INDEX medical_histories_treatments_medical_history_id_index ON medical_histories_treatments (medical_history_id);
CREATE INDEX medical_histories_treatments_treatment_id_index ON medical_histories_treatments (treatment_id);
