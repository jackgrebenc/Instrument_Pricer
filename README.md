# Instrument_Pricer

## Overview

This project is a modified vanilla TickerPlant (TP) implemented in q/kdb used to price a pseudo financial instrument.

The pricing formula is as follows:

$\frac{{(R - RA) \cdot NP \cdot P}}{{1 \cdot Y}} \cdot \frac{{1}}{{1 + R \cdot \left(\frac{{P}}{{Y}}\right)}}$

where:
- RA = the rate of interest
- R = the reference rate of interest in Libor, determined at some point within the future
- NP = the notional principal in money
- P = the period, which is the number of days in the contract period
- Y = the number of days in the year based on the correct day-count convention for the contract

There are three feeds of data in this system and they are described by:

1. Feed 1 - The first system is legacy, this is very slow at producing instrument feeds and is based in the Frankfurt region. This feed produces data in fixed width string format and supports an EUR currency.

2. Feed 2 - The second system produces a very high rate of instrument feed data and is based in the London region. This feed produces data in json format and supports a GBP currency.

3. Feed 3- The 3rd system provides a snapshot of static account data. This feed produces data in csv format and is published on start up of the process and is restarted/run daily.

These feeds are consumed by the TP and pushed to the InstrumentPricer process. The InstrumentPricer normalizes and merges the data from Feed 1 and Feed 2. It then applies the pricing formula given above in the native currency of each system.

Finally, the CalcEngine process performs some calculations on the dataset produced by the InstrumentPricer (Volume Weighed Average Price for example). This can then be exposed to downstream processes for further useages.

## Requisites 
- q installation (Version 4.0)
- OS: MacOS Big Sur Verison 11.4. Should be Linux compatibile as well for shell scripts

## How to Run 

To run, cd into the root directory of this project and execute the following shell script:

./process_scripts/ALL_START.sh   

This will start all the processes in the correct order (TickerPlant (TP) -> InstrumentPricer -> Feeds -> RealtimeCalcEngine)

To Stop the processes, execute the stop shell script:

./process_scripts/ALL_STOP.sh   

## Processes & Ports

- InstrumentPricer -- Port 5013
- RealtimeCalcEngine -- Port 5014
- TP -- Port 5001
- Feed1 -- Port 8000
- Feed2 -- Port 8001
- Feed3 -- Port 8002

## Repo Set-up
- tick -- contains everything related to TP and TP set-up. Borrowed from vanilla tick with modifications made
- 1-Feeds -- root folder for all the feedhandler related code
- 2-Pricer -- root folder that contains the InstrumentPricer process
- 3-avgPrice -- root folder that contains the CalcEngine process
- process_scripts -- contains the individual stop/start for all 6 processes + a stop/start all script
- LOGS -- this is where all the LOG files will get written to. It is currently empty, but will be populated once the start script is run -- with all logging activity contained within it.

## Assumptions Made

#### Tick
- tick folder -- vanilla ticker plant implementation is available for use and able to be modified for this specific use case. 
- Since this problem does not involve EOD behaviour - this code will be kept from vanilla set-up and NOT tested.

#### IntrumentPricer
- The formula provided was given as:

price = (((R - RA) x NP x P) / (1 x Y)) x (1 / (1 + R x (P / Y)))

This was converted into latex (shown at the top of the readMe file) and implemented using that verison. The latex verision of the function is used in the project - which does not seem to match the provided formula (I beileve there is human error in what was provided).

#### Realtime Calc Engine
- Assumption is all data is realtime/"T" data -- so dates do not need to be considered in the vwap
#### Feeds
- Fixed width string --> 25 character strings for every field (numeric & non-numeric)
- Fixed set of account/groups is limited to the 6 entries provided - does not go above accountRef ending in digit 6
- Kept Feedhandlers segregated under different schemas for Feed1 & 2 under the assumption that the two systems may not always be aligned (i.e. new system - Feed2 could expand the schema in the future).
- For MarketName -> FFM = FrankFurt, LDN = London
- ExecutionTime will be stored in local timezone rather than region/source timezone to avoid timezone headaches (.z. CAPITAL) -- in my case this is EST.
- Feed3 is completely static in implementation except for Billing currency to add variability in the testing of data. Random seed was used in this case to provide randomness between restarts (rather than the default kernel)
- Client Name is only two people and highly reused in my example - which lead to making it a symbol. In most cases - this would likely be better suited as a string if there is not significant reuse of names
- Assumption that the AccountReference table (Feed3) acts as an insert rather than overwriting downstream process on restart. The CalcEngine is desinged to get only the latest data for max BusinessDate in the table - so upsert/overwrite would maintain the same logic.

#### Numeric Domain Assumptions
The following assumptions were made to make the numbers somewhat realistic seeming. This choices were all arbitrary/based on a provided example:

- 0 < RA < 10%
- 0 < R < 10%
- 1 million < NP < 250 million
- 0 < P < 365 days
- 0 < Y < 365 days

## Additional Work done
A couple of additional things were added that were outside the scope
- logging library (writes to the empty LOG folder)
- Start/Stop shell scripts -- used for convience of testing

