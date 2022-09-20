
                            MTA SIB
                 Science Instrument Background Trending

======================================================================

This document is an attempted translation of Scott's SIB.spec
document into english. ( Little joke there. -very SJW )

======================================================================

Description:
  This specification outlines the analysis to be done to
  trend the science instrument and sky background.  This
  will be a multi-step process to:

    - Create a source mask for input L1 event lists
    - Remove these regions from the L1 data products.
    - Create table of count rate per energy bin
    - Create plot of count rate per energy bin vs time

  The operational profile is that once a week, OPS will run the
  pipeline with all the previous week's data.


Inputs
  L1 Event List
    Stack of L1 event files


Outputs
  MTASIBKG?     MTA Bkg Energy profile 
      TIME          double    sec      Bin timetag
      RANDX         short     <none>   RA Location index
      DECNDX        short     <none>   DEC Location index
     <Energy Band>  long      count    Counts
      FLARE         bit[]     <none>   1 Bit per energy band


Procedure

  For each event file:

    1) Filter events 
        a) Exclude data based on observation criteria
             - Ignore event files with extended sources
                 Q: Is the OCAT extended source flag in obs.par?
             - Ignore ACIS events from ALL BUT the following DATAMODEs
                 TIMED, FAINT, VFAINT
             - Ignore HRC events from the following DATAMODEs
                 <none>
        b) Exclude the standard hot pixels and columns
             < Define columns to be in filtered event list >
             ?eventdef parameter?
        c) Apply any associated filter for event fields. 
             A configurable filter parameter should be available
             to filter events on fields such as  PHA or Grade.
             This filter would be science instrument dependent.
             See SI specific definitions section for defaults.
        d) Remove events associated with sources

    2) Generate Low-resolution energy profile

       This file contains a time history of the accumulated counts 
       in the various sky bins in each of the specified energy bands.

       a) Determine sky location indexes
            - Divide the sky into an N x N/2 grid (360 in RA 180 in
		Dec)  where
                   N     = 360/<skybin> 
                <skybin> = input parameter specifying the size of each
                           sky grid.
            - Determine sky location indexes ( RANDX, DECNDX ) as
		
               *********************************************
               *                                           *
               *          Fill in Defintion                *
               *                                           *
               *********************************************
		randx = fix (decimal RA/N)
		decndx = fix (decimal Dec/N)
		
		examples
		sky bin = 2  (each bin is 2 degrees the sky is 
			     180x 90 bin  
		RADEG = 45.000
		DECDEG = -45.000
		
		data goes to (randx 22, decndx -22) 


		sky bin = 1  (each bin is 1 degrees the sky is 
			     360x 180 bins  
		RADEG = 181.400
		DECDEG = -83.020
		
		data goes to (randx 181, decndx -83) 


		sky bin = .5  (each bin is .5 degrees the sky is 
			     720x 360 bin  
		RADEG = 301.400
		DECDEG = -0.25
		
		data goes to (randx 602, decndx 0) 


          The nominal value for <skybin> will be 360 deg. for 
          the SI background pipeline, creating just 1 sky bin
          with location index ( 0,0 )

       b) Accumulate event counts in each sky bin

          + Determine the binned time-tag for the event as follows:

            Output products are to be time-binned in the same manner 
            as the MTA Database is expecting them.  The time bin boundaries
            are to be calculated from an absolute reference time.
            
            T0     = Tref + Toff
            Tbevt  = T0 + LONG[(Tevt - T0)/Tbin ]*Tbin
            
            Where
                Tref  =  Reference time for binned time calculation
                              ( default = ???????? ) GET THIS FROM DB GROUP
                Toff  =  Time offset from Tref for bin calculation
                              ( default = 0.0 )
                Tbin  =  Size of each bin in sec.
                         ( default = 300.0 )
                T0    =  Start of time bin 0
                Tevt  =  Event timetag in sec.
                Tbevt =  Binned timetag of event.

          + Determine energy bin of event

            Default energy bin definitions are listed in the
            "Energy Band Definitions" section.  These should be
            input in a manner that allows them to be easily configured.
   
            NOTE: For ACIS S1, S3 chips, create only 1 energy bin ( SSoft ).


          + Increment counter for that sky/time/energy bin.

       
        *********************************************
        * + Apply exposure correction?              *
        *                                           *
        *    Do we correct for fraction of CCD      *
        *    accumulating events?                   *
        *    correcting for source regions and      *
        *    subarray modes?                        *
        *                                           *
        *********************************************

        scale CCD/Plate area:
	both ACIS and HRC can and do use subregions.
	these are easy to correct for.
	
	sub regions are specified in obscat and should be pulled 
	from there.
        for ACIS
Subarray Type     : (subarray) Choices are: None, 1/2, 1/4, 1/8 and Custom.
                    A subarray is a reduced region of the CCDs
                    (all of the CCDs that are turned on). The default is
		    'None'.
Start             : (subarray_start_row) Subarray: The starting row
		     that will be read  for processing custom subarrays.
                     Valid range is 0 - 895 
Rows              : (subarray_row_count) Subarray: The number of rows
		    that will be read for processing custom subarrays.  Valid range is 128 - 1023
	!!!!!For HRC ?!!!!!!

	Check obscat word HRCMODE (if null or default normal range is used)
        The SI_MODE entry contains a mnemonic to a line in the HRCMODE ODE that 
provides the HRC configuration data. For a description of the HRCMODE and the 
currently defined modes see the URL:
	http://hea-www.harvard.edu/~juda/hrc_flight/macros/hrcmode.html

Any detector blanking window is defined by the [U/V]_BLANK_[HI/LOW] and 
BLANK_ENABLE parameters (with a little additional interpretation) or the 
SPECT_MODE parameter if the HRC-S is being used.
        !!!!!!!!!!!!!!!!!!!!!
           
	check what fraction of the node/plate is on.  Divide
	background by this fraction.

	As of this version apply the trival sky expsoure correction:
	 divide all sky rates by 1.0


       c) Set Flare indicators

          + Determine count rate for each energy band
              rate = count/Tbin


          Evaluate each energy band against the flare thresholds.
          ( see Rate definitions )  If the count rate for that band 
          exceeds the specified threshold, set the appropriate bit of 
          the flare bit array.
         
  
      Sample output: ( S1 or S3 )
         time  NODE   RANDX   DECNDX   SSOFT    SOFT     MED ...  FLARE 
          sec         <none>  <none>   count    count   count           
          t1     0       0       0        1       20       11 ...  000...
          t1     1       0       0        0       50        9 ...  000...
          t1     2       0       0        0      300       15 ...  000...
          t1     3       0       0        1     1000       30 ...  001...
          t2     0       0       0        1       20       11 ...  000...
               
	A GOOD OPTION WOULD BE TO USE SAMPLE II FOR ALL CCDS, 
	COLUMN SSOFT WOULD SIMPLY BE DANG CLOSE TO 0 FOR 8 CHIPS.

	WHERE IS THE NODE INFORMATION, I PUT IT IN COL 2.
	This also allows for node redefinition, i.e. split node 1 into
	nodes, 1a,1b,1c,1d.

    2) Generate high-resolution energy profile

       The procedure is the same as for the Low-resolution file
       with the following differences.
         - nominal time bin  Tbin = 3600 sec.
         - Use High-resolution energy band definitions


    3) Generate plots

       The following plots are to be generated from the output products.
       Separate plots are to be made representing the data on different
       time scales.  The plot bins are set according to which time
       scale is being displayed.  ( ~ 1000 time bins per plot ).
          Weekly  =   600 sec bins
          Monthly =  2400 sec bins  ( monthly = 4 weeks )
          Annual  = 31200 sec bins
          Mission = 60000 sec bins

        **********************************************
        * Always produce 1000 plot points            *
        **********************************************

       a) Count rate vs. time

          For each DETECTOR/FILTER combination (See SI plot definitions)
          generate a plot of the low resolution count rates 
          as a function of time.  
             - rebin the data as indicated above for the indicated
               scale of the plot ( Weekly, Monthly, etc... )
             - On the same plot show the rates from each energy band
               plus "ALL"
               
                   <DETECTOR> - <FILTER>
           
                  |  ALL bands  = BLACK
                  |  <other EB by color>
           cts/s  |  
                  |  
                  |  
                  +-----------------
                      time (DOM)


       b) Hardness profile

          For each DETECTOR/FILTER combination (See SI plot definitions)
          generate a log-scaled 2D image of the High resolution energy
          profile with Time(DOM) and Energy band as the axes and the 
          counts as the value.  Display High count values as bright
          and Low count values as dark  ( 0 = black )


                   CCDID # - <FILTER> (week/month/year)
                  +-------------------+
                  |                   |
                  |                   |
           c/s    | bright = Hi Rate  |
                  | dark   = Low Rate | 
                  |                   |
                  +-------------------+
                        energy        


	c) Flare statistics
		for each CCD/FILTER 
	
 start DOM send DOM CCD  NODE   FILTER   ONTIME  FLARETTIME SSOFT  FT SS/ONTIME
FT SOFT FTS/OT  FT MED  FTM/OT FTHARD FTH0/OT FT_HARDER FTH1/OT  FT HARDER FTH2/OT



Notes:
  Extended Objects
    1) Do not process extended objects 
       (perhaps have list of OBSIDs to exclude)
    2) Many extended objects are so faint they woudln't matter. 
       If you are going to exclude some observations, it may be useful 
       at least to check the observer's estimated count rate in Obscat 
       and exclude only the bright ones.

  CTI observations
    1) All CTI observations should be excluded
        (exclude all obsids of 50,000)

  Values:
    1) All values given here, ie limits definitions, or bin demarkations,
       are estimates and should be parameters or read from files or some
       other editable means.

Database:
   New MTADB required to store output data.
   <Define table and data source >

Development
   Priority  = MTA 3  
   Developer = Jim Petreshock
   Est. Time = 2 months.




======================================================================
                         ACIS Definitions
======================================================================

  Flare Rate definitions:
           Name             Status      Rate           CCDs
                                      count/s/eb
     unfiltered bkg flare   yellow      > 100          S1,S3
     unfiltered bkg flare   yellow      >  10          other
     unfiltered bkg flare      red      > 300          S1,S3
     unfiltered bkg flare      red      >  30          other
 
       filtered bkg flare   yellow      >   5          S1,S3
       filtered bkg flare   yellow      >   3          other
       filtered bkg flare      red      >  50          S1,S3
       filtered bkg flare      red      >  30          other

   NOTE: eb = Energy band

  Energy Band definitions:

    Low-resolution energy bands
       Name     Low(KeV)   High(KeV)   Description
       =======  ========   =========   =============================   
       SSoft       0.00       0.50      Super soft photons
       Soft        0.50       1.00      Soft photons
       Med         1.00       3.00      Moderate energy photons
       Hard        3.00       5.00      Hard Photons
       Harder      5.00      10.00      Very Hard photons
       Hardest   >10.00                 Beyond 10 KeV

    High-resolution energy bands
       Name     Low(KeV)   High(KeV)   Description
       =======  ========   =========   =============================   
       EB1         0.00       0.20     Energy range  0.00 -> 0.20 KeV
       EB2         0.20       0.35     Energy range  0.20 -> 0.35 KeV
       EB3         0.35       0.50     Energy range  0.35 -> 0.50 KeV
       EB4         0.50       0.65     Energy range  0.50 -> 0.65 KeV
       EB5         0.65       0.80     Energy range  0.65 -> 0.80 KeV
       EB6         0.80       0.95     Energy range  0.80 -> 0.95 KeV
       EB7         0.95       1.10     Energy range  0.95 -> 1.10 KeV
       EB8         1.10       1.30     Energy range  1.10 -> 1.30 KeV
       EB9         1.30       1.50     Energy range  1.30 -> 1.50 KeV
       EB10        1.50       1.70     Energy range  1.50 -> 1.70 KeV
       EB11        1.70       1.95     Energy range  1.70 -> 1.95 KeV
       EB12        1.95       2.20     Energy range  1.95 -> 2.20 KeV
       EB13        2.20       2.45     Energy range  2.20 -> 2.45 KeV
       EB14        2.45       2.70     Energy range  2.45 -> 2.70 KeV
       EB15        2.70       3.00     Energy range  2.70 -> 3.00 KeV
       EB16        3.00       3.25     Energy range  3.00 -> 3.25 KeV
       EB17        3.25       3.50     Energy range  3.25 -> 3.50 KeV
       EB18        3.50       3.75     Energy range  3.50 -> 3.75 KeV
       EB19        3.75       4.00     Energy range  3.75 -> 4.00 KeV
       EB20        4.00       4.25     Energy range  4.00 -> 4.25 KeV
       EB21        4.25       4.50     Energy range  4.25 -> 4.50 KeV
       EB21        4.50       4.75     Energy range  4.50 -> 4.75 KeV
       EB22        4.75       5.00     Energy range  4.75 -> 5.00 KeV
       EB23        5.00       5.25     Energy range  5.00 -> 5.25 KeV
       EB24        5.25       5.50     Energy range  5.25 -> 5.50 KeV
       EB25        5.50       5.75     Energy range  5.50 -> 5.75 KeV
       EB26        5.75       6.00     Energy range  5.75 -> 6.00 KeV
       EB27        6.00       6.33     Energy range  6.00 -> 6.33 KeV
       EB28        6.33       6.66     Energy range  6.33 -> 6.66 KeV
       EB29        6.66       7.00     Energy range  6.66 -> 7.00 KeV
       EB30        7.00       7.33     Energy range  7.00 -> 7.33 KeV
       EB31        7.33       7.66     Energy range  7.33 -> 7.66 KeV
       EB32        7.66       8.00     Energy range  7.66 -> 8.00 KeV
       EB33        8.00       8.33     Energy range  8.00 -> 8.33 KeV
       EB34        8.33       8.66     Energy range  8.33 -> 8.66 KeV
       EB35        8.66       9.00     Energy range  8.66 -> 9.00 KeV
       EB36        9.00       9.50     Energy range  9.00 -> 9.50 KeV
       EB37        9.50      10.00     Energy range  9.50 -> 10.00 KeV
       EB38       10.00      20.00     Energy range  >10.00 KeV


  Plot Defintions:
    Energy band color codes
       ALL   = BLACK
       HARD  = BLUE
       MED   = GREEN   
       SOFT  = ORANGE
       SSOFT = RED 
  
    DETECTOR to plot
      "CCDID #"  # = 0,1,2,3,4,5,6,7,8,9,S1+S3
      "ALL (except S1+S3)"
  
    FILTER
     "NONE"     = All events
     "NO 1,5,7" = Excluding grades 1,5,7

======================================================================
                         HRC Definitions
======================================================================

  Flare Rate definitions:
           Name             Status      Rate           CCDs
                                      count/s/eb
        bkg flare           yellow      > 10           HRC-I
        bkg flare           yellow      > 100          HRC-S
        bkg flare           red         > 50           HRC-I
        bkg flare           red         > 500          HRC-S


  Plot Defintions:
    Energy band color codes
       ALL   = BLACK
  
    DETECTOR to plot
      "HRC-I"
      "HRC-S#"   # = 1,2,3
      "VER"
      "SR"
  
    FILTER
     "NONE"     = All events
     "PHA > 40" = Excluding events with PHA < 40  (not used for VER and SR)

===========================================================================
===========================================================================
===========================================================================

HRC

  Rate Calculation:
    - Get live time for time range specified from secondary science data.
      This value is obtained from hrcfXXXXX_XXXNXXX_dtf1.fits
TTYPE2  = 'DTF     '           / Dead time factor  
TTYPE3  = 'DTF_ERR '           / Dead time factor error
TTYPE4  = 'PROC_EVT_COUNT'     / Primary Science total counts
TTYPE5  = 'TOTAL_EVT_COUNT'    / Secondary Science total counts
TTYPE6  = 'VALID_EVT_COUNT'    / Secondary Science valid counts
                           

    - Read valid background event photons from primary science data 
      for the time range specified.
    - Get average shield event rate from         hrcfXXXXXXXXXNXXX_ss0.fits 
	TLEVART - Total event rate
	VLEVART - Valid event rate
	SHEVART - Sheild event rate)
  
    (NOTE: average valid background event rate, and average shield event
           rate should be in the existing databases already) 
  
    - Calculate background rate by subtracting source counts from
             Primary Science total counts (=  number of background 
      counts), then dividing total number of background 
      counts during time range specified by live time.
  
    - Add the shield rate to its associated accumulator. 
  
    - After the requested number of samples have been added to the 
      accumulator, divide each by the number of samples included to 
      generate average rates.

      Low resolution counts file


      ???? file ( per plate )
        HEADER 
          Detector plate?   HRC-I/HRCS1/HRCS2/HRCS0
          IMHBLV  Imaging Bot & Top MCP HV Monitor 
          IMHVLV  Imaging Bot MCP HV Monitor 
          RSRFALV Range Switch Setting 
          SPHVLV  Spect Bot MCP HV Monitor 
          SPHBLV  Spect Bot & Top MCP HV Monitor 
	

          time RANDX, DECNDX, cnts/300 sec, MEAN PHA, PHA ERROR, TER, VER, SER , nodefault  Flare(1 bit) 
 

	(NODEFAULT is true(=1) if HRCMODE in obscat in not NULL, don't use nodefault data in 
	plots and table below.)

  Displays:
    - Text screen showing average background event rate, and 
      average shield event rate 
      (VERSON 2: with rates exceeding yellow or red limits flagged.)

    - Graphic screen displaying several samples of the average background
      event rates and average shield rate vs. time over a user selected 
      time interval. 

  Plots
    4 like this

                PLATE
     
            |ALL= BLACK
            |
     Mean   |
      PHA   |
            |
            +-----------------
                time (DOM)


     PLATE = I,S1,S2,S3        

  Plots
    7 like this

                PLATE
     
            |
            |
     cnt/   |
      sec   |
            |
            +-----------------
                time (DOM)

     PLATE = I,S1,S2,S3,VER,SER,TER        



flare statistics
 start DOM send DOM PLATE FILTER   ONTIME  FLARETTIME  FT/ONTIME
