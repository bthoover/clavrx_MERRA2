#! /bin/sh

YYYY=${1}
MM=${2}
DD=${3}

# MERRA-2 files are identified by their assimilation stream, of which there are 4 (100, 200, 300, and 400).
# The stream a file comes from depends on its date, as referenced on page 13 of:
#
# Location:
# https://gmao.gsfc.nasa.gov/pubs/docs/Bosilovich785.pdf
#
# Title:
# GMAO Office Note No. 9 (Version 1.1)
# MERRA-2: File Specification
#
# Citation:
# Bosilovich, M. G., R. Lucchesi, and M. Suarez, 2016: MERRA-2: File Specification. GMAO
# Office Note No. 9 (Version 1.1), 73 pp, available from
# http://gmao.gsfc.nasa.gov/pubs/office_notes
#
# Define STREAM by date:

let YMD=${YYYY}${MM}${DD}

if [[ ${YMD} -lt 19920101 ]]; then
	STREAM=100
elif [[ ${YMD} -lt 20010101 ]]; then
        STREAM=200
elif [[ ${YMD} -lt 20110101 ]]; then
	STREAM=300
else
	STREAM=400
fi

TARGET_FILE=MERRA2_${STREAM}.inst6_3d_ana_Nv.${YYYY}${MM}${DD}.nc4

# Define base-URL

BASEURL=https://goldsmr5.gesdisc.eosdis.nasa.gov/data/MERRA2/M2I6NVANA.5.12.4/

wget --load-cookies ~/.urs_cookies --save-cookies ~/.urs_cookies --keep-session-cookies --content-disposition ${BASEURL}/${YYYY}/${MM}/${TARGET_FILE}

if [ -f "$TARGET_FILE" ]; then
    mv ${TARGET_FILE} 3d_ana/.
else 
    echo "${TARGET_FILE} does not exist."
fi


