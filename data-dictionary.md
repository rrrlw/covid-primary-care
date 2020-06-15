### covid-cases.csv

### generate.R

### ihme-projection.csv

### state-data.csv

aamc-state-data.csv: contains data obtained from AAMC Physician Workforce Profile
	- URL: https://www.aamc.org/data-reports/workforce/data/2019-state-profiles
	- format: comma separated values
	- column region: full name of U.S. state
	- column state: abbreviation of U.S. state
	- column Number: number of active primary care physicians per 100,000 population (2018)
	- column Over60: proportion of family medicine general practice physicians over the age of 60
	
covid-confirmed.csv
	- URL: https://github.com/CSSEGISandData/COVID-19/
	- format: comma separated values
	- column Long_: geographical longitude
	- column Lat: geographical latitude
	- column `6/4/2020`: cumulative cases of SARS-CoV-2 infection
	- remaining columns are ignored
