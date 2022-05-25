INSERT INTO `servizidelivery`.`assunzione`
(`IVA_Societa`,
`ID_Rider`,
`DataAssunzione`,
`QuotaOraria`)
VALUES
/*INSERISCI I TUOI VALORI*/
(<{IVA_Societa: }>,
<{ID_Rider: }>,
<{DataAssunzione: }>,
<{QuotaOraria: }>);

INSERT INTO `servizidelivery`.`cliente`
(`CodiceFiscale`,
`Nome`,
`Cognome`,
`Via`,
`NumeroCivico`,
`CAP`,
`Contatto`,
`DataRegistrazione`,
`Password`)
VALUES
/*INSERISCI I TUOI VALORI*/
(<{CodiceFiscale: }>,
<{Nome: }>,
<{Cognome: }>,
<{Via: }>,
<{NumeroCivico: }>,
<{CAP: }>,
<{Contatto: }>,
<{DataRegistrazione: }>,
<{Password: }>);

INSERT INTO `servizidelivery`.`consegnadipendente`
(`CF_Dipendente`,
`Num_Ordine`,
`C_Ordine`,
`D_Ordine`,
`OrarioPresunto`,
`OrarioEffettivo`,
`NomeClienteRitiro`)
VALUES
/*INSERISCI I TUOI VALORI*/
(<{CF_Dipendente: }>,
<{Num_Ordine: }>,
<{C_Ordine: }>,
<{D_Ordine: }>,
<{OrarioPresunto: }>,
<{OrarioEffettivo: }>,
<{NomeClienteRitiro: }>);

INSERT INTO `servizidelivery`.`consegnarider`
(`ID_Rider`,
`D_Ordine`,
`Num_Ordine`,
`C_Ordine`,
`OrarioPresunto`,
`OrarioEffettivo`,
`NomeClienteRitiro`)
VALUES
/*INSERISCI I TUOI VALORI*/
(<{ID_Rider: }>,
<{D_Ordine: }>,
<{Num_Ordine: }>,
<{C_Ordine: }>,
<{OrarioPresunto: }>,
<{OrarioEffettivo: }>,
<{NomeClienteRitiro: }>);

INSERT INTO `servizidelivery`.`contatto`
(`C_ServizioDelivery`,
`P_Societa`)
VALUES
(<{C_ServizioDelivery: }>,
<{P_Societa: }>);

INSERT INTO `servizidelivery`.`dipendente`
(`CodiceFiscale`,
`Nome`,
`Cognome`,
`AnniEsperienza`,
`Curriculum`,
`TipoContratto`,
`DataAssunzione`,
`C_ServizioDelivery`)
VALUES
/*INSERISCI I TUOI VALORI*/
(<{CodiceFiscale: }>,
<{Nome: }>,
<{Cognome: }>,
<{AnniEsperienza: }>,
<{Curriculum: }>,
<{TipoContratto: }>,
<{DataAssunzione: }>,
<{C_ServizioDelivery: }>);

INSERT INTO `servizidelivery`.`ordine`
(`NumeroGiornaliero`,
`C_Ristorante`,
`Data`,
`Stato`,
`Tipo`,
`Descrizione`,
`CF_Cliente`)
VALUES
/*INSERISCI I TUOI VALORI*/
(<{NumeroGiornaliero: 1}>,
<{C_Ristorante: }>,
<{Data: }>,
<{Stato: }>,
<{Tipo: }>,
<{Descrizione: }>,
<{CF_Cliente: }>);

INSERT INTO `servizidelivery`.`rider`
(`IDRider`,
`DataPrimoImpiego`,
`Nome`,
`Cognome`,
`NumeroSocieta`,
`ScoreMedio`,
`Disponibilità`)
VALUES
/*INSERISCI I TUOI VALORI*/
(<{IDRider: }>,
<{DataPrimoImpiego: }>,
<{Nome: }>,
<{Cognome: }>,
<{NumeroSocieta: }>,
<{ScoreMedio: }>,
<{Disponibilità: }>);

INSERT INTO `servizidelivery`.`ristorante`
(`Contatto`,
`Nome`,
`Servizi`,
`Via`,
`NumeroCivico`,
`CAP`,
`MAXprenotazioni`,
`NumOrdiniCoda`)
VALUES
/*INSERISCI I TUOI VALORI*/
(<{Contatto: }>,
<{Nome: }>,
<{Servizi: }>,
<{Via: }>,
<{NumeroCivico: }>,
<{CAP: }>,
<{MAXprenotazioni: }>,
<{NumOrdiniCoda: }>);

INSERT INTO `servizidelivery`.`scelta`
(`C_Ristorante`,
`C_ServizioDelivery`)
VALUES
/*INSERISCI I TUOI VALORI*/
(<{C_Ristorante: }>,
<{C_ServizioDelivery: }>);

INSERT INTO `servizidelivery`.`serviziodelivery`
(`Codice`,
`DataUtilizzo`,
`Disponibilita`,
`Descrizione`,
`TipoServizio`)
VALUES
/*INSERISCI I TUOI VALORI*/
(<{Codice: }>,
<{DataUtilizzo: }>,
<{Disponibilita: }>,
<{Descrizione: }>,
<{TipoServizio: }>);

INSERT INTO `servizidelivery`.`società`
(`Partita_IVA`,
`Nome`,
`Amministratore`)
VALUES
(<{Partita_IVA: }>,
<{Nome: }>,
<{Amministratore: }>);

INSERT INTO `servizidelivery`.`valutazione`
(`CF_Cliente`,
`ID_Rider`,
`DataValutazione`,
`Score`)
VALUES
/*INSERISCI I TUOI VALORI*/
(<{CF_Cliente: }>,
<{ID_Rider: }>,
<{DataValutazione: }>,
<{Score: }>);

INSERT INTO `servizidelivery`.`veicolo`
(`ID_Veicolo`,
`ID_Rider`,
`Tipo`,
`Targa`)
VALUES
/*INSERISCI I TUOI VALORI*/
(<{ID_Veicolo: }>,
<{ID_Rider: }>,
<{Tipo: }>,
<{Targa: }>);
