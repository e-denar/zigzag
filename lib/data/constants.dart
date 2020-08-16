const baseURL = 'https://disease.sh/v3/covid-19/';
const globalSummaryURL = 'all?allowNull=true&yesterday=';
const countriesSummaryURL =
    'countries?yesterday=true&twoDaysAgo=false&sort=cases&allowNull=false';
const continentsSummaryURL =
    'continents?yesterday=false&sort=cases&allowNull=false';
const OK_RESPONSE = 200;
// all?yesterday=true&allowNull=true
