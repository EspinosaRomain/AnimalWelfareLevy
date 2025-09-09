# AnimalWelfareLevy
Data and code to replicate "Animal Welfare Levy". Software: R for data analysis, Numbers (macOS) for visualizations. 

1. The Folder "Animal Welfare Levies" contains the scripts to reproduce the taxation levels for the chickens under the various rearing systems (Table 3), the main figures for the taxation levels (Figure 3), the main sensitivity analyses (Table 4), and the supplementary sensitivity analysis (Table OA1 in the Online Appendix). 
- Compute AWL: R script to reproduce the results (expected running time: about 10 seconds)
- DataOnAnimals: R source file to load data on the animals
- FunctionsAWL: the functions used to compute the levies under various hypotheses
- "Taxes computation - Baseline": the "Numbers" file to reproduce Figures 2 and 3, and Tables 2 and 3. Note that "Table 6" in the first sheet of the Numbers file is taken from the CE Delft Report (2023).

2. The Folder "Survey Data" contains the original data that were collected and codes to reproduce the results for the online survey (Figure B1). It contains:
- The anonymized raw data that were collected (R data)
- The script to clean and analyze the data (R script) (expected running time: less than one second)
- "Graph answers online survey" (Numbers file): To reproduce Figure B1. 

3. The Folder "Simulations Environmental Tax" contains:
- The R script to reproduce the simulation of a GHG tax on beef products (Figure B2) (expected running time: less than one second).
- Simulation taxes (Numbers file): To reproduce Figure B2.

## External Data

The Folder "External Resources" contains materials used in the work that originate from external parties. 

- CE Delft (2023) Pay as you eat dairy, eggs and meat: Internalising external costs of animal food products in France, Germany and the EU27. Data were used to produce Figures 2 and 3. The "Table 6" that is included in "Taxes computation - Baseline.numbers" (see above) originates from this report. (Link: https://cedelft.eu/wp-content/uploads/sites/2/2023/03/CE_Delft_220109_Pay_as_you_eat_dairy_eggs_and_meat_Def_3.pdf) 

The "External Resources" Folder also contains the content associated with the following footnotes:
- Footnote 17: Media citation. AgroMedia.fr. "Les forces et faiblesses de la filière volaille française". February 2, 2021. Document: AgroMedia2021.pdf  Archive link: https://web.archive.org/web/20220725123440/https://www.agro-media.fr/analyse/les-forces-et-faiblesses-de-la-filiere-volaille-francaise-46372.html 
- Footnote 18: Media citation. Paysan-Breton.fr "L’éclosion à la ferme offre de nombreux avantages". January 7, 2018. Document: PaysanBreton2018.pdf Archive link: https://web.archive.org/web/20220725095634/https://www.paysan-breton.fr/2018/01/leclosion-a-la-ferme-offre-de-nombreux-avantages/
- Footnote 19: Governmental webpage citation. Agriculture.gouv.fr. "Le bien-être et la protection des volailles de chair". February 28, 2019. Document: AgricultureGouv2019.pdf Archive link: Document: https://web.archive.org/web/20220725102232/https://agriculture.gouv.fr/le-bien-etre-et-la-protection-des-volailles-de-chair
- Footnote 20: NGO webpage citation. CIWF.fr "Animaux d'élevage - Poulets de chair". Publication date not reported. Document: CIWFpoulets.pdf Archive link: https://web.archive.org/web/20220725101002/https://www.ciwf.fr/animaux-delevage/poulets-de-chair/ 
- Footnote 22: NGO webpage citation. L214.com "L'abattage des poulets de chair". Publication date not reported. Document: L214poulets.pdf Archive link: https://web.archive.org/web/20220725121155/https://www.l214.com/animaux/poulets/abattage-des-poulets-de-chair/ 
- Footnote 23: Administrative authority's webpage citation. FranceAgrimer.fr "Prix Poulet". July 22, 2022. Document: FranceAgrimer2022_poulet.pdf Archive link: https://web.archive.org/web/20220726084201/https://rnm.franceagrimer.fr/prix?POULET 
- Footnote 24: NGO report citation. Welfarm.fr (Formerly PMAF). "Le Poulet Fermier élevé en liberté Label Rouge Le Poulet Fermier élevé en plein air Label Rouge". Publication date not reported. Document: WelfarmPoulets.pdf Archive link: https://web.archive.org/web/20250909124624/https://welfarm.fr/pdf/labels/fiche_poulets.pdf 
- Footnote 25: The retail prices are taken from the two sources of the administrative authority France Agrimer. More precisely:
 -- For the chicken meat retail price: Data from FranceAgrimer (footnote 24). File: FranceAgrimer2022_poulet.pdf (Line "Poulet (filet) UE standard, €5.80) 
 -- For the pork meat retail price: Data from FranceAgrimer Observatoire prix marges (Rôti de porc). File: FranceAgrimer2021_pork.PDF. Note: the provided document reports €5.97 instead of €5.98 used in the manuscript. We retrieved the retail price in September 2022, while the PDF file dates from September 2025.
 -- For the cow meat retail price: Data from FranceAgrimer Observatoire prix marges (Panier saisonnier des morceaux de boeuf). File: FranceAgrimer2021_cow.PDF Note: the provided document reports €11.71 instead of €11.85 used in the manuscript. We retrieved the retail price in September 2022, while the PDF file dates from September 2025.
- Footnote 38: Governmental webpage citation. Agriculture.gouv.fr. "Le bien-être et la protection des porcs". February 28, 2019. File: AgricultureGouv2019_pork.pdf Archive link: https://web.archive.org/web/20220928120039/https://agriculture.gouv.fr/le-bien-etre-et-la-protection-des-porcs 
- Footnote 39: Industry webpage citation. La-Viande.fr "L'organisation de l'élevage porcin en France" Publication date not reported. File: LaViande_organisation.pdf  Archive link: https://web.archive.org/web/20220701193519/https://www.la-viande.fr/animal-elevage/porc/organisation-elevage-porcin-france 
- Footnote 40:  Governmental webpage citation. Agriculture.gouv.fr. "La protection des animaux d'élevage pendant le transport" July 13, 2022  File: AgricultureGouv2022_transport.pdf  Archive link: https://web.archive.org/web/20220720074357/https://agriculture.gouv.fr/la-protection-des-animaux-delevage-pendant-le-transport
- Footnote 41: Industry webpage citation. La-Viande.fr "Le cheptel bovin et la production de viande bovine". Publication date not reported. File: LaViande_cheptel.pdf  Archive link: https://web.archive.org/web/20220920073750/https://www.la-viande.fr/economie-metiers/economie/chiffres-cles-viande-bovine/cheptel-bovin-production-viande-bovine
- Footnote 42: Media citation. Reussir.fr "80% des vaches laitières françaises pâturent plus de 10 ares mais…"
February 2, 2019. File: Reussir2019.pdf Archive link: https://web.archive.org/web/20220920075156/https://www.reussir.fr/lait/80-des-vaches-laitieres-francaises-paturent-plus-de-10-ares-mais
- Footnote 43:  Governmental webpage citation. Agriculture.gouv.fr. "Le bien-être et la protection des vaches laitières" February 28, 2019. File: AgricultureGouv2019_cows.pdf Archive link: https://web.archive.org/web/20220707042619/https://agriculture.gouv.fr/le-bien-etre-et-la-protection-des-vaches-laitieres 
- Footnote 44: NGO report citation. FiBL. "Elevage des veaux sous la mère ou avec une nourrice en production laitière" 2020 File: FIBL2020.pdf
- Footnote 45: Governmental database citation. Agreste.agriculture.gouv.fr "Réseau d'information comptable agricole : 1988-2018 (France métropolitaine) - CPS 2007" File: RICA2018.pdf Original source: https://agreste.agriculture.gouv.fr/agreste-web/disaron/RICA_METRO/detail/ Note: The PDF is a screenshot of the extraction of the database using the online interactive program. Data for 2018 no longer appear in Sept 2025. The data estimate for 2017 in the screenshot is 6738 for 2017, against 6734 in the manuscript. 
- Footnote 47: Media citation. Ressir.fr "Large panel de poids et d’âges pour les vaches de réforme" December 1, 2017. File: Reussir2017.pdf Archive link: https://web.archive.org/web/20220920083122/https://www.reussir.fr/bovins-viande/large-panel-de-poids-et-dages-pour-les-vaches-de-reforme 
- Footnote 48: NGO webpage citation. CIWF. "Animaux et Elevage Veaux et vaches laitières" Publication date not reported. File: CIWF_cows.pdf Link: https://www.ciwf.fr/animaux-et-elevage/les-animaux/veaux-et-vaches-laitieres/ (Could not be archived.) 
- Footnote 49: EU authority's report citation. EFSA. "Welfare of dairy cows" May 16, 2023. File: EFSA2023_cows.pdf  Link: https://www.efsa.europa.eu/en/efsajournal/pub/7993 
- Footnote 50: Governmental webpage citation. Agriculture.gouv.fr. "Le bien-être et la protection des vaches à viande". February 28, 2019. File: AgricultureGouv2019_beef.pdf  Archive link: https://web.archive.org/web/20231001032302/https://agriculture.gouv.fr/le-bien-etre-et-la-protection-des-vaches-viande


## Data Availability Statement: 
We provide the anonymized raw data for the survey data, as the original dataset contains private information. 
