package it.unisa;

import java.sql.*;
import java.util.Scanner;
import it.unisa.Query;
public class Progetto{
	
	public static void main(String[] arg) throws Exception, SQLException{
		int scelta=0;
		
		Connection con = null ;
		
		//connessione al database
		try {
			Class.forName("com.mysql.cj.jdbc.Driver");
			String url = "jdbc:mysql://localhost:3306/ServiziDelivery"  
							+ "?useUnicode=true&useJDBCCompliantTimezoneShift=true"
							+ "&useLegacyDatetimeCode=false&serverTimezone=UTC";
			
			String username = "root"; String pwd = "359801"; 					
			con = DriverManager.getConnection(url,username,pwd);
				
		
		//scelta query da eseguire
		do {
		Scanner in= new Scanner(System.in);
		System.out.println("Mostra operazioni disponibili: Digitare 1 oppure qualsiasi tasto per non mostrare");
		int s=in.nextInt();
		
		if(s==1) {
			System.out.println("1: Registrazione di un ordine");
			System.out.println("2: Consegna di un ordine"); 
			System.out.println("3: Verifica possibilità di effettuare un ordine ad un ristorante");
			System.out.println("4: Ristoranti disponibili all’accettazione di un ordine");
			System.out.println("5: Valutazione di un rider ");
			System.out.println("6: Visualizzazione ogni cliente del numero di ordini effettuati");
			System.out.println("7: Abilitazione affidamento ad una società di un servizio di delivery");
			System.out.println("8: Assunzione di un nuovo dipendente per la consegna");
			System.out.println("9: Nomi dei ristoranti che impiegano dipendenti consegna o ai servizi della società «Food Delivery»");
			System.out.println("10: Ordini consegnati da Raider ancora non valutati");
			System.out.println("11: Cancellazione di un ordine ancora non consegnato");
			System.out.println("12: Stampa persone che abbiano consegnato ordini a «Giuseppe Verdi» nell’ultima settimana");
			System.out.println("13: Stampa  report con dati dei ristoranti");
			System.out.println("14: Stampa settimanale di un report che mostri i dati dei rider");
			System.out.println("15: Stampa i clienti che nell’ultima settimana hanno lasciato valutazione inferiore a score medio di un raider");
		}
		
		System.out.println("16: Fine programma");
		System.out.println("Scelta query da eseguire");
		scelta=in.nextInt();
		
		switch (scelta) {
		
		case 1: try{
					Query.PrimaQuery(con); 
				}
				catch(Exception e) {
					System.out.println("Errore nell'interrogazione");
				} break;
				
		case 2: try{
					Query.SecondaQuery(con);
				}
				catch(Exception e) {
					System.out.println("Errore nell'interrogazione");
				} break;
				
		case 3: try{
					Query.TerzaQuery(con); break;
				}
				catch(Exception e) {
					System.out.println("Errore nell'interrogazione");
				}break;	
		
		case 4: try{
					Query.QuartaQuery(con); break;
				}
				catch(Exception e) {
					System.out.println("Errore nell'interrogazione");
				}break;
				
		case 5: try{
					Query.QuintaQuery(con); break;
				}
				catch(Exception e) {
					System.out.println("Errore nell'interrogazione");
				}break;
				
		case 6: try{
					Query.SestaQuery(con); break;
				}
				catch(Exception e) {
					System.out.println("Errore nell'interrogazione");
				}break;
		
		case 7: try{
					Query.SettimaQuery(con); break;
				}
				catch(Exception e) {
					System.out.println("Errore nell'interrogazione");
				}break;
		case 8: try{
					Query.OttavaQuery(con); break;
				}
				catch(Exception e) {
					System.out.println("Errore nell'interrogazione");
				}break;
		case 9: try{
					Query.NonaQuery(con); 
				}
				catch(SQLException e) {
					System.out.println("Errore nell'interrogazione");
				}break;
		case 10: try{
					Query.DecimaQuery(con); 
				}
				catch(SQLException e) {
					System.out.println("Errore nell'interrogazione");
				}break;
		case 11: try{
					Query.UndicesimaQuery(con); 
				}
				catch(SQLException e) {
					System.out.println("Errore nell'interrogazione");
				}break;
		case 12:  try{
					Query.DodicesimaQuery(con); 
				}
				catch(SQLException e) {
					System.out.println("Errore nell'interrogazione");
				}break;
		case 13: try{
					Query.TredicesimaQuery(con); 
				}
				catch(Exception e) {
					System.out.println("Errore nell'interrogazione");
				}break;
		case 14: try{
					Query.QuattordicesimaQuery(con); 
				}
				catch(SQLException e) {
					System.out.println("Errore nell'interrogazione");
				}break;
		case 15: try{
					Query.QuindicesimaQuery(con); 
				}
				catch(SQLException e) {
					System.out.println("Errore nell'interrogazione");
				}break;
		case 16: System.out.println("Grazie per aver usufruito di questo programma"); break;
		}
		
		}while(scelta!=16);
	}
	catch(Exception e){
		System.out.println("Connessione fallita"); }
	}
}