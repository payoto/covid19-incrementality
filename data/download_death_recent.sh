#!/bin/bash

cd raw/death

data_url="https://www.insee.fr/fr/statistiques/fichier/4470857/2020-05-07_detail.zip"
data_file="2020-05-07_detail"
data_csv="DC_jan2018-avr2020_det.csv"
covid_deaths_url="https://raw.githubusercontent.com/opencovid19-fr/data/master/dist/chiffres-cles.csv"

wget ${data_url} -O ${data_file}.zip
unzip ${data_file}.zip

rm Documentation.pdf
rm metadonnees_deces_ficdet.csv

gzip ${data_csv}
wget ${covid_deaths_url}
gzip "chiffres-cles.csv"