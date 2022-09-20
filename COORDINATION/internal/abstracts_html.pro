PRO abstracts_html, obscat

;creates a set of html files from the obscat

openr, 3, 'abstracts.shorter'
line = 'x'

;READ IN THE FIRST TWO LINES OF JUNK
readf, 3, line





FOR i =  0, 947 DO BEGIN
readf, 3, line

obsid = strmid(line,8,10)
htmlname = strcompress(strmid(line,8,10),remove=1)+'.html'

openw, 2,  'tmp'

printf, 2, '<p> <hr> <font size=4> '
printf, 2, strmid(line,19,3000)

printf, 2, ' </font> '
close, 2

spawn, 'more tmp >>' + htmlname 
ENDFOR

close, 3

return
END
