drop table TP2_CENTRE_DE_RECHERCHE cascade constraints;
drop table TP2_PATIENT cascade constraints;
drop table TP2_VARIATION_GENETIQUE cascade constraints;
drop table TP2_FORMULE_MASSE_DROGUE cascade constraints;
drop table TP2_DROGUE cascade constraints;
drop table TP2_FABRICANT cascade constraints;
drop table TP2_DROGUE_VARIANT cascade constraints;
drop table TP2_ARTICLE cascade constraints;
drop table TP2_AUTEUR_ARTICLE cascade constraints;
drop table TP2_ETUDE cascade constraints;
drop table TP2_ETUDE_PATIENT cascade constraints;

/*****************/
/*       1       */
/*****************/

/* a)*/

create table TP2_CENTRE_DE_RECHERCHE
(NO_CENTRE_RECHERCHE varchar2(10) default '0000' not null,
NOM_CEN_RECH varchar2(50) not null,
ADRESSE_CEN_RECH varchar2(50) not null,
VILLE_CEN_RECH varchar2(20) not null,
PROVINCE_CEN_RECH varchar2(30) not null,
constraint PK_CENTRE primary key(NO_CENTRE_RECHERCHE));

create table TP2_PATIENT
(NO_PATIENT varchar2(20) default '0000000UC' not null,
AGE_PAT number(3) default 0 null,
GENRE_PAT char(1) null,
PROVINCE_PAT varchar2(30) not null,
REGION_PAT varchar2(30) null,
INDICE_EFFICACITE_METABO_PAT number(8,2) default 0.0 not null,
constraint PK_PATIENT primary key(NO_PATIENT));

create table TP2_VARIATION_GENETIQUE
(NO_VARIANT_GENETIQUE varchar2(10) default 'rs0000000' not null,
NUCLEOTIDE_REF char(1) not null, 
NUCLEOTIDE_VAR char(1) not null, 
GENE_VAR varchar2(6) not null,
CHROMOSOME_VAR varchar2(2) default '1' not null,
constraint PK_VARIATION primary key(NO_VARIANT_GENETIQUE),
constraint CHROM check (CHROMOSOME_VAR between 1 and 22));

create table TP2_FORMULE_MASSE_DROGUE
(FORMULE_DROGUE varchar2(50) not null,
MASS_MOL_DRO number(8,2) default 0.0 not null,
constraint PK_FORMULE_MASSE primary key(FORMULE_DROGUE));

create table TP2_DROGUE
(NO_DROGUE varchar2(20) default 'ID0000000' not null,
NOM_DRO varchar2(30) not null,
TEMP_DEMIE_VIE_DRO number(8,2) default 0.0 not null,
FORMULE_DROGUE varchar2(50) not null,
URL_DRO varchar2(50) default 'www.fichedrugbank.com/' not null,
DOSE_ENF_DRO number(8,2) default 0.0 not null,
DOSE_ADU_DRO number(8,2) default 0.0 not null,
CONCENTRATION_SANG_DRO number(8,2) default 0.0 not null,
COUT_DRO number(8,2) default 0.0 not null,
constraint PK_DROGUE primary key(NO_DROGUE),
constraint FK_DROGUE foreign key(FORMULE_DROGUE) references TP2_FORMULE_MASSE_DROGUE(FORMULE_DROGUE) on delete cascade,
constraint AK_DROGUE unique(URL_DRO));

create table TP2_FABRICANT
(NO_DROGUE varchar2(20) default 'ID0000000' not null,
NUM_FAB number(10) default 0 not null,
NOM_FAB varchar2(40) not null,
constraint PK_FABRICANT primary key(NO_DROGUE, NUM_FAB),
constraint FK_FABRICANT foreign key(NO_DROGUE) references TP2_DROGUE(NO_DROGUE) on delete cascade,
constraint NUM_POS check (NUM_FAB >= 0));

create table TP2_DROGUE_VARIANT
(NO_DROGUE varchar2(20) default 'ID0000000' not null,
NO_VAR_GEN varchar2(20) default 'rs0000000' not null,
EST_EFFET_TOX number(1) default 0 not null,
EST_EFFET_EFFICACITE number(1) default 0 not null,
EST_EFFET_METABOLISME number(1) default 0 not null,
EST_EFFET_AUTRE number(1) default 0 not null,
INDICE_EFFICACITE_METABO_DV number(8,2) default 0.0 not null,
constraint PK_DROGUE_VAR primary key(NO_DROGUE,NO_VAR_GEN),
constraint FK_DROGUE_VAR foreign key(NO_DROGUE) references TP2_DROGUE(NO_DROGUE) on delete cascade,
constraint FK_DROGUE_VAR2 foreign key(NO_VAR_GEN) references TP2_VARIATION_GENETIQUE(NO_VARIANT_GENETIQUE) on delete cascade,
constraint EFF_TOX check (EST_EFFET_TOX between 0 and 1),
constraint EFF_EFFI check (EST_EFFET_EFFICACITE between 0 and 1),
constraint EFF_META check (EST_EFFET_METABOLISME between 0 and 1),
constraint EFF_AUTRE check (EST_EFFET_AUTRE between 0 and 1));

create table TP2_ARTICLE
(NO_ARTICLE varchar2(50) default 'REF000000' not null,
TITRE_ART varchar2(40) not null,
DATE_ART date not null, 
NOM_REVUE_ART varchar2(40) not null,
NUM_REVUE_ART number(8) not null,
NUM_PAGE_ART number(3) not null,
RESUME_ART varchar2(200) not null,
constraint PK_ARTICLE primary key(NO_ARTICLE),
constraint NUM_REVUE check (NUM_REVUE_ART >= 0),
constraint NUM_PAGE check (NUM_PAGE_ART > 0));

create table TP2_AUTEUR_ARTICLE
(NO_ARTICLE varchar2(50) default 'REF000000' not null,
NUM_AUTEUR number(10) not null,
AUTEUR varchar2(50) not null,
constraint PK_AUTEUR primary key(NO_ARTICLE,NUM_AUTEUR),
constraint FK_AUTEUR foreign key(NO_ARTICLE) references TP2_ARTICLE(NO_ARTICLE) on delete cascade,
constraint NUM_AUT check (NUM_AUTEUR >= 0));

create table TP2_ETUDE
(NO_ETUDE varchar2(20) default 'N0000000' not null,
NO_CEN_RECH varchar2(10) default '0000' not null,
NO_DROGUE varchar2(20) default 'ID0000000' not null,
NO_VAR_GEN varchar2(20) default 'rs0000000' not null,
NO_ARTICLE varchar2(10) default 'REF000000' not null,
NO_ETUDE_PARENT varchar2(20),
DATE_DEBUT_ET date not null,
DATE_FIN_ET date not null,
TITRE_ET varchar2(40) not null,
constraint PK_ETUDE primary key(NO_ETUDE),
constraint FK_ETUDE foreign key(NO_CEN_RECH) references TP2_CENTRE_DE_RECHERCHE(NO_CENTRE_RECHERCHE) on delete cascade,
constraint FK_ETUDE2 foreign key(NO_DROGUE) references TP2_DROGUE(NO_DROGUE) on delete cascade,
constraint FK_ETUDE3 foreign key(NO_VAR_GEN) references TP2_VARIATION_GENETIQUE(NO_VARIANT_GENETIQUE) on delete cascade,
constraint FK_ETUDE4 foreign key(NO_ARTICLE) references TP2_ARTICLE(NO_ARTICLE) on delete cascade,
constraint FK_ETUDE5 foreign key(NO_ETUDE_PARENT) references TP2_ETUDE(NO_ETUDE) on delete cascade);

create table TP2_ETUDE_PATIENT
(NO_ETUDE varchar2(20) default 'N0000000' not null,
NUM_PATIENT_ETUDE number(10) not null,
NO_PATIENT varchar2(20) default '0000000UC' not null,
constraint PK_ETUDE_PAT primary key(NO_ETUDE,NUM_PATIENT_ETUDE),
constraint FK_ETUDE_PAT foreign key(NO_ETUDE) references TP2_ETUDE(NO_ETUDE) on delete cascade,
constraint FK_ETUDE_PAT2 foreign key(NO_PATIENT) references TP2_PATIENT(NO_PATIENT) on delete cascade,
constraint NUM_PATIENT check (NUM_PATIENT_ETUDE >= 0));


/* b)*/

insert into TP2_CENTRE_DE_RECHERCHE (NO_CENTRE_RECHERCHE, NOM_CEN_RECH, ADRESSE_CEN_RECH, VILLE_CEN_RECH, PROVINCE_CEN_RECH)
    values('8000','Centre de recherche scientifico','2222 Rue de la medecine','Montréal','Québec');
insert into TP2_CENTRE_DE_RECHERCHE (NO_CENTRE_RECHERCHE, NOM_CEN_RECH, ADRESSE_CEN_RECH, VILLE_CEN_RECH, PROVINCE_CEN_RECH)
    values('7555', 'Centre de recherche du CHUL', '3000 Rue de la paix', 'Québec', 'Québec');
insert into TP2_CENTRE_DE_RECHERCHE (NO_CENTRE_RECHERCHE, NOM_CEN_RECH, ADRESSE_CEN_RECH, VILLE_CEN_RECH, PROVINCE_CEN_RECH)
    values('6000', 'Centre de recherche international', '1000 Rue des rosiers', 'Ottawa', 'Ontario');
insert into TP2_CENTRE_DE_RECHERCHE (NO_CENTRE_RECHERCHE, NOM_CEN_RECH, ADRESSE_CEN_RECH, VILLE_CEN_RECH, PROVINCE_CEN_RECH)
    values('3984', 'Centre de pharmacologie', '2344 Rue des cerisiers', 'Repentigny', 'Québec');
insert into TP2_CENTRE_DE_RECHERCHE (NO_CENTRE_RECHERCHE, NOM_CEN_RECH, ADRESSE_CEN_RECH, VILLE_CEN_RECH, PROVINCE_CEN_RECH)
    values('9375', 'Centre medical opera', '3947 Rue du commerce', 'Vancouver', 'Colombie-Britannique');

insert into TP2_PATIENT (NO_PATIENT, AGE_PAT, GENRE_PAT, PROVINCE_PAT, REGION_PAT, INDICE_EFFICACITE_METABO_PAT)
    values('1004444UC', 33, 'H', 'Québec', 'Capitale nationale', 0.35);
insert into TP2_PATIENT (NO_PATIENT, AGE_PAT, GENRE_PAT, PROVINCE_PAT, REGION_PAT, INDICE_EFFICACITE_METABO_PAT)
    values('1004455UC', 22, 'F', 'Québec', 'Centre du québec', 0.55);
insert into TP2_PATIENT (NO_PATIENT, AGE_PAT, GENRE_PAT, PROVINCE_PAT, REGION_PAT, INDICE_EFFICACITE_METABO_PAT)
    values('1004433UC', 45, 'H', 'Ontario', 'Ontario', 0.66);
insert into TP2_PATIENT (NO_PATIENT, AGE_PAT, GENRE_PAT, PROVINCE_PAT, REGION_PAT, INDICE_EFFICACITE_METABO_PAT)
    values('1004422UC', 66, 'H', 'Alberta', 'Prairies', 0.11);      
insert into TP2_PATIENT (NO_PATIENT, AGE_PAT, GENRE_PAT, PROVINCE_PAT, REGION_PAT, INDICE_EFFICACITE_METABO_PAT)
    values('1004477UC', 55, 'F', 'Yukon', 'Yukon', 0.88);      
      
insert into TP2_VARIATION_GENETIQUE (NO_VARIANT_GENETIQUE, NUCLEOTIDE_REF, NUCLEOTIDE_VAR, GENE_VAR, CHROMOSOME_VAR)
    values('rs1118375', 'G', 'C', 'UGA1A', '18');
insert into TP2_VARIATION_GENETIQUE (NO_VARIANT_GENETIQUE, NUCLEOTIDE_REF, NUCLEOTIDE_VAR, GENE_VAR, CHROMOSOME_VAR)
    values('rs1118333', 'A', 'T', 'CYP1C2', '3');      
insert into TP2_VARIATION_GENETIQUE (NO_VARIANT_GENETIQUE, NUCLEOTIDE_REF, NUCLEOTIDE_VAR, GENE_VAR, CHROMOSOME_VAR)
    values('rs1118555', 'C', 'A', 'CYP2D3', '20');      
insert into TP2_VARIATION_GENETIQUE (NO_VARIANT_GENETIQUE, NUCLEOTIDE_REF, NUCLEOTIDE_VAR, GENE_VAR, CHROMOSOME_VAR)
    values('rs1118445', 'T', 'A', 'UAT1A', '10');      
insert into TP2_VARIATION_GENETIQUE (NO_VARIANT_GENETIQUE, NUCLEOTIDE_REF, NUCLEOTIDE_VAR, GENE_VAR, CHROMOSOME_VAR)
    values('rs1117755', 'G', 'A', 'UAC1A', '18');
      
insert into TP2_FORMULE_MASSE_DROGUE (FORMULE_DROGUE, MASS_MOL_DRO)
    values('C18H21NO3', 299.36);
insert into TP2_FORMULE_MASSE_DROGUE (FORMULE_DROGUE, MASS_MOL_DRO)
    values('C10H10NO4', 208.19);      
insert into TP2_FORMULE_MASSE_DROGUE (FORMULE_DROGUE, MASS_MOL_DRO)
    values('C8H9NO2', 151.16);      
insert into TP2_FORMULE_MASSE_DROGUE (FORMULE_DROGUE, MASS_MOL_DRO)
    values('C9H8O4', 180.15);      
insert into TP2_FORMULE_MASSE_DROGUE (FORMULE_DROGUE, MASS_MOL_DRO)
    values('C17H13ClN4', 308.76);
      
insert into TP2_DROGUE (NO_DROGUE, NOM_DRO, TEMP_DEMIE_VIE_DRO, FORMULE_DROGUE, URL_DRO, DOSE_ENF_DRO, DOSE_ADU_DRO, CONCENTRATION_SANG_DRO, COUT_DRO)
    values('ID9375937', 'Codeine', 180, 'C18H21NO3', 'http://www.drugbank.ca/drugs/DB00318', 30.00, 50.00, 10.00, 200.00);
insert into TP2_DROGUE (NO_DROGUE, NOM_DRO, TEMP_DEMIE_VIE_DRO, FORMULE_DROGUE, URL_DRO, DOSE_ENF_DRO, DOSE_ADU_DRO, CONCENTRATION_SANG_DRO, COUT_DRO)
    values('ID9375444', 'Aspirine', 120, 'C10H10NO4', 'www.fichedrugbank.com/ID9375444', 10.00, 20.00, 20.0, 555.50);      
insert into TP2_DROGUE (NO_DROGUE, NOM_DRO, TEMP_DEMIE_VIE_DRO, FORMULE_DROGUE, URL_DRO, DOSE_ENF_DRO, DOSE_ADU_DRO, CONCENTRATION_SANG_DRO, COUT_DRO)
    values('ID9375333', 'Paracétamole', 120, 'C8H9NO2', 'http://www.drugbank.ca/drugs/DB00316', 60.00, 1000.00, 10.00, 50.00);     
insert into TP2_DROGUE (NO_DROGUE, NOM_DRO, TEMP_DEMIE_VIE_DRO, FORMULE_DROGUE, URL_DRO, DOSE_ENF_DRO, DOSE_ADU_DRO, CONCENTRATION_SANG_DRO, COUT_DRO)
    values('ID9375222', 'Acetasol', 300, 'C9H8O4', 'http://www.drugbank.ca/drugs/DB03166', 50.00, 1000.00, 10.00, 10.00);   
insert into TP2_DROGUE (NO_DROGUE, NOM_DRO, TEMP_DEMIE_VIE_DRO, FORMULE_DROGUE, URL_DRO, DOSE_ENF_DRO, DOSE_ADU_DRO, CONCENTRATION_SANG_DRO, COUT_DRO)
    values('ID9375111', 'Alprazolam', 900, 'C17H13ClN4', 'www.fichedrugbank.com/ID9375111', 0.25, 4.00, 60.00, 400.00);      

insert into TP2_FABRICANT (NO_DROGUE, NUM_FAB, NOM_FAB)
    values('ID9375111', '93753', 'GSK');
insert into TP2_FABRICANT (NO_DROGUE, NUM_FAB, NOM_FAB)
    values('ID9375222', '23753', 'Allergan');
insert into TP2_FABRICANT (NO_DROGUE, NUM_FAB, NOM_FAB)
    values('ID9375333', '31764', 'Medicomaniac');      
insert into TP2_FABRICANT (NO_DROGUE, NUM_FAB, NOM_FAB)
    values('ID9375444', '37593', 'CPM');      
insert into TP2_FABRICANT (NO_DROGUE, NUM_FAB, NOM_FAB)
    values('ID9375937', '94862', 'MSN');      
      
insert into TP2_DROGUE_VARIANT (NO_DROGUE, NO_VAR_GEN, EST_EFFET_TOX, EST_EFFET_EFFICACITE, EST_EFFET_METABOLISME, EST_EFFET_AUTRE, INDICE_EFFICACITE_METABO_DV)      
    values('ID9375937', 'rs1118375', 1, 1, 1, 0, 1.33);
insert into TP2_DROGUE_VARIANT (NO_DROGUE, NO_VAR_GEN, EST_EFFET_TOX, EST_EFFET_EFFICACITE, EST_EFFET_METABOLISME, EST_EFFET_AUTRE, INDICE_EFFICACITE_METABO_DV)      
    values('ID9375444', 'rs1118333', 0, 1, 1, 0, 0.33);      
insert into TP2_DROGUE_VARIANT (NO_DROGUE, NO_VAR_GEN, EST_EFFET_TOX, EST_EFFET_EFFICACITE, EST_EFFET_METABOLISME, EST_EFFET_AUTRE, INDICE_EFFICACITE_METABO_DV)      
    values('ID9375333', 'rs1118555', 0, 0, 1, 0, 1.11);      
insert into TP2_DROGUE_VARIANT (NO_DROGUE, NO_VAR_GEN, EST_EFFET_TOX, EST_EFFET_EFFICACITE, EST_EFFET_METABOLISME, EST_EFFET_AUTRE, INDICE_EFFICACITE_METABO_DV)      
    values('ID9375222', 'rs1118445', 1, 0, 1, 0, 0.88);      
insert into TP2_DROGUE_VARIANT (NO_DROGUE, NO_VAR_GEN, EST_EFFET_TOX, EST_EFFET_EFFICACITE, EST_EFFET_METABOLISME, EST_EFFET_AUTRE, INDICE_EFFICACITE_METABO_DV)      
    values('ID9375111', 'rs1117755', 1, 0, 0, 1, 0.66);      
    
insert into TP2_ARTICLE (NO_ARTICLE, TITRE_ART, DATE_ART, NOM_REVUE_ART, NUM_REVUE_ART, NUM_PAGE_ART, RESUME_ART)     
    values('REF111111', 'Nouvelle variante découverte!', date '2010-04-30', 'Planète science', 1000, 98, 'Nouvelle variante découverte récemment par les médecins...');
insert into TP2_ARTICLE (NO_ARTICLE, TITRE_ART, DATE_ART, NOM_REVUE_ART, NUM_REVUE_ART, NUM_PAGE_ART, RESUME_ART)     
    values('REF111345', 'Médicaments efficaces', date '2015-11-20', 'Pharmaticomanie', 333, 33, 'Découvrez la liste des médicaments les plus efficaces...');      
insert into TP2_ARTICLE (NO_ARTICLE, TITRE_ART, DATE_ART, NOM_REVUE_ART, NUM_REVUE_ART, NUM_PAGE_ART, RESUME_ART)     
    values('REF111234', 'Nouveaux médicaments', date '2004-05-15', 'Univers médical', 350, 50, 'Le centre de recherche nous fait un résumé des derniers médicaments découverts...');      
insert into TP2_ARTICLE (NO_ARTICLE, TITRE_ART, DATE_ART, NOM_REVUE_ART, NUM_REVUE_ART, NUM_PAGE_ART, RESUME_ART)     
    values('REF111112', 'Informations exclusives de la variante', date '2010-04-30', 'Planète science', 1000, 100, 'Découvrez plus en détail les informations de la nouvelle variante découverte...');      
insert into TP2_ARTICLE (NO_ARTICLE, TITRE_ART, DATE_ART, NOM_REVUE_ART, NUM_REVUE_ART, NUM_PAGE_ART, RESUME_ART)     
    values('REF113455', 'Aspirine : Plus dangeureuse que prévue?', date '2000-08-11', 'Univers science', 1356, 20, 'Les nombreuses recherches démontrent que cette drogue peut être très dangereuse...');
      
insert into TP2_AUTEUR_ARTICLE (NO_ARTICLE, NUM_AUTEUR, AUTEUR)
    values('REF111111', 294034, 'Leeder J S');
insert into TP2_AUTEUR_ARTICLE (NO_ARTICLE, NUM_AUTEUR, AUTEUR)
    values('REF111345', 234235, 'Gaedigk A');      
insert into TP2_AUTEUR_ARTICLE (NO_ARTICLE, NUM_AUTEUR, AUTEUR)
    values('REF111234', 265464, 'Forbes N S');      
insert into TP2_AUTEUR_ARTICLE (NO_ARTICLE, NUM_AUTEUR, AUTEUR)
    values('REF111112', 247654, 'Kearns G L');      
insert into TP2_AUTEUR_ARTICLE (NO_ARTICLE, NUM_AUTEUR, AUTEUR)
    values('REF113455', 245647, 'Simon S D');
      
insert into TP2_ETUDE (NO_ETUDE, NO_CEN_RECH, NO_DROGUE, NO_VAR_GEN, NO_ARTICLE, DATE_DEBUT_ET, DATE_FIN_ET, TITRE_ET)      
    values('N9475234', '8000', 'ID9375937', 'rs1118375', 'REF111111', date '2006-12-06', date '2007-11-28', 'Étude variante rs1118375');
insert into TP2_ETUDE (NO_ETUDE, NO_CEN_RECH, NO_DROGUE, NO_VAR_GEN, NO_ARTICLE, DATE_DEBUT_ET, DATE_FIN_ET, TITRE_ET)      
    values('N9475244', '6000', 'ID9375444', 'rs1118333', 'REF111345', date '2012-10-15', date '2013-09-23', 'Étude variante rs1118333');      
insert into TP2_ETUDE (NO_ETUDE, NO_CEN_RECH, NO_DROGUE, NO_VAR_GEN, NO_ARTICLE, NO_ETUDE_PARENT, DATE_DEBUT_ET, DATE_FIN_ET, TITRE_ET)      
    values('N9479388', '9375', 'ID9375333', 'rs1118555', 'REF111234', 'N9475234', date '2000-03-29', date '2010-10-02', 'Étude variante rs1118555');      
insert into TP2_ETUDE (NO_ETUDE, NO_CEN_RECH, NO_DROGUE, NO_VAR_GEN, NO_ARTICLE, NO_ETUDE_PARENT, DATE_DEBUT_ET, DATE_FIN_ET, TITRE_ET)      
    values('N9478837', '7555', 'ID9375222', 'rs1118445', 'REF111112', 'N9475234', date '2015-01-19', date '2016-02-23', 'Étude variante rs1118445');      
insert into TP2_ETUDE (NO_ETUDE, NO_CEN_RECH, NO_DROGUE, NO_VAR_GEN, NO_ARTICLE, NO_ETUDE_PARENT, DATE_DEBUT_ET, DATE_FIN_ET, TITRE_ET)      
    values('N9476384', '3984', 'ID9375111', 'rs1117755', 'REF113455', 'N9475244', date '2008-05-30', date '2013-03-30', 'Étude variante rs1117755');
      
insert into TP2_ETUDE_PATIENT (NO_ETUDE, NUM_PATIENT_ETUDE, NO_PATIENT)
    values('N9475234', 3957395, '1004422UC');
insert into TP2_ETUDE_PATIENT (NO_ETUDE, NUM_PATIENT_ETUDE, NO_PATIENT)
    values('N9475244', 3903857, '1004433UC');      
insert into TP2_ETUDE_PATIENT (NO_ETUDE, NUM_PATIENT_ETUDE, NO_PATIENT)
    values('N9479388', 3843995, '1004444UC');      
insert into TP2_ETUDE_PATIENT (NO_ETUDE, NUM_PATIENT_ETUDE, NO_PATIENT)
    values('N9478837', 3900293, '1004455UC');      
insert into TP2_ETUDE_PATIENT (NO_ETUDE, NUM_PATIENT_ETUDE, NO_PATIENT)
    values('N9476384', 3823563, '1004477UC');
insert into TP2_ETUDE_PATIENT (NO_ETUDE, NUM_PATIENT_ETUDE, NO_PATIENT)
    values('N9475234', 3957394, '1004455UC');      
 
/* c) */     
delete from TP2_DROGUE
    where COUT_DRO > 300;
      
/* d) */      
update TP2_DROGUE
    set COUT_DRO = COUT_DRO * 0.15
    where NO_DROGUE =
        (select NO_DROGUE
            from TP2_FABRICANT 
            where NOM_FAB = 'GSK');

/* e) */      
update TP2_FABRICANT
    set NOM_FAB = 'Pfizer'
    where NOM_FAB = 'Allergan' 
    and NO_DROGUE =
        (select NO_DROGUE
            from TP2_DROGUE
            where NOM_DRO = 'Acetasol');

/* f) */
select C.NOM_CEN_RECH, D.NOM_DRO
    from TP2_CENTRE_DE_RECHERCHE C, TP2_DROGUE D, TP2_ETUDE E
    where C.NO_CENTRE_RECHERCHE = E.NO_CEN_RECH
    and D.NO_DROGUE = E.NO_DROGUE
    and E.NO_ETUDE_PARENT is null;

/* g) */
/* i) */
create or replace function TP2_FCT_REGROUPEMENT_AUTEURS (PI_NO_ARTICLE  in  TP2_AUTEUR_ARTICLE.NO_ARTICLE%type)
    return varchar2
is
    V_TEXTE_AUTEURS varchar2(100);
begin
    for x in 
        (select AUTEUR 
            from TP2_AUTEUR_ARTICLE 
            where NO_ARTICLE = PI_NO_ARTICLE) 
            loop
                V_TEXTE_AUTEURS := V_TEXTE_AUTEURS || ', ' || x.AUTEUR;
            end loop;
    return ltrim(V_TEXTE_AUTEURS, ',');
end;
/

select TITRE_ART, NOM_REVUE_ART, DATE_ART, TP2_FCT_REGROUPEMENT_AUTEURS(NO_ARTICLE) as AUTEURS
    from TP2_ARTICLE
    where NO_ARTICLE in 
        (select NO_ARTICLE
            from TP2_ETUDE
            where NO_CEN_RECH in
                (select NO_CENTRE_RECHERCHE
                    from TP2_CENTRE_DE_RECHERCHE
                    where NOM_CEN_RECH = 'Université Laval'));

/* ii) */
select A.TITRE_ART, A.NOM_REVUE_ART, A.DATE_ART, TP2_FCT_REGROUPEMENT_AUTEURS(A.NO_ARTICLE) as AUTEURS
    from TP2_ARTICLE A
    join TP2_ETUDE E
    on A.NO_ARTICLE = E.NO_ARTICLE
    join TP2_CENTRE_DE_RECHERCHE C
    on E.NO_CEN_RECH = C.NO_CENTRE_RECHERCHE
    where C.NOM_CEN_RECH = 'Université Laval';

/* iii) */
select TITRE_ART, NOM_REVUE_ART, DATE_ART, TP2_FCT_REGROUPEMENT_AUTEURS(NO_ARTICLE) as AUTEURS
    from TP2_ARTICLE
    where exists
        (select NO_ARTICLE
            from TP2_ETUDE
            where TP2_ARTICLE.NO_ARTICLE = TP2_ETUDE.NO_ARTICLE
            and exists
                (select NO_CENTRE_RECHERCHE
                    from TP2_CENTRE_DE_RECHERCHE
                    where TP2_ETUDE.NO_CEN_RECH = TP2_CENTRE_DE_RECHERCHE.NO_CENTRE_RECHERCHE
                    and NOM_CEN_RECH = 'Université Laval'));

/* h) */
select NUM_FAB, NOM_FAB, count(TP2_FABRICANT.NO_DROGUE) as NB_DRO,  sum(TP2_DROGUE.COUT_DRO) as SUM_DROGUE, max(TP2_DROGUE.COUT_DRO) as MAX_COUT,  min(TP2_DROGUE.COUT_DRO) as MIN_COUT
    from TP2_FABRICANT, TP2_DROGUE
    where TP2_DROGUE.NO_DROGUE = TP2_FABRICANT.NO_DROGUE
    group by NOM_FAB, NUM_FAB;

/* i) */
/* i) */
select TITRE_ET
    from TP2_ETUDE
    where NO_CEN_RECH in
        (select NO_CENTRE_RECHERCHE
            from TP2_CENTRE_DE_RECHERCHE
            where NOM_CEN_RECH = 'Centre de recherche du CHUL')
    and NO_DROGUE in
        (select NO_DROGUE 
            from TP2_DROGUE_VARIANT
            where EST_EFFET_AUTRE != 1);

/* ii) */
select TITRE_ET
    from TP2_ETUDE
    where NO_DROGUE in
        (select NO_DROGUE
            from TP2_ETUDE
            minus
        select NO_DROGUE
            from TP2_DROGUE_VARIANT
            where EST_EFFET_AUTRE = 1)
    and NO_CEN_RECH in
        (select NO_CENTRE_RECHERCHE
            from TP2_CENTRE_DE_RECHERCHE
            where NOM_CEN_RECH = 'Centre de recherche du CHUL');
    
 /* iii) */   
select TITRE_ET
    from TP2_ETUDE
    where NO_CEN_RECH in
        (select NO_CENTRE_RECHERCHE
            from TP2_CENTRE_DE_RECHERCHE
            where NOM_CEN_RECH = 'Centre de recherche du CHUL')
    and not exists
        (select NO_DROGUE 
            from TP2_DROGUE_VARIANT
            where EST_EFFET_AUTRE = 1);

/* j) */
select NOM_DRO
    from TP2_DROGUE
    where NO_DROGUE in
        (select NO_DROGUE
            from TP2_ETUDE
            where sysdate - DATE_DEBUT_ET < 548);

/* k) */
/* i) */
create or replace view TP2_HIERARCHIE_ETUDES
    as select 
        substr((lpad(' ', (LEVEL*2)-2, ' ') || E.NO_ETUDE),1,16) as ARBRE,
        substr(D.NOM_DRO,1,14) as NOM_DRO,
        substr(E.NO_VAR_GEN,1,12) as NO_VAR_GEN,
        substr(C.NOM_CEN_RECH,1,32) as NOM_CENTRE_RECH,
        substr((sys_connect_by_path(E.NO_ETUDE, '/')),1,32) as CHEMIN
        from TP2_ETUDE E, TP2_DROGUE D, TP2_CENTRE_DE_RECHERCHE C
        where E.NO_DROGUE = D.NO_DROGUE
        and E.NO_CEN_RECH = C.NO_CENTRE_RECHERCHE
        connect by prior E.NO_ETUDE = E.NO_ETUDE_PARENT
        start with E.NO_ETUDE_PARENT is null
    with check option;

/* ii) */
select *
    from  TP2_HIERARCHIE_ETUDES;

/* iii) */
/*
insert into TP2_HIERARCHIE_ETUDES(NO_VAR_GEN)
    values('rs1118888');
*/
-- Cette opération est impossible parce que les attributs affichés dans la vue proviennent de plusieurs tables.


/*****************/
/*       2       */
/*****************/

/* a) */
create or replace trigger TP2_TRG_INSERTION_ETUDE_PAT
    before insert on TP2_ETUDE_PATIENT
    for each row
declare
    V_DEBUT_ETUDE TP2_ETUDE.DATE_DEBUT_ET%type;
    V_FIN_ETUDE TP2_ETUDE.DATE_FIN_ET%type;
    V_PROVINCE_PAT TP2_PATIENT.PROVINCE_PAT%type;
    V_PROVINCE_ETUDE TP2_CENTRE_DE_RECHERCHE.PROVINCE_CEN_RECH%type;
begin
    select DATE_DEBUT_ET, DATE_FIN_ET
        into V_DEBUT_ETUDE, V_FIN_ETUDE
        from TP2_ETUDE
        where NO_ETUDE = :new.NO_ETUDE;
    select PROVINCE_PAT
        into V_PROVINCE_PAT
        from TP2_PATIENT
        where NO_PATIENT = :new.NO_PATIENT;
    select PROVINCE_CEN_RECH
        into V_PROVINCE_ETUDE
        from TP2_CENTRE_DE_RECHERCHE
        where NO_CENTRE_RECHERCHE in 
            (select NO_CEN_RECH
                from TP2_ETUDE
                where NO_ETUDE = :new.NO_ETUDE);
    if sysdate > V_FIN_ETUDE 
    or sysdate < V_DEBUT_ETUDE then
            raise_application_error(-20050,'L''étude n''est pas en cours présentement.');
    elsif V_PROVINCE_PAT != V_PROVINCE_ETUDE then
        raise_application_error(-20051,'La province du patient n''est pas la même que celle du centre de recherche.');
    end if;
end;
/

/* b) */
create or replace trigger TP2_TRG_MODIFICATION_ETUDE
    before update on TP2_ETUDE
    for each row
begin
    if :new.NO_ETUDE != :old.NO_ETUDE or 
        :new.NO_CEN_RECH != :old.NO_CEN_RECH or
        :new.NO_DROGUE != :old.NO_DROGUE or
        :new.NO_VAR_GEN != :old.NO_VAR_GEN or
        :new.TITRE_ET != :old.TITRE_ET then
            raise_application_error(-20052,'Impossible de modifier ce champ');
    end if;
    if :new.DATE_DEBUT_ET > :new.DATE_FIN_ET then
        raise_application_error(-20053,'Les dates entrées sont invalides');
    end if;
end;
/

/* c) */
create or replace function TP2_FCT_INFO_DROGUE(PI_NO_DROGUE in TP2_DROGUE.NO_DROGUE%type)
    return varchar2
is
    V_INFO_DROGUE varchar2(81);
begin
    for x in
        (select NOM_DRO, URL_DRO
            from TP2_DROGUE
            where NO_DROGUE = PI_NO_DROGUE) 
    loop
        V_INFO_DROGUE := V_INFO_DROGUE  || x.NOM_DRO ||' ' || x.URL_DRO;
    end loop;
    return ltrim(V_INFO_DROGUE);
end;
/

/* e) */
/* Déclencheur pour limiter le genre du patient à 'H' ou 'F'. Si ce n'est pas respecté une erreur sera déclenchée.*/
create or replace trigger TP2_TRG_LIMITATION_GENRE_PAT
    before update on TP2_PATIENT 
    for each row
begin
    if :new.GENRE_PAT != 'H'
    and :new.GENRE_PAT != 'F' then
        raise_application_error(-20054,'Erreur : Le genre du patient doit valoir ''H'' ou ''F''.');
    end if;
end;
/

/*Procédure qui compte le nombre de patient qui ont l'âge entré en paramètre et stocke la valeur dans un paramètre sortant*/
create or replace procedure TP2_SP_COMPTE_PAT_SELON_AGE(PI_AGE_PATIENT in TP2_PATIENT.AGE_PAT%type, PO_NB_PATIENT out TP2_PATIENT.AGE_PAT%type)
is
begin
    select count(*)
        into PO_NB_PATIENT
        from TP2_PATIENT
        where AGE_PAT = PI_AGE_PATIENT;                              
end;
/

/* Déclencheur pour vérifier si la drogue a un effet toxique ou pas (On vérifie donc le booléen)*/
create or replace trigger TP2_TRG_VERIF_EST_TOX
    before update on TP2_DROGUE_VARIANT
    for each row
begin
    if :new.EST_EFFET_TOX != 0
    and :new.EST_EFFET_TOX != 1 then
        raise_application_error(-20056,'Erreur : La toxicité de la drogue doit valoir true (1) ou false (0).');
    end if;
end;
/

/*****************/
/*       3       */
/*****************/
/* a) */
/* i) */
/*
On crée un index pour le nom de drogue, le nom de gène, le nom d'auteur et le titre d'article parce que ce sont des attributs qui contiennent beaucoup
de valeurs différentes. L'indexation permettra donc de trouver ces valeurs plus rapidement. On considère ici que le nom d'article ne constitue pas une
chaîne de caractères trop longue.

Il n'est pas suggéré de créer un index sur une longue chaîne de caractères, donc il est préférable de ne pas faire d'index pour les résumés d'articles.
*/
create index TP2_IDX_NOM_DRO on TP2_DROGUE (NOM_DRO);

create index TP2_IDX_GENE on TP2_VARIATION_GENETIQUE (GENE_VAR);

create index TP2_IDX_AUTEUR on TP2_AUTEUR_ARTICLE (AUTEUR);

create index TP2_IDX_TITRE_ART on TP2_ARTICLE (TITRE_ART);

/* ii) */
/*
Si le centre de recherche voulait rechercher des données selon l'origine des études passées, il serait intéressant d'avoir un index sur la province et la
région d'origine des centres de recherche.

Si le centre de recherche voulait rechercher les drogues selon le fabricant, on peut imaginer que les performances seraient améliorées avec un index
sur le nom du fabricant.

Si le centre de recherche voulait rechercher les études selon leur date de début, on pourrait améliorer la rapidité des requêtes avec un index sur la date
de début de l'étude
*/
create index TP2_IDX_PROV_REGION_CEN_RECH on TP2_CENTRE_DE_RECHERCHE (PROVINCE_CEN_RECH,VILLE_CEN_RECH);

create index TP2_IDX_FABRICANT on TP2_FABRICANT (NOM_FAB);

create index TP2_IDX_DATE_DEBUT_ET on TP2_ETUDE (DATE_DEBUT_ET);

/* b) */
/* i) */
/*
1- Dans la table ETUDE, il y a une clé étrangère NO_CEN_RECH, on peut donc la joindre avec la table CENTRE_DE_RECHERCHE 
à l'aide de la méthode d'association 1:* pour les clés étrangères, on obtient ainsi la table:
ETUDE (NO_ETUDE, NO_CENTRE_RECHERCHE, NOM_CEN_RECH, ADRESSE_CEN_RECH, VILLE_CEN_RECH, PROVINCE_CEN_RECH, NO_DROGUE, 
NO_VAR_GEN, NO_ARTICLE , NO_ETUDE_PARENT, DATE_DEBUT_ET, DATE_FIN_ET, TITRE_ET)
Cette dénormalisation de la table ETUDE permet de réduire les jointures lors de la recherche d un centre de recherche pour 
une étude donnée ou lorsqu il y a des contraintes de spécification par rapport aux centres de recherche. 

2- Puisqu il est souvent pertinant de savoir quelle est la masse moléculaire d une certaine drogue nous allons
dupliquer l'attribut MASS_MOL_DRO de la table TP2_FORMULE_MASSE_DROGUE dans la table TP2_DROGUE. 
On obtient donc la table:
TP2_DROGUE(NO_DROGUE, NOM_DRO,TEMP_DEMIE_VIE_DRO,FORMULE_DROGUE,URL_DRO, DOSE_ENF_DRO,DOSE_ADU_DRO, CONCENTRATION_SANG_DRO, COUT_DRO, MASS_MOL_DRO)  
Cela va nous permettre de diminuer les jointures créées pour savoir le nom du centre de recherche de l etude en jeu dans un
certain article.


/* ii) */
alter table TP2_ETUDE
    add NOM_CEN_RECH varchar2(50) null
    add ADRESSE_CEN_RECH varchar2(50) null
    add VILLE_CEN_RECH varchar2(20) null
    add PROVINCE_CEN_RECH varchar2(30) null; 

update TP2_ETUDE TP2E
set TP2E.NOM_CEN_RECH =
    (select TP2C.NOM_CEN_RECH
        from TP2_CENTRE_DE_RECHERCHE TP2C
        where TP2E.NO_CEN_RECH = TP2C.NO_CENTRE_RECHERCHE ),
TP2E.ADRESSE_CEN_RECH = 
    (select TP2C.ADRESSE_CEN_RECH
        from TP2_CENTRE_DE_RECHERCHE TP2C
        where TP2E.NO_CEN_RECH = TP2C.NO_CENTRE_RECHERCHE ),
TP2E.VILLE_CEN_RECH = 
    (select TP2C.VILLE_CEN_RECH
        from TP2_CENTRE_DE_RECHERCHE TP2C
        where TP2E.NO_CEN_RECH = TP2C.NO_CENTRE_RECHERCHE ),
TP2E.PROVINCE_CEN_RECH = 
    (select TP2C.PROVINCE_CEN_RECH
        from TP2_CENTRE_DE_RECHERCHE TP2C
        where TP2E.NO_CEN_RECH = TP2C.NO_CENTRE_RECHERCHE );

drop table TP2_CENTRE_DE_RECHERCHE cascade constraints;

alter table TP2_DROGUE
    add MASS_MOL_DRO number(8,2) null;

update TP2_DROGUE TP2D
set TP2D.MASS_MOL_DRO = 
    (select TP2F.MASS_MOL_DRO
        from TP2_FORMULE_MASSE_DROGUE TP2F
        where TP2F.MASS_MOL_DRO = TP2D.MASS_MOL_DRO);
     
/* iii) */
create or replace trigger TP2_TRG_BU_ETUDE
    before insert or update on TP2_ETUDE
    for each row
declare
    V_NOM_CEN_RECH varchar2(50);
    V_ADRESSE_CEN_RECH varchar2(50);
    V_VILLE_CEN_RECH varchar2(20);
    V_PROVINCE_CEN_RECH varchar2(30);
begin 
    select NOM_CEN_RECH, ADRESSE_CEN_RECH, VILLE_CEN_RECH, PROVINCE_CEN_RECH
        into V_NOM_CEN_RECH, V_ADRESSE_CEN_RECH, V_VILLE_CEN_RECH, V_PROVINCE_CEN_RECH
        from TP2_CENTRE_DE_REHERCHE
        where NO_CEN_RECH = :new.NO_CEN_RECH;
    :new.NOM_CENTRE_RECHERCHE := V_NOM_CEN_RECH;
    :new.ADRESSE_CEN_RECH := V_ADRESSE_CEN_RECH;
    :new.VILLE_CEN_RECH := V_VILLE_CEN_RECH;
    :new.PROVINCE_CEN_RECH := V_PROVINCE_CEN_RECH;
end;
/

create or replace trigger TP2_TRG_BU_DROGUE
    before insert or update on TP2_DROGUE
    for each row
declare
    V_MASS_MOL_DRO number(8,2);
begin
    select MASS_MOL_DRO into V_MASS_MOL_DRO
    from TP2_FORMULE_MASSE_DROGUE
    where FORMULE_DROGUE = :new.FORMULE_DROGUE;
    :new.MASS_MOL_DRO := V_MASS_MOL_DRO;
end;
/
ALTER TRIGGER TP2_TRG_BU_DROGUE DISABLE;
ALTER TRIGGER TP2_TRG_BU_ETUDE DISABLE;
ALTER TRIGGER TP2_TRG_VERIF_EST_TOX DISABLE;
ALTER TRIGGER TP2_TRG_LIMITATION_GENRE_PAT DISABLE;
ALTER TRIGGER TP2_TRG_MODIFICATION_ETUDE DISABLE;
ALTER TRIGGER TP2_TRG_INSERTION_ETUDE_PAT DISABLE;

create or replace function TP3_FCT_AVG_INDICE_METABO(PI_NO_ETUDE TP2_ETUDE_PATIENT.NO_ETUDE%type)
return number
is
    V_MOYENNE_INDICE_METABO TP2_PATIENT.INDICE_EFFICACITE_METABO_PAT%type;
begin
    select avg(INDICE_EFFICACITE_METABO_PAT)
    into V_MOYENNE_INDICE_METABO
    from TP2_PATIENT 
    where NO_PATIENT in(select NO_PATIENT 
                        from TP2_ETUDE_PATIENT
                        where NO_ETUDE in(select NO_ETUDE
                                          from tp2_ETUDE
                                          where NO_ETUDE = PI_NO_ETUDE));
    return V_MOYENNE_INDICE_METABO;
end;
/
select TP3_FCT_AVG_INDICE_METABO(NO_ETUDE)
from TP2_ETUDE_PATIENT
where NO_ETUDE = 'N9475234';
