#!/bin/bash

cd raw/death

target_file="deces-1970-to-2020-XX.csv"

death_files="https://insee.fr/fr/statistiques/fichier/4190491/deces-1970-1979-csv.zip
https://insee.fr/fr/statistiques/fichier/4190491/deces-1980-1989-csv.zip
https://insee.fr/fr/statistiques/fichier/4190491/deces-1990-1999-csv.zip
https://insee.fr/fr/statistiques/fichier/4190491/deces-2000-2009-csv.zip
https://insee.fr/fr/statistiques/fichier/4190491/deces-2010-2018-csv.zip
https://insee.fr/fr/statistiques/fichier/4190491/Deces_2018.zip
https://insee.fr/fr/statistiques/fichier/4190491/Deces_2019.zip
https://insee.fr/fr/statistiques/fichier/4190491/Deces_2020_M01.zip
https://insee.fr/fr/statistiques/fichier/4190491/Deces_2020_M02.zip
https://insee.fr/fr/statistiques/fichier/4190491/Deces_2020_M03.zip
https://insee.fr/fr/statistiques/fichier/4190491/Deces_2020_M04.zip
"


# Download each file and unzip it, delete the original archive
for foo in ${death_files}
do
    # Define the name of the file under which to save it
    file_name=`echo $foo | sed 's/^.*eces/deces/'`
    wget ${foo} -O ${file_name} # download
    unzip ${file_name}
    rm ${file_name}
done

# Delete the target file if it exists
if [ -f "${target_file}" ]; then
    echo "removing target file '${target_file}'" 
    rm ${target_file}
fi
if [ -f "${target_file}.gz" ]; then
    echo "removing target file '${target_file}.gz'" 
    rm ${target_file}
fi

# File names are not super consistant so fix
# Deces -> deces
# _ -> -
# m01 -> M01
for file_name_csv in `find  . -regex "./[dD]eces[-_][0-9]+.*.csv" | sort`
do
    new_csv_name=`echo ${file_name_csv} | sed 's/_/-/g' | sed 's/Deces/deces/' | sed 's/-m/-M/'`
    if [ ! -f "${new_csv_name}" ]; then
        mv ${file_name_csv} ${new_csv_name}
    fi
done

for file_name_csv in `find  . -iregex "./deces-[0-9]+\(-[Mm][0-9][0-9]\)*.csv" | sort`
do
    if [ ! -f "${target_file}" ]; then
        head -n 1 ${file_name_csv} > ${target_file}
    fi
    echo "Processing: '${file_name_csv}'" 
    tail -n+2 ${file_name_csv} >> ${target_file}
    rm ${file_name_csv}
done

gzip ${target_file} && echo "File created: '${target_file}.gz'" 