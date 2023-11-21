USE Clickship;

DECLARE @img_data VARBINARY(MAX);
SET @img_data = (SELECT BulkColumn FROM OPENROWSET(BULK 'C:\Users\Luis\Downloads\gs7.png', SINGLE_BLOB) AS x)
EXEC Clickship_postProductImage 1, @img_data


--DECLARE @img_data VARBINARY(MAX);
SET @img_data = (SELECT BulkColumn FROM OPENROWSET(BULK 'C:\Users\Luis\Downloads\gs72.jpg', SINGLE_BLOB) AS x)
EXEC Clickship_postProductImage 1, @img_data

SELECT * FROM FotosXProductos;
SELECT * FROM DefaultFotosXProductos;