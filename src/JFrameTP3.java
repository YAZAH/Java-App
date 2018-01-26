import java.awt.BorderLayout;
import java.awt.Color;
import java.awt.EventQueue;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.ResultSetMetaData;
import java.sql.Statement;
import java.sql.*;
import javax.swing.JButton;
import javax.swing.JFrame;
import javax.swing.JLabel;
import javax.swing.JOptionPane;
import javax.swing.JPanel;
import javax.swing.JScrollPane;
import javax.swing.JTextArea;
import javax.swing.JTextField;
import javax.swing.border.EmptyBorder;
import javax.swing.BoxLayout;
import java.awt.Component;


public class JFrameTP3 extends JFrame {
   //définir vos variables de classe ici
    Statement stmt;
    String login="";
    String passwd="";

	private final JScrollPane scrollPaneConnexion = new JScrollPane();
	private final JTextArea txtConnexionRussie = new JTextArea();
	//private final JButton btnExecuter = new JButton("Executer");
	private int NbConnexion = 0;
	private final JLabel lblEtudes = new JLabel("\u00C9tudes");
	private final JScrollPane scrollPaneEtudes = new JScrollPane();
	private final JTextArea textAreaEtudes = new JTextArea();
	private final JButton btnRechercher = new JButton("Rechercher");
	private final JButton btnAnnuler = new JButton("Annuler");
	private final JLabel lblNoEtude = new JLabel("No \u00C9tude");
	private final JTextField txtNoEtude = new JTextField();
	private final JLabel lblNoDrogue = new JLabel("No Drogue");
	private final JTextField txtNoDrogue = new JTextField();
	private final JLabel lblNomDrogue = new JLabel("Nom Drogue");
	private final JTextField txtNomDrogue = new JTextField();
	private final JButton btnGo = new JButton("Go");
	private final JLabel lblNoVariant = new JLabel("No Variant");
	private final JTextField txtNoVariant = new JTextField();
	private final JLabel lblGene = new JLabel("G\u00E8ne");
	private final JTextField txtGene = new JTextField();
	private final JButton btnAllerSurDrugbank = new JButton("Aller sur DrugBank");
	private final JButton btnIndiceDefficaciteMetabolique = new JButton("Indice d'efficacit\u00E9 m\u00E9tabolique");
	private final JButton btnNouveauPatient = new JButton("Nouveau patient");
	private final JButton btnSupprimerPatient = new JButton("Supprimer patient");
	private final JButton btnModifierPatient = new JButton("Modifier Patient");
	private final JLabel lblPatientsProvinceIndice = new JLabel("Patients           Province          Indice d'efficacit\u00E9 m\u00E9tabolique");
	private final JScrollPane scrollPanePatientsProvinceIndice = new JScrollPane();
	private final JTextArea textAreaPatientsProvinceIndice = new JTextArea();
	private final JButton btnQuitter = new JButton("Quitter");
	/**
	 * Launch the application
	 * @param args
	 */
	public static void main(String args[]) {
		try {
			JFrameTP3 frame = new JFrameTP3();
			frame.setVisible(true);
			
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	/**
	 * Create the frame
	 */
	public JFrameTP3() {
		super();
		txtGene.setBounds(509, 181, 185, 20);
		txtGene.setColumns(10);
		txtNoVariant.setBounds(345, 181, 95, 20);
		txtNoVariant.setColumns(10);
		txtNomDrogue.setBounds(114, 215, 135, 20);
		txtNomDrogue.setColumns(10);
		txtNoDrogue.setBounds(114, 181, 135, 20);
		txtNoDrogue.setColumns(10);
		txtNoEtude.setBounds(114, 147, 74, 20);
		txtNoEtude.setColumns(10);
		setBounds(100, 100, 747, 451);
		setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
		getContentPane().setLayout(null);
		
	    
	    while(NbConnexion < 2){
		try {
			
			NbConnexion++;
			getContentPane().setLayout(null);
			setTitle("Exemple de base de données");
			
			getContentPane().add(scrollPaneConnexion);
		    scrollPaneConnexion.setViewportView(txtConnexionRussie);
			
		   //soit Insert, Update or Delete comme requete_sql.
		   //stmt.executeUpdate(requete_sql);

		   //les requêtes SQL DML qui retournent des données
		   //ResultSet rs =stmt.executeQuery (requete_sql);
			
		    login=JOptionPane.showInputDialog("Quel est le nom de l'utilisateur?");
		    passwd=JOptionPane.showInputDialog("Quel est le mot de passe?");

		   //1-initialisation de la connexion.
		   Class.forName("oracle.jdbc.driver.OracleDriver");
		   Connection con = DriverManager.getConnection("jdbc:oracle:thin:@ift-oracle2k3.fsg.ulaval.ca:1521:ora11g",
				   login, passwd);
		   JOptionPane.showInputDialog("Connection Reussie");
		   NbConnexion++;
		   //2-Création de la requête pour envoie de l'instruction.
		   stmt = con.createStatement();
		   
		   
		} catch (Throwable e) {
			txtConnexionRussie.setForeground(Color.RED);
				if (e.getMessage().indexOf("invalid username/password")>0 && NbConnexion < 2){
					JOptionPane.showInputDialog("Mauvais identifiant ou mot de passe. Veuillez recommencer");
				}else if(NbConnexion >=2){
					JOptionPane.showInputDialog("La Connexion a echoué.");
					System.exit(1);
				}else{
					//Pour toutes les autres erreur qu'on ne gère pas, on affiche le message anglais
			    	JOptionPane.showInputDialog("La Connexion a echoué. Veuillez recommencer");
			  	}
		}
		
		}
		
		//Requête initiale pour afficher toutes les études
		String sql = "select NO_ETUDE, TITRE_ET from TP2_ETUDE";
		try{
			//les requêtes SQL DML qui retournent des données
			ResultSet rs = stmt.executeQuery (sql);
			//Obtention des méta-données de la table
			//Soit nom et type des colonnes
			ResultSetMetaData rsmd = rs.getMetaData();
			//Le nombre de colonnes
			int numCols = rsmd.getColumnCount();
			//Au départ, le rs est positionné avant le début
			boolean more = rs.next();
			
			//Parcours des colonnes pour afficher leur valeurs pour chaque enregistrement
			while(more) {
				for (int i=1; i<=numCols; i+=2) {
					textAreaEtudes.append(rs.getString(i)+ "	");
					textAreaEtudes.append(rs.getString(i+1)+ "\n");
				}
				more = rs.next(); //passage au prochain enregistrement
			}
			
			//Boutons et champs inaccessibles
			btnGo.setEnabled(false);
			btnAllerSurDrugbank.setEnabled(false);
			btnIndiceDefficaciteMetabolique.setEnabled(false);
			btnNouveauPatient.setEnabled(false);
			btnSupprimerPatient.setEnabled(false);
			btnModifierPatient.setEnabled(false);
			txtNoEtude.setEditable(false);
			txtNoDrogue.setEditable(false);
			txtNomDrogue.setEditable(false);
			txtNoVariant.setEditable(false);
			txtGene.setEditable(false);
			textAreaPatientsProvinceIndice.setEditable(false);
			
		}catch(Exception ex){
			textAreaEtudes.setText(ex.getMessage());
		}
				
		/**
		 * LABELS
		 */
		lblEtudes.setBounds(32, 11, 46, 14);
		getContentPane().add(lblEtudes);
		
		lblNoEtude.setBounds(32, 150, 72, 14);
		getContentPane().add(lblNoEtude);
	  
		lblNoDrogue.setBounds(32, 184, 72, 14);
		getContentPane().add(lblNoDrogue);
	  
		lblNomDrogue.setBounds(32, 218, 72, 14);
		getContentPane().add(lblNomDrogue);
	  
		lblNoVariant.setBounds(277, 184, 64, 14);
		getContentPane().add(lblNoVariant);
		
		lblGene.setBounds(466, 184, 46, 14);
		getContentPane().add(lblGene);
		
		lblPatientsProvinceIndice.setBounds(25, 281, 384, 14);
		getContentPane().add(lblPatientsProvinceIndice);
		
		/**
		 * CHAMPS DE TEXTE
		 */
		scrollPaneEtudes.setBounds(25, 30, 477, 105);
		getContentPane().add(scrollPaneEtudes);
		scrollPaneEtudes.setViewportView(textAreaEtudes);

		
		scrollPanePatientsProvinceIndice.setBounds(25, 300, 669, 65);
		getContentPane().add(scrollPanePatientsProvinceIndice);
		scrollPanePatientsProvinceIndice.setViewportView(textAreaPatientsProvinceIndice);
		
		getContentPane().add(txtNoEtude);
	  
		getContentPane().add(txtNoDrogue);
	  
		getContentPane().add(txtNomDrogue);
	  
		getContentPane().add(txtNoVariant);
	  
		getContentPane().add(txtGene);
		
		/**
		 * BOUTONS
		 */
		//Bouton Rechercher
		btnRechercher.setBounds(556, 37, 138, 23);
		getContentPane().add(btnRechercher);
		btnRechercher.addActionListener(new ActionListener(){
			public void actionPerformed(ActionEvent click){
				String rechercheNomDrogue = JOptionPane.showInputDialog("Entrez un nom de drogue");
				String rechercheGene = JOptionPane.showInputDialog("Entrez un gène");
				String rechercheNoVariant = JOptionPane.showInputDialog("Entrez un numéro de variant");
				
				//Requête sur les études qui correspondent au nom de drogue, gène et numéro de variant fournis
				String sql = "select E.NO_ETUDE, E.TITRE_ET, D.NO_DROGUE, D.NOM_DRO, E.NO_VAR_GEN, V.GENE_VAR"
						+ " from TP2_ETUDE E, TP2_DROGUE D, TP2_VARIATION_GENETIQUE V"
						+ " where E.NO_DROGUE = D.NO_DROGUE"
						+ " and E.NO_VAR_GEN = V.NO_VARIANT_GENETIQUE";
				
				if (!rechercheNomDrogue.equals("")) {
					sql+=" and D.NOM_DRO = \'"+ rechercheNomDrogue +"\'";
				}
				if (!rechercheGene.equals("")) {
					sql+=" and V.GENE_VAR = \'"+ rechercheGene +"\'";
				}
				if (!rechercheNoVariant.equals("")) {
					sql+=" and E.NO_VAR_GEN = \'"+ rechercheNoVariant +"\'";
				}
				
				try{
					//le texte dans textAreaEtudes est réinitialisé
					textAreaEtudes.setText("");
					//les requêtes SQL DML qui retournent des données
					ResultSet rs = stmt.executeQuery (sql);
					//Obtention des méta-données de la table
					//Soit nom et type des colonnes
					ResultSetMetaData rsmd = rs.getMetaData();
					//Le nombre de colonnes
					int numCols = rsmd.getColumnCount();
					//Au départ, le rs est positionné avant le début
					boolean more = rs.next();
					//Parcours des colonnes pour afficher leur valeurs pour chaque enregistrement
					while(more) {
						for (int i=1; i<=numCols; i+=6) {
							textAreaEtudes.append(rs.getString(i)+ " \t ");
							textAreaEtudes.append(rs.getString(i+1)+ "\n");
						}
						more = rs.next(); //passage au prochain enregistrement
					}
					ResultSet rsCopy = stmt.executeQuery (sql);
					ResultSetMetaData rsmdCopy = rsCopy.getMetaData();
					int numColsCopy = rsmdCopy.getColumnCount();
					rsCopy.next();
					if (!textAreaEtudes.getText().isEmpty()) {
						btnGo.setEnabled(true);
						btnAllerSurDrugbank.setEnabled(true);
						btnIndiceDefficaciteMetabolique.setEnabled(true);
						btnNouveauPatient.setEnabled(true);
						btnSupprimerPatient.setEnabled(true);
						btnModifierPatient.setEnabled(true);
						txtNoEtude.setEditable(true);
						txtNoDrogue.setEditable(true);
						txtNomDrogue.setEditable(true);
						txtNoVariant.setEditable(true);
						txtGene.setEditable(true);
						textAreaPatientsProvinceIndice.setEditable(true);
						
						//champs etude
						for (int i=1; i<=numColsCopy; i+=6){
							txtNoEtude.setText(rsCopy.getString(i));
							txtNoDrogue.setText(rsCopy.getString(i+2));
							txtNomDrogue.setText(rsCopy.getString(i+3));
							txtNoVariant.setText(rsCopy.getString(i+4));
							txtGene.setText(rsCopy.getString(i+5));
						}
						
						//textArea patient
						textAreaPatientsProvinceIndice.setText(null);
						ResultSet results = stmt.executeQuery("select C.NO_PATIENT, C.PROVINCE_PAT, "
								+ "C.INDICE_EFFICACITE_METABO_PAT, D.NO_ETUDE "
								+ "from TP2_PATIENT C, TP2_ETUDE_PATIENT D "
								+ "where C.NO_PATIENT = D.NO_PATIENT "
								+ "and D.NO_ETUDE = \'" + txtNoEtude.getText() +"\' ");
						ResultSetMetaData resultMetas = results.getMetaData();
						while(results.next()){         
					        for(int j = 1; j <= resultMetas.getColumnCount(); j+=4){
					        	textAreaPatientsProvinceIndice.append(results.getString(j)+" \t "
					        			+results.getString(j+1)+" \t "+results.getString(j+2)+"\n");
					        }
						}
					
					}else{ //Boutons et champs inaccessibles si la recherche ne retourne aucune étude
						btnGo.setEnabled(false);
						btnAllerSurDrugbank.setEnabled(false);
						btnIndiceDefficaciteMetabolique.setEnabled(false);
						btnNouveauPatient.setEnabled(false);
						btnSupprimerPatient.setEnabled(false);
						btnModifierPatient.setEnabled(false);
						
						txtNoEtude.setEditable(false);
						txtNoDrogue.setEditable(false);
						txtNomDrogue.setEditable(false);
						txtNoVariant.setEditable(false);
						txtGene.setEditable(false);
						textAreaPatientsProvinceIndice.setEditable(false);
						
						txtNoEtude.setText("");
						txtNoDrogue.setText("");
						txtNomDrogue.setText("");
						txtNoVariant.setText("");
						txtGene.setText("");
						textAreaPatientsProvinceIndice.setText("");
					}
				}catch(Exception ex){
					JOptionPane.showMessageDialog(null, ex.getMessage());
				}
			}
		});
		
		//Bouton Annuler
		btnAnnuler.setBounds(556, 71, 138, 23);
		getContentPane().add(btnAnnuler);
		btnAnnuler.addActionListener(new ActionListener() {
			public void actionPerformed(ActionEvent click) {
				//Retour à la requête initiale pour afficher toutes les études
				String sql = "select NO_ETUDE, TITRE_ET from TP2_ETUDE";
				try{
					//le texte dans textAreaEtudes est réinitialisé
					textAreaEtudes.setText("");
					//les requêtes SQL DML qui retournent des données
					ResultSet rs = stmt.executeQuery (sql);
					//Obtention des méta-données de la table
					//Soit nom et type des colonnes
					ResultSetMetaData rsmd = rs.getMetaData();
					//Le nombre de colonnes
					int numCols = rsmd.getColumnCount();
					//Au départ, le rs est positionné avant le début
					boolean more = rs.next();
					
					//Parcours des colonnes pour afficher leur valeurs pour chaque enregistrement
					while(more) {
						for (int i=1; i<=numCols; i+=2) {
							textAreaEtudes.append(rs.getString(i)+ "	");
							textAreaEtudes.append(rs.getString(i+1)+ "\n");
						}
						more = rs.next(); //passage au prochain enregistrement
					}
					
					//Boutons et champs inaccessibles
					btnGo.setEnabled(false);
					btnAllerSurDrugbank.setEnabled(false);
					btnIndiceDefficaciteMetabolique.setEnabled(false);
					btnNouveauPatient.setEnabled(false);
					btnSupprimerPatient.setEnabled(false);
					btnModifierPatient.setEnabled(false);
					txtNoEtude.setEditable(false);
					txtNoDrogue.setEditable(false);
					txtNomDrogue.setEditable(false);
					txtNoVariant.setEditable(false);
					txtGene.setEditable(false);
					textAreaPatientsProvinceIndice.setEditable(false);
					
				}catch(Exception ex){
					JOptionPane.showMessageDialog(null, ex.getMessage());
				}
			}
		});
		
		//Bouton Go
		btnGo.setBounds(219, 146, 89, 23);
		getContentPane().add(btnGo);
		btnGo.addActionListener(new ActionListener() {
			public void actionPerformed(ActionEvent click) {
				try{
					//Numero de la drogue actuelle
					String noEtude = txtNoEtude.getText();
					String sqlChangerEtudeCourante = "select E.NO_ETUDE, E.TITRE_ET, D.NO_DROGUE, "
							+ "D.NOM_DRO, E.NO_VAR_GEN, V.GENE_VAR"
							+ " from TP2_ETUDE E, TP2_DROGUE D, TP2_VARIATION_GENETIQUE V"
							+ " where E.NO_DROGUE = D.NO_DROGUE"
							+ " and E.NO_VAR_GEN = V.NO_VARIANT_GENETIQUE"
							+ " and E.NO_ETUDE =\'"+ noEtude +"\'";
					ResultSet rs = stmt.executeQuery(sqlChangerEtudeCourante);
					//Obtention des méta-données de la table
					//Soit nom et type des colonnes
					ResultSetMetaData rsmd = rs.getMetaData();
					//Le nombre de colonnes
					int numCols = rsmd.getColumnCount();
					//Au départ, le rs est positionné avant le début
				    rs.next();
					for (int i=1; i<=numCols; i+=6){
						txtNoEtude.setText(rs.getString(i));
						txtNoDrogue.setText(rs.getString(i+2));
						txtNomDrogue.setText(rs.getString(i+3));
						txtNoVariant.setText(rs.getString(i+4));
						txtGene.setText(rs.getString(i+5));
					}
					textAreaPatientsProvinceIndice.setText(null);
					ResultSet results = stmt.executeQuery("select C.NO_PATIENT, C.PROVINCE_PAT, C.INDICE_EFFICACITE_METABO_PAT, D.NO_ETUDE from TP2_PATIENT C, TP2_ETUDE_PATIENT D where C.NO_PATIENT = D.NO_PATIENT and D.NO_ETUDE = \'" + txtNoEtude.getText() +"\' ");
					ResultSetMetaData resultMetas = results.getMetaData();
					while(results.next()){         
					        for(int j = 1; j <= resultMetas.getColumnCount(); j+=4){
					        	textAreaPatientsProvinceIndice.append(results.getString(j)+" \t "+results.getString(j+1)+" \t "+results.getString(j+2)+"\n");
					        }
					}
				}catch(Exception ex){
					JOptionPane.showMessageDialog(null, ex.getMessage());
				}
				
			}
		});
		
		//Bouton Drugbank
		btnAllerSurDrugbank.setBounds(277, 214, 176, 23);
		getContentPane().add(btnAllerSurDrugbank);
		btnAllerSurDrugbank.addActionListener(new ActionListener() {
			public void actionPerformed(ActionEvent click) {
				try{
					//Numero de la drogue actuelle
					String noDrogue = txtNoDrogue.getText();
					String sqlUrlDrugBank = "select URL_DRO from TP2_DROGUE where NO_DROGUE =\'"+ noDrogue +"\'";
					ResultSet rs = stmt.executeQuery(sqlUrlDrugBank);
					//Au départ, le rs est positionné avant le début
				    rs.next();
				    //Il faut mettre l'URL dans un String
				    int colonne = 1;
				    String url = rs.getString(colonne);
				    java.awt.Desktop.getDesktop().browse(java.net.URI.create(url));
				}catch(Exception ex){
					JOptionPane.showMessageDialog(null, ex.getMessage());
				}
			   }
		});

		//Bouton Indice D'efficacité métabolique
		btnIndiceDefficaciteMetabolique.setBounds(476, 214, 218, 23);
		getContentPane().add(btnIndiceDefficaciteMetabolique);
		btnIndiceDefficaciteMetabolique.addActionListener(new ActionListener() {
			public void actionPerformed(ActionEvent click){
				try{
					Connection con = DriverManager.getConnection ("jdbc:oracle:thin:@ift-oracle2k3.fsg.ulaval.ca:1521:ora11g", login, passwd);
					//Préparer l'appel à la fonction
					CallableStatement cstmt = con.prepareCall("{?=call TP3_FCT_AVG_INDICE_METABO(?)}"); 
					//identification de la valeur de retour ainsi que son type
					cstmt.registerOutParameter(1,Types.FLOAT); 
					//identification du 1er paramètre
					cstmt.setString(2, txtNoEtude.getText());
					//execution de la fonction
					cstmt.executeQuery();
					//Affichage du résultat
					JOptionPane.showMessageDialog(null, "L'indice d'efficacité métabolique moyen est de: "+ Float.toString(cstmt.getFloat(1)));
				}catch(Exception ex){
					JOptionPane.showMessageDialog(null, ex.getMessage());
				}
			}
		});
		
		//Bouton Nouveau Patient
		btnNouveauPatient.setBounds(25, 247, 145, 23);
		getContentPane().add(btnNouveauPatient);
		btnNouveauPatient.addActionListener(new ActionListener() {
			public void actionPerformed(ActionEvent click) {
				//S'il y a une étude courante
				if (!txtNoEtude.equals(null)){
					try{
						//Demande des informations du patient
						String noPatient= JOptionPane.showInputDialog("Quel est le numéro du patient?");
						String provincePatient= JOptionPane.showInputDialog("Quelle est la province du patient?");
						String indiceEfficacitePatient= JOptionPane.showInputDialog("Quel est l'indice d'efficacité du patient?");
						double numRand = Math.random()*10000000;
						int numPatEtude=(int)numRand;
						//Requete d'insertion
						String sqlAjoutPatient = "insert into TP2_PATIENT"
								+ "(NO_PATIENT, PROVINCE_PAT, INDICE_EFFICACITE_METABO_PAT) "
								+ "values(\'"+ noPatient +"\', \'"+ provincePatient +"\', "
								+ indiceEfficacitePatient +")";
						stmt.executeUpdate(sqlAjoutPatient);
						//Affichage des informations du patient ajouté dans la zone texte
						textAreaPatientsProvinceIndice.append(noPatient+" \t "+provincePatient+" \t "
								+ indiceEfficacitePatient+"\n");
						JOptionPane.showMessageDialog(null, "Patient ajouté dans l'étude: " + txtNoEtude.getText());
						String sqlAjout = "insert into TP2_ETUDE_PATIENT "
								+ "(NO_ETUDE, NUM_PATIENT_ETUDE, NO_PATIENT) "
								+ "values(\'"+ txtNoEtude.getText() +"\', \'"
								+ numPatEtude +"\' , \'"+ noPatient +"\' )";
						stmt.executeUpdate(sqlAjout);
					}catch(Exception ex){
						if (ex.getMessage().startsWith("ORA-00001: unique constraint")){
							JOptionPane.showMessageDialog(null, "Le numéro de patient existe déjà");
						}else if (ex.getMessage().equals("ORA-00984: column not allowed here")){
							JOptionPane.showMessageDialog(null, "Les valeurs entrées sont invalides");
						}
					}
				}
			}
		});
		
		//Bouton Supprimer Patient
		btnSupprimerPatient.setBounds(287, 247, 145, 23);
		getContentPane().add(btnSupprimerPatient);
		btnSupprimerPatient.addActionListener(new ActionListener() {
			public void actionPerformed(ActionEvent click) {
				// S'il y a une étude en cours
				if (!txtNoEtude.equals(null)){
					try{
						//On demande le numéro du patient à supprimer
						String noPatient= JOptionPane.showInputDialog("Quel est le numéro du patient?");
						//L'objet ResultSet contient le résultat de la requête SQL
						ResultSet result = stmt.executeQuery("select NO_PATIENT from TP2_PATIENT");
						//On récupère les MetaData
						ResultSetMetaData resultMeta = result.getMetaData();
						while(result.next()){         
							for(int i = 1; i <= resultMeta.getColumnCount(); i++){
								//Si on trouve le numéro du patient dans la base
								if (result.getString(i).equals(noPatient)){
									try{
										String SupprimerPatient = "delete from TP2_PATIENT where NO_PATIENT = \'" 
												+ noPatient +"\'";
										stmt.executeUpdate(SupprimerPatient);
										JOptionPane.showMessageDialog(null, "Patient supprimé");
										textAreaPatientsProvinceIndice.setText(null);
										ResultSet results = stmt.executeQuery("select C.NO_PATIENT, C.PROVINCE_PAT, "
												+ "C.INDICE_EFFICACITE_METABO_PAT, D.NO_ETUDE "
												+ "from TP2_PATIENT C, TP2_ETUDE_PATIENT D "
												+ "where C.NO_PATIENT = D.NO_PATIENT "
												+ "and D.NO_ETUDE = \'" + txtNoEtude.getText() +"\' ");
										ResultSetMetaData resultMetas = results.getMetaData();
										while(results.next()){         
									        for(int j = 1; j <= resultMetas.getColumnCount(); j+=4){
									        	textAreaPatientsProvinceIndice.append(results.getString(j)
									        			+ " \t "+results.getString(j+1)+" \t "+results.getString(j+2)+"\n");
									        }
										}
									}catch(Exception ex){
										JOptionPane.showMessageDialog(null, ex.getMessage());
									}
								}
							}
						}
					}catch(Exception ex){
						if(!ex.getMessage().startsWith("Exhausted Resultset")){
							JOptionPane.showMessageDialog(null, ex.getMessage());
						}
					}
				}
			}
		});
		
		//Bouton Modifier Patient
		btnModifierPatient.setBounds(549, 247, 145, 23);
		getContentPane().add(btnModifierPatient);
		btnModifierPatient.addActionListener(new ActionListener() {
			public void actionPerformed(ActionEvent click) {
				//Informations sur le patient
				if (!txtNoEtude.getText().equals("")){
					label:try{
						//On demande le numéro du patient à modifier
						String noPatient= JOptionPane.showInputDialog("Veuillez entrer le numéro du patient à modifier:");
						//les requêtes SQL DML qui retournent des données
						String sql = "select NO_PATIENT from TP2_PATIENT";
						ResultSet rs = stmt.executeQuery(sql);
						//Obtention des méta-données de la colonne
						ResultSetMetaData rsmd = rs.getMetaData();
						
						//Verification du numero de patient
						boolean patientExiste = false;
						while(rs.next()){
							for(int i = 1; i <= rsmd.getColumnCount(); i++){
								if(noPatient.equals(rs.getString(i))){
									patientExiste = true;
								}
							}
						}
						if (!patientExiste){
							JOptionPane.showMessageDialog(null, "Ce numéro de patient est inexistant");
							break label;
						}

						try{
							//les requêtes SQL DML qui retournent des données
							ResultSet ras = stmt.executeQuery("select PROVINCE_PAT, INDICE_EFFICACITE_METABO_PAT "
									+ "from TP2_PATIENT where NO_PATIENT= \'"+ noPatient +"\'");
							
							String province="";
							String indice="";
							while(ras.next()){
								province=ras.getObject(1).toString();
								indice=ras.getObject(2).toString();
							}
							
							//Modification province
							String nouvelleProvince= JOptionPane.showInputDialog("La province actuelle est "
									+ province + ", veuillez entrer une nouvelle province:");
							String ModifierProvince = "update TP2_PATIENT set PROVINCE_PAT = \'"+ nouvelleProvince
									+ "\'" +"where NO_PATIENT = \'" + noPatient +"\'";
							stmt.executeUpdate(ModifierProvince);
							JOptionPane.showMessageDialog(null, "Province du patient modifiée");
							textAreaPatientsProvinceIndice.setText(null);
							ResultSet results = stmt.executeQuery("select C.NO_PATIENT, C.PROVINCE_PAT, "
									+ "C.INDICE_EFFICACITE_METABO_PAT, D.NO_ETUDE "
									+ "from TP2_PATIENT C, TP2_ETUDE_PATIENT D "
									+ "where C.NO_PATIENT = D.NO_PATIENT "
									+ "and D.NO_ETUDE = \'" + txtNoEtude.getText() +"\' ");
							ResultSetMetaData resultMetas = results.getMetaData();
							while(results.next()){         
						        for(int j = 1; j <= resultMetas.getColumnCount(); j+=4){
						        	textAreaPatientsProvinceIndice.append(results.getString(j)+" \t "
						        			+ results.getString(j+1)+" \t "+results.getString(j+2)+"\n");
						        }
							}
							
							//Modification indice
							String nouvelIndice= JOptionPane.showInputDialog("L'indice d'efficacité métabolique"
									+ " actuel est: "+indice
									+ ", veuillez entrer un nouvel indice:");
							String ModifierIndice = "update TP2_PATIENT set INDICE_EFFICACITE_METABO_PAT = \'"
									+ nouvelIndice + "\'" +"where NO_PATIENT = \'" + noPatient +"\'";
							stmt.executeUpdate(ModifierIndice);
							JOptionPane.showMessageDialog(null, "Indice d'efficacité métabolique modifié");
							textAreaPatientsProvinceIndice.setText(null);
							ResultSet results2 = stmt.executeQuery("select C.NO_PATIENT, C.PROVINCE_PAT, "
									+ "C.INDICE_EFFICACITE_METABO_PAT, D.NO_ETUDE "
									+ "from TP2_PATIENT C, TP2_ETUDE_PATIENT D "
									+ "where C.NO_PATIENT = D.NO_PATIENT "
									+ "and D.NO_ETUDE = \'" + txtNoEtude.getText() +"\' ");
							ResultSetMetaData resultMetas2 = results2.getMetaData();
							while(results2.next()){         
						        for(int j = 1; j <= resultMetas2.getColumnCount(); j+=4){
						        	textAreaPatientsProvinceIndice.append(results2.getString(j)
						        			+ " \t "+results2.getString(j+1)+" \t "+results2.getString(j+2)+"\n");
						        }
							}
						}catch(Exception ex){
							if (ex.getMessage().startsWith("ORA-01407")){
								JOptionPane.showMessageDialog(null, "La valeur ne peut pas être vide.");
							}
						}
						
					}catch(Exception ex){
						JOptionPane.showMessageDialog(null, ex.getMessage());
					}
				}
			}
		});
		
		//Bouton Quitter
		btnQuitter.setBounds(603, 376, 91, 23);
		getContentPane().add(btnQuitter);
		btnQuitter.addActionListener(new ActionListener(){
			public void actionPerformed(ActionEvent click){
				System.exit(1);
			}
		});
	}
}
