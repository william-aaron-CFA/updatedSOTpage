; IDL Version 5.1 (sunos sparc)
; Journal File for swolk@scrapper
; Working directory: /stage/ascds_extra/swolk/www/internal
; Date: Fri Dec 11 14:57:05 1998
 
line='x'
openr,1,'obscat.txt'
openw,2,'test.html'
printf,2,'<HTML>'
printf,2,'<HEAD>'
readf,1,line
print,line
; obsid       targid      seq_nbr targname                                           ss_obj_flag ss_object    si_mode    photometry_flag vmagnitude           ra                   dec                  est_cnt_rate         forder_cnt_rate      y_det_offset 
;        z_det_offset         radial               raster_scan defocus              dither_flag roll                 roll_tolerance       approved_exposure_time pre_min_lead         pre_max_lead         pre_id      seg_max_num phase_constraint_flag tstart
;                         tstop                          proposal_id acisid      hrcid       grating instrument rem_exp_time         soe_st_sched_date              type                          
readf,1,line
print,line
; ----------- ----------- ------- -------------------------------------------------- ----------- ------------ ---------- --------------- -------------------- -------------------- -------------------- -------------------- -------------------- -------------
;------- -------------------- -------------------- ----------- -------------------- ----------- -------------------- -------------------- ---------------------- -------------------- -------------------- ----------- ----------- --------------------- ------
;------------------------ ------------------------------ ----------- ----------- ----------- ------- ---------- -------------------- ------------------------------ ------------------------------
readf,1,line
print,line
;           2        3058 200000  ALGOL                                              N           NONE         NULL       N                               NULL            47.042083            40.955694             1.000000                 NULL              
;   NULL                 NULL                 NULL N                           NULL NULL                        NULL                 NULL              80.000000                 NULL                 NULL        NULL        NULL N                           
;                    NULL                           NULL        1082        NULL           1 LETG    HRC-S                 80.000000                           NULL GTO                           
printf,2,' <TITLE>OBSERVATION DATA OBS ID:'
print, strmid(line,10,10)
; 2        
print, strmid(line,8,10)
;   2      
printf,2, strmid(line,8,10)</title>
; % Syntax error.
printf,2, strmid(line,8,10)+'</title>'
printf,2, </HEAD>'
; % Syntax error.
printf,2, '</HEAD>'
printf,2,'<BODY TEXT="#DDDDDD" BGCOLOR="#000000" LINK="#FF0000" VLINK="#FFFF22" 
ALINK="#7500FF" background="stars.jpg">
; % Syntax error.
printf,2,'<BODY TEXT="#DDDDDD" BGCOLOR="#000000" LINK="#FF0000" VLINK="#FFFF22" ALINK="#7500FF" background="stars.jpg">'
close,2
close,1
print, strmid(line,8,10)
;   2      
print, strmid(line,18,10)
;  3058 200
print, strmid(line,28,10)
;000  ALGOL
print, strmid(line,31,10)
;  ALGOL   
print, strmid(line,33,20)
;ALGOL               
print, strmid(line,63,20)
;                    
print, strmid(line,83,20)
; N           NONE   
print, strmid(line,103,20)
;      NULL       N  
print, strmid(line,123,20)
;                    
print, strmid(line,143,20)
;         NULL       
print, strmid(line,147,10)
;     NULL 
print, strmid(line,150,10)
;  NULL    
print, strmid(line,160,10)
;        47
print, strmid(line,165,10)
;   47.0420
print, strmid(line,167,10)
; 47.042083
print, strmid(line,166,10)
;  47.04208
print, strmid(line,166,12)
;  47.042083 
print, strmid(line,176,12)
;3           
print, strmid(line,186,12)
;   40.955694
print, strmid(line,196,12)
;94          
print, strmid(line,206,12)
;     1.00000
print, strmid(line,250,50)
;       NULL                 NULL                 N
print, strmid(line,250,60)
;       NULL                 NULL                 NULL N     
print, strmid(line,250,70)
;       NULL                 NULL                 NULL N               
print, strmid(line,300,70)
;ULL N                           NULL NULL                        NULL 
print, strmid(line,320,50)
;            NULL NULL                        NULL 
print, strmid(line,340,30)
;L                        NULL 
print, strmid(line,360,10)
;     NULL 
print, strmid(line,355,15)
;          NULL 
print, strmid(line,375,15)
;           NULL
print, strmid(line,385,15)
; NULL          
print, strmid(line,395,15)
;         80.000
print, strmid(line,400,15)
;    80.000000  
print, strmid(line,450,70)
; NULL        NULL        NULL N                                       
print, strmid(line,500,70)
;                            NULL                           NULL       
print, strmid(line,550,70)
;         NULL        1082        NULL           1 LETG    HRC-S       
print, strmid(line,590,30)
;        1 LETG    HRC-S       
print, strmid(line,605,15)
;   HRC-S       
print, strmid(line,595,15)
;   1 LETG    HR
print, strmid(line,595,10)
;   1 LETG 
print, strmid(line,598,10)
;1 LETG    
print, strmid(line,599,10)
; LETG    H
print, strmid(line,599,8)
; LETG   
print, strmid(line,603,8)
;G    HRC
print, strmid(line,606,8)
;  HRC-S 
print, strmid(line,607,8)
; HRC-S  
print, strmid(line,8,10)
;   2      
print, compress(strmid(line,8,10))
; % Variable is undefined: COMPRESS.
print, WHTcompress(strmid(line,8,10))
; % Variable is undefined: WHTCOMPRESS.
?
print, strcompress(strmid(line,8,10))
; 2 
print, strcompress(strmid(line,8,10),remove=1)
;2
obs_html, obscat.txt
; % Expression must be a structure in this context: OBSCAT.
.run obs_html
; % Syntax error.
; % 1 Compilation errors in module $MAIN$.
.run obs_html
; % Program code area full.
; % Type of end does not match statement (END expected).
; % Library file does not contain a procedure or function.
; % Attempt to call undefined procedure/function: 'OBS_HTML'.
retall
.run obs_html
; % Program code area full.
; % Type of end does not match statement (END expected).
; % Library file does not contain a procedure or function.
; % Attempt to call undefined procedure/function: 'OBS_HTML'.
.run obs_html
; % Program code area full.
; % Type of end does not match statement (END expected).
; % Library file does not contain a procedure or function.
; % Attempt to call undefined procedure/function: 'OBS_HTML'.
.run obs_html
; % Library file does not contain a procedure or function.
; % Attempt to call undefined procedure/function: 'OBS_HTML'.
.run obs_html
.run obs_html
obs_html, 'obscat.txt'
$ls
.run obs_html
obs_html, 'obscat.txt'
; % OPENR: File unit is already open: 1.
close,1
obs_html, 'obscat.txt'
.run obs_html
obs_html, 'obscat.txt'
; % OPENR: File unit is already open: 1.
close,1
.run obs_html
obs_html, 'obscat.txt'
.run obs_html
obs_html, 'obscat.txt'
.run obs_html
obs_html, 'obscat.txt'
.run obs_html
obs_html, 'obscat.txt'
.run obs_html
obs_html, 'obscat.txt'
$wc obscat.txt
.run obs_html
obs_html, 'obscat.txt'
; % READF: End of file encountered. Unit: 1
;          File: obscat.txt
close,1
$ls
obs_html_all, 'obscat.txt'
; % Syntax error.
; % Attempt to call undefined procedure/function: 'OBS_HTML_ALL'.
retall
obs_html_all, 'obscat.txt'
.run obs_html_all
obs_html_all, 'obscat.txt'
.run obs_html_all
obs_html_all, 'obscat.txt'
; % READF: End of file encountered. Unit: 1
;          File: obscat.txt
close,1
.run obs_html_all
obs_html_all, 'obscat.txt'
; % OPENW: File unit is already open: 2.
close,2
.cont
; % READF: End of file encountered. Unit: 1
;          File: obscat.txt
close,1
close,2
$ls
$rm obscat.html
.run obs_html_all
obs_html_all, 'obscat.txt'
; % READF: End of file encountered. Unit: 1
;          File: obscat.txt
close,1
close,
; % Syntax error.
close,2
.cont
; % READF: File unit is not open: 1.
retall
.run obs_html_all
obs_html_all, 'obscat.txt'
; % READF: End of file encountered. Unit: 1
;          File: obscat.txt
close,1
close,2
retall
openr,3,'abstracts.out'
; % OPENR: Error opening file: abstracts.out.
;   No such file or directory

openr,3,'abstracts.out'
; % OPENR: Error opening file: abstracts.out.
;   Number of symbolic links encountered during path name traversal exceeds MAXSYMLINKS

openr,3,'abstracts.out'
readf,3,line
; % Input line is too long for input buffer of 32767 characters.
; % READF: Error encountered reading from file. Unit: 3
;          File: abstracts.out
readf,3,q
; % Input line is too long for input buffer of 32767 characters.
; % READF: Error encountered reading from file. Unit: 3
;          File: abstracts.out
readf,3,q(0:300)
; % Variable is undefined: Q.
close,3
openr,3,'abstracts.out',bufsize=2048
readf,3,line
; % Input line is too long for input buffer of 32767 characters.
; % READF: Error encountered reading from file. Unit: 3
;          File: abstracts.out
print, line
close,3
openr,3,'abstracts.shorter'
readf,3,line
print,line
; obsid       targid      abstract
readf,3,line
print,line
;            1        3050 Auroral phenomena in Jupiter are diagnostic of the structure, processes and energetics of its magnetosphere. Past X-ray observations have revealed latitudinal and longitudinal asymmetries, with spectra consistent with a model of
; sulfur and oxygen ions precipitating onto the Jovian atmosphere. This observation will provide a clear image of the X-ray emission during a full Jovian rotational period with spectral resolution sufficient to detect the expected emission linesif ion pre
;cipitations powers the X-ray aurora. Galilean moons immersed in the magnetosphere may emit X-rays due to particle bombardment, auroral activity or other process.
print,strmid(line,8,10)
;    1     
close,3
abstracts_html,dum
$pwd
.run abstracts_html
abstracts_html,dum
print,strmid(line,20,*)
; % Syntax error.
print,strmid(line,20,255)
; 3050 Auroral phenomena in Jupiter are diagnostic of the structure, processes and energetics of its magnetosphere. Past X-ray observations have revealed latitudinal and longitudinal asymmetries, with spectra consistent with a model of sulfur and oxygen i
;o
print,strmid(line,20,3000)
; 3050 Auroral phenomena in Jupiter are diagnostic of the structure, processes and energetics of its magnetosphere. Past X-ray observations have revealed latitudinal and longitudinal asymmetries, with spectra consistent with a model of sulfur and oxygen i
;ons precipitating onto the Jovian atmosphere. This observation will provide a clear image of the X-ray emission during a full Jovian rotational period with spectral resolution sufficient to detect the expected emission linesif ion precipitations powers t
;he X-ray aurora. Galilean moons immersed in the magnetosphere may emit X-rays due to particle bombardment, auroral activity or other process.
print,strmid(line,20,30000)
; 3050 Auroral phenomena in Jupiter are diagnostic of the structure, processes and energetics of its magnetosphere. Past X-ray observations have revealed latitudinal and longitudinal asymmetries, with spectra consistent with a model of sulfur and oxygen i
;ons precipitating onto the Jovian atmosphere. This observation will provide a clear image of the X-ray emission during a full Jovian rotational period with spectral resolution sufficient to detect the expected emission linesif ion precipitations powers t
;he X-ray aurora. Galilean moons immersed in the magnetosphere may emit X-rays due to particle bombardment, auroral activity or other process.
.run abstracts_html
abstracts_html,dum
.run abstracts_html
abstracts_html,dum
.run obs_html
 obs_html,'obscat.txt'
; % READF: End of file encountered. Unit: 1
;          File: obscat.txt
close,1
close,2
.run abstracts_html
abstracts_html,dum
