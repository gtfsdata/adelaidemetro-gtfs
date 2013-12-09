#!/bin/bash
# GTFS mirroring tool.  This allows us to keep the GTFS data from Adelaide
# Metro into a revision control system (so we could look up historical data).
#
# Copyright 2011 Michael Farrell <http://micolous.id.au>
#
# This program is free software. It comes without any warranty, to
# the extent permitted by applicable law. You can redistribute it
# and/or modify it under the terms of the Do What The Fuck You Want
# To Public License, Version 2, as published by Sam Hocevar. See
# http://sam.zoy.org/wtfpl/COPYING for more details.

DATA_ZIP="http://adelaidemetro.com.au/GTFS/google_transit.zip"
DATA_ZIPFILENAME="google_transit.zip"

function get_release_isodate {
  # Gets the ISO8601 date of the release
  D=`grep "Release: " "$1" | head -n1 | cut -d" " -f2 | sed 's#-#/#g'`
  if [ -n "$D" ]; then
    Y=`echo $D | cut -d/ -f3`
    M=`echo $D | cut -d/ -f2`
    A=`echo $D | cut -d/ -f1`

    echo "${Y}-${M}-${A}:${1}"
  else
    # Cannot parse
    echo "0000-00-00:${1}"
  fi
}

function get_release_dates {
  find gtfs/ -name 'release\ notes*.txt' | while read i
  do
    get_release_isodate "$i"
  done
}

# Create the target folder
mkdir -p "gtfs"

# Delete old release notes from the folder
rm -f gtfs/release\ notes*.txt

# Download data archive
# Normally -O would be used here, but it doesn't work in combination with -N.
# (see wget man page for details)
wget -N "${DATA_ZIP}"

# Extract the data into the data folder
unzip -oujL "${DATA_ZIPFILENAME}" -d gtfs

# Add files to commit
git add gtfs/*.txt

# Commit
DATE="`date`"
HEADER="New data from upstream source on ${DATE}\n"

# Find the newest release notes and construct a commit message from them
NEW_NOTES=`get_release_dates | sort -r | head -n1 | cut -d: -f2`
MSG=`echo -e $HEADER | cat - "${NEW_NOTES}"`

git commit -am "${MSG}"

# Push downstream to github
git push origin master
