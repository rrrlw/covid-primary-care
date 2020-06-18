All data was downloaded from source URLs on 15 June 2020.

### covid-cases.csv

CSV file containing the following 2 columns:
* **region**: contains full name of U.S. states and territories.
* **6/4/2020**: number of SARS-CoV-2 cases as of 4 June 2020.

Data source: https://github.com/CSSEGISandData/COVID-19/

### generate.R

R script that generates [this bubble chloropleth](https://github.com/rrrlw/covid-primary-care/blob/master/BubbleMap.png) from the data files.

### geo-data.csv

CSV file containing the following 3 columns:
* **region**: contains full name of U.S. states and territories.
* **Lat**: latitude of approximate center of state/territory.
* **Long**: longitude of approximate center of state/territory.

Data source: https://inkplant.com/code/state-latitudes-longitudes

### ihme-projection.csv

CSV file containing the following 5 columns:
* **region**: contains full name of U.S. states and territories.
* **day**: day component of date for which the number of cases are being projected.
* **month**: month component of date for which the number of cases are being projected.
* **year**: year component of date for which the number of cases are being projected.
* **est_infections_mean**: projected number of SARS-Cov-2 cases as of date denoted by `day`, `month`, and `year` columns.

Data source: https://covid19.healthdata.org/united-states-of-america

### state-data.csv

CSV file containing the following 5 columns:
* **region**: contains full name of U.S. states and territories.
* **state**: 2-letter abbreviation of `region`.
* **Number**: active primary care physicians per 100,000 population (in 2018).
* **Over60**: percent of active family medicine/general practice physicians over age 60 (in 2018).
* **TotalPop**: total state population (in 2018).

Data source: https://www.aamc.org/data-reports/workforce/data/2019-state-profiles
