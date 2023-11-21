INSERT INTO Inventarios (ubicacion, nombre, abreviacion) VALUES
(geography::STGeomFromText('POINT(-122.3931395250385 37.636785793009594)', 4326), 'Inventario Norte', 'NOR'),
(geography::STGeomFromText('POINT(-69.91402827220752 18.481362525365764)', 4326), 'Inventario Caribe', 'CAR'),
(geography::STGeomFromText('POINT(-58.605947809321 -34.70754821386317)', 4326), 'Inventario Sur', 'SUR');

SELECT * FROM Inventarios;