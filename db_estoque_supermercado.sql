-- Tabela Endereço
CREATE TABLE IF NOT EXISTS addresses(
	address_id INT AUTO_INCREMENT,
	street VARCHAR(255) NOT NULL,
	number INT NOT NULL,
	additional_information VARCHAR(255),
	district VARCHAR(100) NOT NULL,
	cep VARCHAR(10) NOT NULL,
	city VARCHAR(100) NOT NULL,
	PRIMARY KEY(address_id)
);

-- Tabela Pessoas
CREATE TABLE IF NOT EXISTS people(
	person_id INT AUTO_INCREMENT,
	name VARCHAR(255) NOT NULL,
	cpf CHAR(11) NOT NULL UNIQUE,
	phone VARCHAR(15) NOT NULL,
	address_id INT,
	FOREIGN KEY(address_id) REFERENCES addresses(address_id),
	PRIMARY KEY(person_id)
);

-- Tabela Cliente
CREATE TABLE IF NOT EXISTS clients(
	client_id INT AUTO_INCREMENT,
	person_id INT,
  	FOREIGN KEY(person_id) REFERENCES people(person_id),
	PRIMARY KEY(client_id)
);

-- Tabela Funcionário
CREATE TABLE IF NOT EXISTS employees(
	employee_id INT AUTO_INCREMENT,
	job_position VARCHAR(100) NOT NULL,
	person_id INT,
    FOREIGN KEY(person_id) REFERENCES people(person_id),
	PRIMARY KEY(employee_id)
);

-- Tabela Fornecedor
CREATE TABLE IF NOT EXISTS suppliers(
	supplier_id INT AUTO_INCREMENT,
	cnpj CHAR(14) NOT NULL UNIQUE,
	email VARCHAR(255) NOT NULL,
	company_name VARCHAR(255) NOT NULL,
	street VARCHAR(255) NOT NULL,
	number INT NOT NULL,
	additional_information VARCHAR(255),
	district VARCHAR(100) NOT NULL,
	cep VARCHAR(10) NOT NULL,
	city VARCHAR(100) NOT NULL,
	PRIMARY KEY(supplier_id)
);

-- Tabela Produtos
CREATE TABLE IF NOT EXISTS products(
	product_id INT AUTO_INCREMENT,
	name VARCHAR(255) NOT NULL,
	category VARCHAR(100) NOT NULL,
	cost DECIMAL(10, 2) NOT NULL,
	price DECIMAL(10, 2) NOT NULL,
	manufacturer VARCHAR(255) NOT NULL,
	production_date DATE NOT NULL,
	expiry_date DATE,
	measurement_unit VARCHAR(50) NOT NULL,
	minimum_stock INT NOT NULL,
	maximum_stock INT NOT NULL,
	current_stock INT NOT NULL,
	aisle VARCHAR(10),
	shelf VARCHAR(10),
	PRIMARY KEY(product_id)
);

-- Tabela do relacionamento N/N Fornecedor Produto
CREATE TABLE IF NOT EXISTS suppliers_products(
	supplier_id INT,
	product_id INT,
	FOREIGN KEY(supplier_id) REFERENCES suppliers(supplier_id),
    FOREIGN KEY(product_id) REFERENCES products(product_id),
    PRIMARY KEY(supplier_id, product_id)
);

-- Tabela Pedidos_Clientes = Pedido_Venda (DER)
CREATE TABLE IF NOT EXISTS customers_orders(
	customer_order_id INT AUTO_INCREMENT,
	date DATE NOT NULL,
	time TIME NOT NULL,
	quantity INT NOT NULL,
	client_id INT,
	employee_id INT,
	product_id INT,
	FOREIGN KEY(client_id) REFERENCES clients(client_id),
    FOREIGN KEY(employee_id) REFERENCES employees(employee_id),
    FOREIGN KEY(product_id) REFERENCES products(product_id),
    PRIMARY KEY(customer_order_id)
);

-- Tabela Solicitação_compra
CREATE TABLE IF NOT EXISTS purchase_orders(
	purchase_order_id INT AUTO_INCREMENT,
	date DATE NOT NULL,
	time TIME NOT NULL,
	quantity INT NOT NULL,
	observations TEXT,
	employee_id INT,
	product_id INT,
	supplier_id INT,
	FOREIGN KEY(employee_id) REFERENCES employees(employee_id),
    FOREIGN KEY(product_id) REFERENCES products(product_id),
    FOREIGN KEY(supplier_id) REFERENCES suppliers(supplier_id),
    PRIMARY KEY(purchase_order_id)
);

-- Tabela Produtos_recebidos = Recebimento_Produto (DER)
CREATE TABLE IF NOT EXISTS products_received(
	receiving_id INT AUTO_INCREMENT,
	date DATE NOT NULL,
	time TIME NOT NULL,
	quantity INT NOT NULL,
	observations TEXT,
	purchase_order_id INT,
    FOREIGN KEY(purchase_order_id) REFERENCES purchase_orders(purchase_order_id),
    PRIMARY KEY(receiving_id)
);