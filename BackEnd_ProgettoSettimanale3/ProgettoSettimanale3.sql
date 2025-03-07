CREATE DATABASE Progetto3_Backend3;

USE Progetto3_Backend3;

--Creo la tabella Anagrafiche
CREATE TABLE Anagrafiche (
	IdAnagrafica UNIQUEIDENTIFIER PRIMARY KEY,
	Cognome NVARCHAR(100) NOT NULL,
	Nome NVARCHAR(100) NOT NULL,
	Indirizzo NVARCHAR(100) NOT NULL,
	Citta NVARCHAR(100) NOT NULL,
	CAP INT NOT NULL,
	CodiceFiscale NVARCHAR(16) NOT NULL,
	CONSTRAINT CK_CodiceFiscale CHECK (LEN(CodiceFiscale) = 16)
);

--Creo la tabella Dei tipi di violazione
CREATE TABLE [Tipi Violazione] (
	IdViolazione UNIQUEIDENTIFIER PRIMARY KEY,
	Descrizione NVARCHAR(1000) NOT NULL,
);

-- Creo la tabella dei verbali. Contiene una chiave primaria composta e le chiavi esterne collegate alle altre due tabelle
-- La chiave primaria composta sostituisce la tabella di associazione. Ho creato questa chiave perchè ad ogni verbale possono corrispondere più violazioni e una violazione può appartenere a più verbali.
-- Quindi si tratta di un MOLTI a MOLTI.
CREATE TABLE Verbali (
	IdVerbale int NOT NULL,
	DataViolazione DATETIME NOT NULL,
	IndirizzoViolazione NVARCHAR(100) NOT NULL,
	NominativoAgente NVARCHAR(100) NOT NULL,
	DataTrascrizioneVerbale DATETIME NOT NULL,
	Importo DECIMAL(7,2) NOT NULL,
	DecurtamentoPunti INT,
	IdAnagrafica UNIQUEIDENTIFIER,
	IdViolazione UNIQUEIDENTIFIER,
	CONSTRAINT CK_Importo CHECK (Importo > 0),
	CONSTRAINT PK_IdVerbaliComposto PRIMARY KEY (IdVerbale, IdAnagrafica, IdViolazione),
	CONSTRAINT FK_Verbale_Anagrafica FOREIGN KEY (IdAnagrafica) REFERENCES Anagrafiche(IdAnagrafica),
	CONSTRAINT FK_Verbale_Violazione FOREIGN KEY (IdViolazione) REFERENCES [Tipi Violazione](IdViolazione),
);

-- Inserisco i record nella tabella Anagrafiche
INSERT INTO Anagrafiche (IdAnagrafica, Cognome, Nome, Indirizzo, Citta, CAP, CodiceFiscale) VALUES
(NEWID(), 'Rossi', 'Mario', 'Via Roma 1', 'Palermo', 90100, 'RSSMRA70A01H501Z'),
(NEWID(), 'Bianchi', 'Luigi', 'Via Milano 2', 'Milano', 20100, 'BNCGLG80B01F205X'),
(NEWID(), 'Verdi', 'Anna', 'Via Napoli 3', 'Napoli', 80100, 'VRDANN85C41I912Y'),
(NEWID(), 'Neri', 'Chiara', 'Via Torino 4', 'Torino', 10100, 'NRCCHR75D01L219Z'),
(NEWID(), 'Russo', 'Giorgio', 'Via Firenze 5', 'Firenze', 50100, 'RSSGRG90E01G702X'),
(NEWID(), 'Gialli', 'Paolo', 'Via Venezia 6', 'Venezia', 30100, 'GLLPLA85A01H501A'),
(NEWID(), 'Blu', 'Sara', 'Via Genova 7', 'Palermo', 16100, 'BLUSRA70B01H501B'),
(NEWID(), 'Viola', 'Marco', 'Via Bologna 8', 'Bologna', 40100, 'VLAMRC80C01H501C'),
(NEWID(), 'Marrone', 'Elena', 'Via Bari 9', 'Bari', 70100, 'MRRLNE75D01H501D'),
(NEWID(), 'Grigio', 'Roberto', 'Via Catania 10', 'Palermo', 95100, 'GRGRRT80E01H501E'),
(NEWID(), 'Argento', 'Francesca', 'Via Trieste 11', 'Trieste', 34100, 'ARGFNC85F01H501F'),
(NEWID(), 'Oro', 'Stefano', 'Via Terni 12', 'Terni', 5100, 'OROSFN70G01H501G');

-- Inserisco i record nella tabella [Tipi Violazione]
INSERT INTO [Tipi Violazione] (IdViolazione, Descrizione) VALUES
(NEWID(), 'Eccesso di velocità'),
(NEWID(), 'Passaggio con semaforo rosso'),
(NEWID(), 'Sosta vietata'),
(NEWID(), 'Guida senza cintura'),
(NEWID(), 'Uso del cellulare alla guida'),
(NEWID(), 'Mancato rispetto della distanza di sicurezza'),
(NEWID(), 'Guida in stato di ebbrezza'),
(NEWID(), 'Mancato rispetto della segnaletica stradale'),
(NEWID(), 'Veicolo senza revisione'),
(NEWID(), 'Assicurazione scaduta');

-- Mi dichiaro dei placeholder associandoli ognuno a un id. Faccio ciò per permettermi di riportare lo stesso guid nella tabella verbali, dopodichè aggiungo i record.
DECLARE @IdAnagrafica1 UNIQUEIDENTIFIER = (SELECT IdAnagrafica FROM Anagrafiche WHERE Cognome = 'Rossi');
DECLARE @IdAnagrafica2 UNIQUEIDENTIFIER = (SELECT IdAnagrafica FROM Anagrafiche WHERE Cognome = 'Bianchi');
DECLARE @IdAnagrafica3 UNIQUEIDENTIFIER = (SELECT IdAnagrafica FROM Anagrafiche WHERE Cognome = 'Verdi');
DECLARE @IdAnagrafica4 UNIQUEIDENTIFIER = (SELECT IdAnagrafica FROM Anagrafiche WHERE Cognome = 'Neri');
DECLARE @IdAnagrafica5 UNIQUEIDENTIFIER = (SELECT IdAnagrafica FROM Anagrafiche WHERE Cognome = 'Russo');
DECLARE @IdAnagrafica6 UNIQUEIDENTIFIER = (SELECT IdAnagrafica FROM Anagrafiche WHERE Cognome = 'Gialli');
DECLARE @IdAnagrafica7 UNIQUEIDENTIFIER = (SELECT IdAnagrafica FROM Anagrafiche WHERE Cognome = 'Blu');
DECLARE @IdAnagrafica8 UNIQUEIDENTIFIER = (SELECT IdAnagrafica FROM Anagrafiche WHERE Cognome = 'Viola');
DECLARE @IdAnagrafica9 UNIQUEIDENTIFIER = (SELECT IdAnagrafica FROM Anagrafiche WHERE Cognome = 'Marrone');
DECLARE @IdAnagrafica10 UNIQUEIDENTIFIER = (SELECT IdAnagrafica FROM Anagrafiche WHERE Cognome = 'Grigio');
DECLARE @IdAnagrafica11 UNIQUEIDENTIFIER = (SELECT IdAnagrafica FROM Anagrafiche WHERE Cognome = 'Argento');
DECLARE @IdAnagrafica12 UNIQUEIDENTIFIER = (SELECT IdAnagrafica FROM Anagrafiche WHERE Cognome = 'Oro');

DECLARE @IdViolazione1 UNIQUEIDENTIFIER = (SELECT IdViolazione FROM [Tipi Violazione] WHERE Descrizione = 'Sosta vietata');
DECLARE @IdViolazione2 UNIQUEIDENTIFIER = (SELECT IdViolazione FROM [Tipi Violazione] WHERE Descrizione = 'Eccesso di velocità');
DECLARE @IdViolazione3 UNIQUEIDENTIFIER = (SELECT IdViolazione FROM [Tipi Violazione] WHERE Descrizione = 'Passaggio con semaforo rosso');
DECLARE @IdViolazione4 UNIQUEIDENTIFIER = (SELECT IdViolazione FROM [Tipi Violazione] WHERE Descrizione = 'Guida senza cintura');
DECLARE @IdViolazione5 UNIQUEIDENTIFIER = (SELECT IdViolazione FROM [Tipi Violazione] WHERE Descrizione = 'Uso del cellulare alla guida');
DECLARE @IdViolazione6 UNIQUEIDENTIFIER = (SELECT IdViolazione FROM [Tipi Violazione] WHERE Descrizione = 'Mancato rispetto della distanza di sicurezza');
DECLARE @IdViolazione7 UNIQUEIDENTIFIER = (SELECT IdViolazione FROM [Tipi Violazione] WHERE Descrizione = 'Guida in stato di ebbrezza');
DECLARE @IdViolazione8 UNIQUEIDENTIFIER = (SELECT IdViolazione FROM [Tipi Violazione] WHERE Descrizione = 'Mancato rispetto della segnaletica stradale');
DECLARE @IdViolazione9 UNIQUEIDENTIFIER = (SELECT IdViolazione FROM [Tipi Violazione] WHERE Descrizione = 'Veicolo senza revisione');
DECLARE @IdViolazione10 UNIQUEIDENTIFIER = (SELECT IdViolazione FROM [Tipi Violazione] WHERE Descrizione = 'Assicurazione scaduta');

INSERT INTO Verbali (IdVerbale, DataViolazione, IndirizzoViolazione, NominativoAgente, DataTrascrizioneVerbale, Importo, DecurtamentoPunti, IdAnagrafica, IdViolazione) VALUES
(1, '20090215 10:00:00', 'Via Libertà 12', 'Agente 1', '20090216 10:00:00', 200.00, 5, @IdAnagrafica1, @IdViolazione1),
(1, '20090215 10:00:00', 'Via Libertà 12', 'Agente 1', '20090216 10:00:00', 200.00, 5, @IdAnagrafica1, @IdViolazione2),
(2, '20090320 11:00:00', 'Via Roma 14', 'Agente 2', '20090321 11:00:00', 150.00, 0, @IdAnagrafica2, @IdViolazione1),
(3, '20090425 12:00:00', 'Via Maqueda 16', 'Agente 3', '20090426 12:00:00', 300.00, 2, @IdAnagrafica3, @IdViolazione2),
(4, '20090510 13:00:00', 'Via Dante 18', 'Agente 4', '20090511 13:00:00', 250.00, 0, @IdAnagrafica4, @IdViolazione3),
(5, '20090605 14:00:00', 'Via Notarbartolo 20', 'Agente 5', '20090606 14:00:00', 350.00, 3, @IdAnagrafica5, @IdViolazione4),
(6, '20090715 15:00:00', 'Via della Libertà 22', 'Agente 6', '20090716 15:00:00', 400.00, 4, @IdAnagrafica6, @IdViolazione5),
(7, '20210810 16:00:00', 'Via Milano 24', 'Agente 7', '20210811 16:00:00', 270.00, 2, @IdAnagrafica7, @IdViolazione6),
(8, '20220915 17:00:00', 'Via Napoli 26', 'Agente 8', '20220916 17:00:00', 320.00, 0, @IdAnagrafica8, @IdViolazione7),
(9, '20231020 18:00:00', 'Via Torino 28', 'Agente 9', '20231021 18:00:00', 180.00, 1, @IdAnagrafica9, @IdViolazione8),
(10, '20241125 19:00:00', 'Via Firenze 30', 'Agente 1', '20241126 19:00:00', 210.00, 2, @IdAnagrafica10, @IdViolazione9),
(11, '20250101 20:00:00', 'Via Genova 32', 'Agente 1', '20250102 20:00:00', 220.00, 0, @IdAnagrafica11, @IdViolazione10),
(12, '20250205 21:00:00', 'Via Bologna 34', 'Agente 2', '20250206 21:00:00', 330.00, 8, @IdAnagrafica12, @IdViolazione2),
(12, '20250205 21:00:00', 'Via Bologna 34', 'Agente 2', '20250206 21:00:00', 330.00, 8, @IdAnagrafica12, @IdViolazione3),
(13, '20250310 22:00:00', 'Via Bari 36', 'Agente 3', '20250311 22:00:00', 340.00, 1, @IdAnagrafica1, @IdViolazione3),
(14, '20250415 23:00:00', 'Via Catania 38', 'Agente 4', '20250416 23:00:00', 350.00, 4, @IdAnagrafica2, @IdViolazione1),
(15, '20250520 09:00:00', 'Via Trieste 40', 'Agente 5', '20250521 09:00:00', 360.00, 0, @IdAnagrafica3, @IdViolazione4),
(16, '20250625 08:00:00', 'Via Terni 42', 'Agente 6', '20250626 08:00:00', 370.00, 2, @IdAnagrafica4, @IdViolazione5),
(17, '20250701 07:00:00', 'Via Venezia 44', 'Agente 7', '20250702 07:00:00', 380.00, 3, @IdAnagrafica5, @IdViolazione6),
(18, '20250805 06:00:00', 'Via Libertà 46', 'Agente 8', '20250806 06:00:00', 390.00, 12, @IdAnagrafica6, @IdViolazione7),
(18, '20250805 06:00:00', 'Via Libertà 46', 'Agente 8', '20250806 06:00:00', 390.00, 12, @IdAnagrafica6, @IdViolazione8),
(19, '20250910 05:00:00', 'Via Roma 48', 'Agente 1', '20250911 05:00:00', 400.00, 4, @IdAnagrafica7, @IdViolazione3),
(20, '20251015 04:00:00', 'Via Maqueda 50', 'Agente 2', '20251016 04:00:00', 410.00, 2, @IdAnagrafica8, @IdViolazione1);

--1. Conteggio dei verbali trascritti, 
SELECT COUNT(*) AS TotaleVerbali 
	FROM Verbali;

--2. Conteggio dei verbali trascritti raggruppati per anagrafe, 
SELECT A.Cognome, A.Nome, A.CodiceFiscale, COUNT(V.IdVerbale) 
	AS NumeroVerbali
	FROM Verbali AS V
	INNER JOIN 
    Anagrafiche AS A 
	ON V.IdAnagrafica = A.IdAnagrafica
	GROUP BY A.Cognome, A.Nome, A.CodiceFiscale;

--3. Conteggio dei verbali trascritti raggruppati per tipo di violazione, 
SELECT TV.Descrizione, COUNT(V.IdVerbale) 
	AS NumeroVerbali
	FROM [Tipi Violazione] AS TV
	INNER JOIN 
    Verbali AS V 
	ON TV.IdViolazione = V.IdViolazione
	GROUP BY TV.Descrizione;

--4. Totale dei punti decurtati per ogni anagrafe, 
SELECT A.Cognome, A.Nome, A.CodiceFiscale, SUM(V.DecurtamentoPunti) 
	AS TotPuntiDecurtati
	FROM Verbali AS V
	INNER JOIN 
    Anagrafiche AS A 
	ON V.IdAnagrafica = A.IdAnagrafica
	GROUP BY A.Cognome, A.Nome, A.CodiceFiscale;

--5. Cognome, Nome, Data violazione, Indirizzo violazione, importo e punti decurtati per tutti gli anagrafici residenti a Palermo,
SELECT A.Cognome, A.Nome, V.DataViolazione, V.IndirizzoViolazione, V.Importo, V.DecurtamentoPunti
	FROM Anagrafiche AS A
	INNER JOIN
	Verbali AS V
	ON A.IdAnagrafica = V.IdAnagrafica
	WHERE A.Citta = 'Palermo';

--6. Cognome, Nome, Indirizzo, Data violazione, importo e punti decurtati per le violazioni fatte tra il febbraio 2009 e luglio 2009, 
SELECT A.Cognome, A.Nome, V.DataViolazione, V.IndirizzoViolazione, V.Importo, V.DecurtamentoPunti
	FROM Anagrafiche AS A
	INNER JOIN
	Verbali AS V
	ON A.IdAnagrafica = V.IdAnagrafica
	WHERE V.DataViolazione BETWEEN '01-02-2009' AND '01-07-2009';

--7. Totale degli importi per ogni anagrafico,
SELECT A.Cognome, A.Nome, A.CodiceFiscale, SUM(V.Importo)
	FROM Anagrafiche AS A
	INNER JOIN
	Verbali AS V
	ON A.IdAnagrafica = V.IdAnagrafica
	GROUP BY A.Cognome, A.Nome, A.CodiceFiscale;
--8. Visualizzazione di tutti gli anagrafici residenti a Palermo,
SELECT * FROM Anagrafiche
	WHERE Citta = 'Palermo';

--9. Query che visualizzi Data violazione, Importo e decurta mento punti relativi ad una certa data, 
SELECT DataViolazione, Importo, DecurtamentoPunti
	FROM Verbali
	WHERE DataViolazione = '20090215 10:00:00';

--10. Conteggio delle violazioni contestate raggruppate per Nominativo dellagente di Polizia,
SELECT NominativoAgente, COUNT(IdVerbale) AS NumeroViolazioni
	FROM Verbali
	GROUP BY NominativoAgente;

--11. Cognome, Nome, Indirizzo, Data violazione, Importo e punti decurtati per tutte le violazioni che superino il decurtamento di 5 punti, 
SELECT A.Cognome, A.Nome, V.DataViolazione, V.IndirizzoViolazione, V.Importo, V.DecurtamentoPunti
	FROM Anagrafiche AS A
	INNER JOIN
	Verbali AS V
	ON A.IdAnagrafica = V.IdAnagrafica
	WHERE DecurtamentoPunti > 5;

--12. Cognome, Nome, Indirizzo, Data violazione, Importo e punti decurtati per tutte le violazioni che superino limporto di 400 euro. 
SELECT A.Cognome, A.Nome, V.DataViolazione, V.IndirizzoViolazione, V.Importo, V.DecurtamentoPunti
	FROM Anagrafiche AS A
	INNER JOIN
	Verbali AS V
	ON A.IdAnagrafica = V.IdAnagrafica
	WHERE Importo > 300;

--EXTRA

--Query 13 - Numero di verbali e importo totale delle multe emesse per ogni agente di polizia
SELECT NominativoAgente, COUNT(IdVerbale) AS NumeroVerbali, SUM(importo) AS TotalePerAgente
	FROM Verbali
	GROUP BY NominativoAgente;

--Query 14 - Media degli importi delle multe per tipo di violazione
SELECT Descrizione, AVG(Importo) MediaImportoPerViolazione
	FROM [Tipi Violazione]
	INNER JOIN
	Verbali
	ON [Tipi Violazione].IdViolazione = Verbali.IdViolazione
	GROUP BY Descrizione;

