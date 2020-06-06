#!/bin/bash

cd raw/geo

geo_fla_postcode_url="https://data.opendatasoft.com/explore/dataset/code-postal-code-insee-2015@public/download/?format=shp&timezone=Europe/Berlin"
epcicom_url="https://www.collectivites-locales.gouv.fr/files/files/dgcl_v2/DESL/Bilansstats2020/epcicom2020.xlsx"


wget -O code-postal-code-insee-2015.zip ${geo_fla_postcode_url}
unzip code-postal-code-insee-2015.zip

wget -O epcicom2020.xlsx ${epcicom_url}