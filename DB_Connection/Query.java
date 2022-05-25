package it.unisa;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.Scanner;

public class Query {


	/**
	 * PRIMA QUERY
	 * @param con
	 */
	public static void PrimaQuery(Connection con) throws Exception{ 
		
			Statement query1 = con.createStatement();
			try {
				Scanner in = new Scanner(System.in);
				System.out.println("Inserire contatto");
				String contattoTrovato=in.next();
				System.out.println("Inserire codice fiscale del cliente");
				String cfTrovato=in.next();
				System.out.println("Inserisci tipo portata che si vuole ordinare");
				String portata=in.next();
				System.out.println("Inserire piatto");  
				String c=in.nextLine();
				String piatto=in.nextLine();
				try {
				ResultSet numero= query1.executeQuery("SELECT MAX(NumeroGiornaliero) from Ordine,Ristorante,Cliente"+
													 " where Ristorante.contatto='"+contattoTrovato+"'"+
													 " and Cliente.CodiceFiscale='"+cfTrovato+"'"+
													 " and Ristorante.maxprenotazioni>Ristorante.NumOrdiniCoda "+
													 " and Ordine.C_Ristorante='"+contattoTrovato+"'"+ 
													 " and Ordine.Data=Current_date");		
						numero.next();
						boolean funzione= query1.execute("INSERT INTO Ordine(NumeroGiornaliero, C_Ristorante, Data, Stato, Tipo, Descrizione, CF_Cliente)"+"VALUES("+(numero.getInt(1)+1)+",'"+contattoTrovato+"' ,CURRENT_DATE, 'ordinato','"+portata+"','"+piatto+"','"+ cfTrovato+"')");
						query1.execute("Update Ristorante set NumOrdiniCoda=NumOrdiniCoda+1 where Contatto='"+contattoTrovato+"'");
						if(!funzione) System.out.println("Inserimento effettuato");
					}
					catch(SQLException e) {
						System.out.println("E' il primo ordine giornaliero di questo ristorante");
						boolean funzione= query1.execute("INSERT INTO Ordine(NumeroGiornaliero, C_Ristorante, Data, Stato, Tipo, Descrizione, CF_Cliente)"+"VALUES(1,'"+contattoTrovato+"' ,CURRENT_DATE, 'ordinato','"+portata+"','"+piatto+"','"+ cfTrovato+"')");
						query1.execute("Update Ristorante set NumOrdiniCoda=NumOrdiniCoda+1 where Contatto='"+contattoTrovato+"'");
						if(!funzione) System.out.println("Inserimento effettuato");
					}
				}
			catch(Exception e) {
				System.out.println(" Non è possibile ordinare nel ristorante ");
			}
			
	}
	
	
	/**
	 * SECONDA QUERY
	 * @param con
	 */
	public static void SecondaQuery(Connection con) throws Exception { 
		Statement query = con.createStatement();
		boolean disponibile=true;
		
		Scanner in = new Scanner(System.in);
		System.out.println("Dammi Data Ordine");
		String Ord=in.next();
		System.out.println("Dammi numero giornaliero");
		int numeroG=in.nextInt();
		System.out.println("Numero ristorate");
		String numeroR=in.next();
		System.out.println("Nome cliente che va a ritirare");
		String x=in.nextLine();
		String nome=in.nextLine();
		ResultSet result=query.executeQuery("SELECT C_ServizioDelivery from Scelta where C_Ristorante='"+numeroR+"'");
		result.next();
		String codice=result.getString("C_ServizioDelivery");
		
		try {
			ResultSet result1=query.executeQuery("Select TipoServizio from ServizioDelivery where Codice='"+codice+"' AND TipoServizio=1" );
			result1.next();
			
			ResultSet result2 = query.executeQuery("SELECT IDRider from Rider where Disponibilità=1");
			result2.next();
			String IDR= result2.getString("IDRider");
			
			query.executeUpdate("UPDATE Rider set Disponibilità=0 where IDRider='"+IDR+"'"); 
			query.execute("INSERT INTO ConsegnaRider(ID_Rider,D_Ordine,Num_Ordine,C_Ordine,OrarioPresunto,OrarioEffettivo, NomeClienteRitiro)"+"VALUES('"+IDR+"','"+Ord+"','"+numeroG+"','"+numeroR+"','20:10:00','20:55:00','"+nome+"')");
			query.executeUpdate("UPDATE Rider set Disponibilità=1 where IDRider='"+IDR+"'");
			boolean risultato=query.execute("UPDATE Ordine set Stato='consegnato' where NumeroGiornaliero="+numeroG+" and C_Ristorante='"+numeroR+"' and Data='"+Ord+"'");
			if(!risultato) System.out.println("Inserimento Effettuato");
		}
		catch(SQLException e){
			System.out.println("Non può consegnare un rider, sarà un dipendente del ristorante a consegnare");
			if(disponibile) { 
				ResultSet result2= query.executeQuery("SELECT CodiceFiscale from Dipendente");
				result2.next();
				
				String CFD= result2.getString("CodiceFiscale");
				disponibile=false;
				query.execute("INSERT INTO ConsegnaDipendente(D_Ordine,Num_Ordine,C_Ordine,OrarioPresunto,OrarioEffettivo, NomeClienteRitiro,CF_Dipendente)" + "VALUES('"+Ord+"',"+numeroG+",'"+numeroR+"','20:10:00','20:55:00','"+nome+"','"+CFD+"')");
				boolean risultato=query.execute("UPDATE Ordine set Stato='consegnato' where NumeroGiornaliero="+numeroG+" and C_Ristorante='"+numeroR+"' and Data='"+Ord+"'");
				if(!risultato) System.out.println("Inserimento Effettuato");
				disponibile=true;
				
			} else System.out.println("Il dipendente sta consegnando");
		}
		
			
	}

	
	/**
	 * TERZA QUERY
	 * @param con
	 */
	public static void TerzaQuery(Connection con) throws Exception{
			Statement query = con.createStatement();
			
			Scanner in = new Scanner(System.in);
			System.out.println("Dammi contatto");
			String contattoTrovato=in.next();
			try {
				ResultSet result = query.executeQuery("SELECT MAXprenotazioni,NumOrdiniCoda from Ristorante where Contatto='"+contattoTrovato+"' AND MAXprenotazioni>NumOrdiniCoda" );
				result.next();
				System.out.println("E' possibile ordinare a questo ristorante");
				System.out.println("MAX Prenotazioni: "+result.getInt(1)+"\nNumero Ordini Coda: "+result.getInt(2));
			}
			catch(SQLException e) {
				System.out.println("Non è possibile ordinare a questo ristorante");
			}
			
		}
	
	/**
	 * Quarta Query
	 * @param con
	 */
	public static void QuartaQuery(Connection con) throws Exception{
			Statement query = con.createStatement();
			ResultSet result = query.executeQuery("Select Contatto,Nome from Ristorante where MAXprenotazioni>NumOrdiniCoda");
			System.out.println("I ristoranti disponibili all'accettazione di un ordine sono:");
			while (result.next()){
					System.out.println(result.getString("Nome")+"\n"+result.getString("Contatto"));
			}
		}
		
	
	/**
	 * Quinta query
	 * @param con
	 */
	public static void QuintaQuery(Connection con) throws Exception{ 
			Statement query = con.createStatement();
			Scanner in = new Scanner(System.in);
			System.out.println("Dammi codiceFiscale cliente");
			String CFC=in.next();
	
			try {
				ResultSet result= query.executeQuery("select ID_Rider from Ordine,ConsegnaRider where Ordine.CF_Cliente='"+CFC+"' AND ConsegnaRider.C_Ordine=Ordine.C_Ristorante");
				result.next();
				String IDRider= result.getString("ID_Rider");
				
				System.out.println("Dammi score valutazione");
				int scoreValutazione=in.nextInt();
				
				boolean risultato= query.execute("insert into Valutazione(CF_Cliente, ID_Rider, DataValutazione, Score) VALUES ('"+CFC+"','"+IDRider+"',CURRENT_DATE,"+scoreValutazione+")"); 
				if(!risultato) System.out.println("inserimento effettuato");
			}catch(SQLException e) {
				System.out.println("Consegna non esistente");
			}
			
		}
		
	/**
	 * Sesta query
	 * @param con
	 * @throws Exception
	 */
	public static void SestaQuery(Connection con) throws Exception{
			Statement query = con.createStatement();
			ResultSet result = query.executeQuery("Select CF_Cliente, Count(*) AS NumeroOrdini from Ordine GROUP BY CF_Cliente");
			while(result.next()) {
				System.out.println(result.getString(1));
				System.out.println(result.getInt(2));
			}
	}
	
	/**
	 * Settima query
	 * @param con
	 * @throws Exception
	 */
	public static void SettimaQuery(Connection con) throws Exception{	
			Statement query = con.createStatement();
			Scanner in= new Scanner(System.in);
			
			System.out.println("Dammi partita IVA");
			String pIva= in.next();
			System.out.println("Dammi codice servizio delivery");
			String codice= in.next();
			ResultSet result= query.executeQuery("Select * from ServizioDelivery, società where serviziodelivery.codice='"+codice+"' and serviziodelivery.tiposervizio=1 and società.Partita_IVA='"+pIva+"'");
			result.next();
			boolean risultato=query.execute("Insert into Contatto(C_ServizioDelivery,P_Societa) values ('"+codice+"','"+pIva+"')");
			if(!risultato) System.out.println("Inserimento effettuato");
		}
		
	/**
	 * Ottava query
	 * @param con
	 * @throws Exception
	 */
	public static void OttavaQuery(Connection con) throws Exception{   
			Statement query = con.createStatement();
			
			Scanner in= new Scanner(System.in);
			System.out.println("Dammi codice fiscale dipendente");
			String CFD=in.next();
			System.out.println("Dammi nome");
			String nome=in.next();
			System.out.println("Dammi Cognome");
			String cognome=in.next();
			System.out.println("Dammi anni esperienza");
			int anniE=in.nextInt();
			System.out.println("Dammmi codice servizio delivery ristorante");
			String CSD=in.next();
			System.out.println("Dammi tipo contratto");
			String tipo= in.next();
			String c=in.nextLine();
			System.out.println("Dammi curriculum");
			String curriculum=in.nextLine();
			
		
			boolean risultato=query.execute("Insert into Dipendente(CodiceFiscale, AnniEsperienza, Curriculum, TipoContratto,DataAssunzione, C_ServizioDelivery,Nome, Cognome)VALUES('"+CFD+"',"+anniE+",'"+curriculum+"','"+tipo+"', CURRENT_DATE,'"+CSD+"'"+",'"+nome+"','"+cognome+"')");
			if(!risultato) System.out.println("Inserimento effettuato");
		}

	/**
	 * Nona query
	 * @param con
	 * @throws SQLException
	 */
	public static void NonaQuery(Connection con) throws SQLException{
			Statement query = con.createStatement();
			Scanner in= new Scanner(System.in);
			ResultSet result=query.executeQuery("Select * from Ristorante JOIN Scelta on Scelta.C_Ristorante=Ristorante.contatto "+ 
												"JOIN ServizioDelivery on Scelta.C_ServizioDelivery=ServizioDelivery.codice " + 
												"JOIN Contatto on Serviziodelivery.codice=Contatto.C_ServizioDelivery " + 
												"JOIN società on Contatto.P_societa=società.Partita_IVA " + 
												"where società.nome='Food Delivery' or serviziodelivery.tipoServizio=0");
			while(result.next()) {
				String contatto= result.getString("Contatto");
				String nome=result.getString("Nome");
				System.out.println(contatto+ " "+nome);
				
			}
	}
			

	/**
	 * Decima query
	 * @param con
	 * @throws SQLException
	 */
	public static void DecimaQuery(Connection con) throws SQLException{ 
		try{
			Statement query = con.createStatement();
			
			ResultSet result= query.executeQuery("SELECT * from Ordine JOIN ConsegnaRider on Ordine.data=consegnarider.D_Ordine AND Ordine.C_Ristorante=consegnarider.C_Ordine "+
												"AND ordine.NumeroGiornaliero=consegnarider.Num_Ordine AND Ordine.stato='consegnato' " + 
												"JOIN Rider on consegnarider.ID_Rider=Rider.IDRider " + 
												"JOIN Valutazione on Valutazione.ID_Rider!=Rider.IDRider");
			while(result.next()) 
				System.out.println("L'ordine in data "+ result.getDate("Data")+" "+result.getString("Descrizione")+" consegnato da "+result.getString("Nome")+" "+result.getString("Cognome")+" non è stato valutato da "+result.getNString("CF_cliente"));
		}
		catch (SQLException e) {
			 System.out.println("Tutti gli ordini sono stati valutati");  
		}
		
	}
	
	/**
	 * Undicesima query
	 * @param con
	 * @throws SQLException
	 */
	public static void UndicesimaQuery(Connection con) throws SQLException{ 
		Statement query = con.createStatement();
		ResultSet result= query.executeQuery("SELECT * from Ordine where Ordine.Stato='ordinato'");
	    while(result.next());
	    query.execute("SET SQL_SAFE_UPDATES = 0");
		boolean risultato= query.execute("DELETE FROM Ordine where Stato<>'consegnato'");
		if(!risultato) System.out.println("Operazione effettuata");
		}

		
	/**
	 * Dodicesima query
	 * @param con
	 * @throws Exception
	 */
	public static void DodicesimaQuery(Connection con) throws Exception{
		try {
			Statement query = con.createStatement();
			ResultSet result= query.executeQuery("Select * from dipendente join consegnadipendente on consegnadipendente.cf_dipendente=dipendente.codicefiscale " + 
												 "join consegnarider on consegnarider.ID_Rider=consegnarider.ID_Rider join rider on consegnarider.ID_rider=rider.IDRider " + 
												 "where (ConsegnaDipendente.CF_Dipendente=Dipendente.CodiceFiscale or ConsegnaRider.ID_Rider=Rider.IDRider) " + 
												 "and (ConsegnaDipendente.NomeClienteRitiro='Giuseppe Verdi' or ConsegnaRider.NomeClienteRitiro='Giuseppe Verdi') " + 
												 "and (ConsegnaDipendente.D_Ordine>DATE(NOW()) - INTERVAL 7 DAY) or (ConsegnaRider.D_Ordine>DATE(NOW()) - INTERVAL 7 DAY)");
			
			while(result.next()) {
				System.out.println(result.getString(1));
			}
		}
		catch(SQLException e){
			System.out.println("Non c'è nessuna consegna");
		}
	}
	
	/**
	 * Tredicesima query
	 * @param con
	 * @throws Exception
	 */
	public static void TredicesimaQuery(Connection con)throws Exception{
		Statement query = con.createStatement();
		ResultSet result= query.executeQuery("SELECT * from Ristorante");
		
		while(result.next()) {
			System.out.println(result.getString(1)+" "+result.getString(2)+" "+result.getString(3)+" "+result.getString(4)+" "+result.getString(5)+" "+result.getString(6)+" "+result.getInt(7)+" "+result.getInt(8)+" ");
		}
		
	}
	
	/**
	 * Quattordicesima query
	 * @param con
	 * @throws Exception
	 */
	public static void QuattordicesimaQuery(Connection con)throws Exception{
		Statement query = con.createStatement();
		ResultSet result= query.executeQuery("SELECT * from Rider where current_date-interval 7 day");
		while(result.next()) {
			System.out.println(result.getString("IDRider")+" "+result.getString("Nome")+" "+result.getString("Cognome"));
		}
	}
	
	/**
	 * Quindicesima query
	 * @param con
	 * @throws Exception
	 */
	public static void QuindicesimaQuery(Connection con)throws Exception{
		Statement query = con.createStatement();
		ResultSet Result= query.executeQuery("SELECT * from Cliente JOIN Valutazione on Cliente.CodiceFiscale=Valutazione.CF_Cliente " + 
											 "JOIN Rider on Valutazione.ID_Rider=Rider.IDRider " + 
											 "where Valutazione.DataValutazione>current_date-interval 7 day " + 
											 "AND Valutazione.Score<Rider.ScoreMedio");
		while(Result.next()) {
			System.out.println(Result.getString("CF_Cliente")+" "+Result.getString("Nome")+" "+Result.getString("Cognome"));
			
		}

	}
	}
