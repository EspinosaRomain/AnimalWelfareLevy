# AnimalWelfareLevy
Data and code to replicate "Animal Welfare Levy". Software: R for data analysis, Numbers (macOS) for visualizations. 

1. The Folder "Animal Welfare Levies" contains the scripts to reproduce the taxation levels for the chickens under the various rearing systems (Table 3), the main figures for the taxation levels (Figure 3), the main sensitivity analyses (Table 4), and the supplementary sensitivity analysis (Table OA1 in the Online Appendix). 
- Compute AWL: R script to reproduce the results (expected running time: about 10 seconds)
- DataOnAnimals: R source file to load data on the animals
- FunctionsAWL: the functions used to compute the levies under various hypotheses
- "Taxes computation - Baseline": the "Numbers" file to reproduce Figures 2 and 3, and Tables 2 and 3.

2. The Folder "Survey Data" contains the data and codes to reproduce the results for the online survey (Figure B1). It contains:
- The anonymized raw data (R data)
- The script to clean and analyze the data (R script) (expected running time: less than one second)
- "Graph answers online survey" (Numbers file): To reproduce Figure B1. 

3. The Folder "Simulations Environmental Tax" contains:
- The R script to reproduce the simulation of a GHG tax on beef products (Figure B2) (expected running time: less than one second).
- Simulation taxes (Numbers file): To reproduce Figure B2.

## Data Availability Statement: 
We provide the anonymized raw data for the survey data, as the original dataset contains private information. 
