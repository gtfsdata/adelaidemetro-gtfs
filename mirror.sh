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

DATA_ZIP="http://www.transport.sa.gov.au/googletransit/google_transit.zip"
DATA_ZIPFILENAME="google_transit.zip"

# Create the target folder
mkdir -p "gtfs"

# Download data archive
wget -N "${DATA_ZIP}"

# Extract the data into the data folder
unzip -ujL "${DATA_ZIPFILENAME}" -d gtfs

# Add files to commit
git add gtfs/*.txt

# Commit
DATE="`date`"
git commit -m "New data from upstream source on ${DATE}"

# Push downstream to github
git push origin master
