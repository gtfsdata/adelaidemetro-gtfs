GTFS mirroring tool.  This allows us to keep the GTFS data from Adelaide
Metro in a revision control system (so we could look up historical
data).

It should be trivial to adapt this to monitor another public transit
system.

This is best used in a daily crontab.

You shouldn't need to run this script yourself though, I already provide a
repository at <https://github.com/gtfsdata/adelaidemetro-gtfs>.  It has data
starting from January 2011.  Adelaide Metro started providing this data
publicly in November 2010.


Copyright 2011 Michael Farrell <http://micolous.id.au>

This program is free software. It comes without any warranty, to
the extent permitted by applicable law. You can redistribute it
and/or modify it under the terms of the Do What The Fuck You Want
To Public License, Version 2, as published by Sam Hocevar. See
http://sam.zoy.org/wtfpl/COPYING for more details.

The data provided (in the `gtfs` folder) is licensed under [Creative Commons
Australia Attribution 3.0
License](http://creativecommons.org/licenses/by/3.0/au/deed.en).

A current version of the data held in this repository is available for free
from Adelaide Metro's website, at
<http://www.adelaidemetro.com.au/Developer-Information>.

