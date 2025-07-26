class LocalDbTables {
  static const String createMenuTable = '''
    CREATE TABLE menu (
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      name TEXT NOT NULL,
      price REAL NOT NULL,
      cost REAL NOT NULL,
      imagePath TEXT
    );
  ''';

  static const String createPanierTable = '''
    CREATE TABLE panier (
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      total_price REAL NOT NULL,
      total_cost REAL NOT NULL,
      created_at TEXT NOT NULL
    );
  ''';

  static const String createPanierItemTable = '''
    CREATE TABLE panier_items (
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      panier_id INTEGER NOT NULL,
      name TEXT NOT NULL,
      price REAL NOT NULL,
      cost REAL NOT NULL,
      imagePath TEXT,
      quantity INTEGER NOT NULL,
      FOREIGN KEY(panier_id) REFERENCES panier(id)
    );
  ''';
}
