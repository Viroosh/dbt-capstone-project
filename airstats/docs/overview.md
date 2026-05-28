# Silver Layer Overview

The silver layer in AirStats connects three core entities through `airport_ident`, the ICAO airport code.

`silver_airports` is the central dimension table containing one row per airport with location and classification attributes. `silver_runways` extends each airport with physical runway details, linking back to airports via `airport_ident`. `silver_airport_comments` captures user feedback about airports and also references `airport_ident`, enabling analysis of comments per airport and per runway context.

Together, these tables form a star-like structure where airports sit at the center and runways and comments are related satellite tables.
