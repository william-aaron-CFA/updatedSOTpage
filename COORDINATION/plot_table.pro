pro plot_table, fitstable, yaxis, xaxis = xaxis, extension = extension
;
;To run,
;plot_table, 'fitstablename.fits'
;will generate a set of all plots of all columns versus TIME.  Or
;plot_table, 'fitstablename.fits', 'TTYPE'
;will plot just TTYPE versus TIME.  Or
;plot_table, 'fitstablename.fits', 'TTYPE', xaxis = 'TTYPE2'
;will plot TTYPE vs TTYPE2.
;All plots to current plotting device.

if n_elements(xaxis) eq 0 then x_axis = 'TIME' else x_axis = $
strupcase(strtrim(xaxis, 2))
if n_elements(yaxis) eq 0 then y_axis = ''     else y_axis = $
strupcase(strtrim(yaxis, 2))
if n_elements(extension) eq 0 then extension = 1
table = mrdfits(fitstable, extension, header, /dscale, /silent)
a = findgen(33) * (!pi * 2 / 32.)
usersym, cos(a) , sin(a), /fill


;
ttypes = tag_names(table)
mjd = sxpar(header, 'MJDREF') + (sxpar(header, 'TIMEZERO') + table.time) / 86400.
if x_axis eq 'MJD' then xvalues = mjd else begin
    w = where(ttypes eq x_axis, nw)
    if nw eq 0 then begin
        print, 'Error: TTYPE ', x_axis, ' not recognized'
        return
    endif
    xvalues = table.(w(0))
    xvalues_save=xvalues; holds time for safe keeping

endelse
s = size(xvalues(0)) & xtype = s(1)
if xtype eq 7 then begin
    xnames = xvalues(uniq(xvalues, sort(xvalues)))
    xmin = 0 & xmax = n_elements(xnames) + 1 
    x = intarr(n_elements(xvalues))
    for i = 0, n_elements(xnames) - 1 do begin
        x(where(xvalues eq xnames(i))) = i + 1
    endfor
    xvalues = x
endif else begin
    xnames = ''
    xmin = min(xvalues, max = xmax)
endelse
;
ny = 0
if y_axis eq '' then begin
    y_axis = ttypes(ny)
    ny = ny + 1
endif
yloop:
if (ny ne 0) and (y_axis eq x_axis) then goto, nexty
if y_axis eq 'MJD' then xvalues = mjd else begin
    w = where(ttypes eq y_axis, nw)
    if nw eq 0 then begin
        print, 'Error: TTYPE ', y_axis, ' not recognized'
        return
    endif
    yvalues = table.(w(0))
endelse
s = size(yvalues(0)) & ytype = s(1)
if ytype eq 7 then begin
    ynames = yvalues(uniq(yvalues, sort(yvalues)))
    ymin = 0 & ymax = n_elements(ynames) + 1
    y = intarr(n_elements(yvalues))
    for i = 0, n_elements(ynames) - 1 do begin
        y(where(yvalues eq ynames(i))) = i + 1
    endfor
    yvalues = y
endif else begin
    ynames = ''
    ymin = min(yvalues, max = ymax)
ENDELSE

; eliminate bad data
gd= where (yvalues ne -99.0)
yvalues = yvalues(gd)
xvalues_save=xvalues
xvalues = xvalues(gd)

; remove the high and low from any fitting
k= sort(yvalues)

dec=(n_elements(yvalues)/7.)

ysorted = yvalues(k)
xsorted = xvalues(k)

ymin=min(ysorted(dec:*))-.1
ymax=max(ysorted(0:n_elements(k)-dec))+.1

fit=linfit(xsorted(dec:n_elements(k)-dec),ysorted(dec:n_elements(k)-dec))


;strip off the leading X
;fitst=strmid(fitstable,27,15)
;
if strmid(y_axis,0,1) then y_axis = strmid(y_axis,1,12)

if (xnames eq '') and (ynames(0) eq '') then begin

	if (ymax lt 1000.) then begin 
    plot, xvalues, yvalues, xrange = [xmin, xmax], yrange = [ymin, ymax], $
title = '!3'+y_axis, xtitle = x_axis + ' (Day of Year)', ytitle = y_axis, $
    psym = 8, xmargin = [20, 5],xthick=3,ythick=3,chars=3,charthick=3


oplot,xvalues,fit(0)+fit(1)*xvalues

	endif else begin
    plot, xvalues, alog10(yvalues > 1), xrange = [xmin, xmax], $
title = '!3'+y_axis, xtitle = x_axis + ' (Day of Year)', ytitle = 'Log '+ y_axis, $
    psym = 8, xmargin = [20, 5],xthick=3,ythick=3,chars=3,charthick=3


oplot,xvalues,alog10(fit(0)+fit(1)*xvalues)
	endelse

endif else if (xnames eq '') and (ynames(0) ne '') then begin
    plot, xvalues, yvalues, xrange = [xmin, xmax], yrange = [ymin, ymax], $
title = fitstable, xtitle = x_axis, ytitle = y_axis, $
    psym = 8, xmargin = [20, 5], yticks = n_elements(ynames), yminor = -1,$ 
ytickv = indgen(n_elements(ynames) + 1), $
    ytickname = [' ', ynames, ' ']

endif else if (xnames ne '') and (ynames(0) eq '') then begin
    plot, xvalues, yvalues, xrange = [xmin, xmax], yrange = [ymin, ymax], $
title = fitstable, xtitle = x_axis, ytitle = y_axis, $
    psym = 8, xmargin = [20, 5], xticks = n_elements(xnames), xminor = -1,$ 
xtickv = indgen(n_elements(xnames) + 1), $
    xtickname = [' ', xnames, ' ']

endif else if (xnames ne '') and (ynames(0) ne '') then begin
    plot, xvalues, yvalues, xrange = [xmin, xmax], yrange = [ymin, ymax], $
title = fitstable, xtitle = x_axis, ytitle = y_axis, $
    psym = 8, xmargin = [20, 5], xticks = n_elements(xnames), xminor = -1, $
xtickv = indgen(n_elements(xnames) + 1), $
   xtickname = [' ', xnames, ' '], yticks = n_elements(ynames), yminor = -1,$ 
ytickv = indgen(n_elements(ynames) + 1), $
    ytickname = [' ', ynames, ' ']
endif
;
nexty:
if ny ne 0 then begin
    xvalues=xvalues_save ; restore the time	
    ny = ny + 2
    if ny lt n_elements(ttypes) then begin
        y_axis = ttypes(ny)
        goto, yloop
    endif
endif
;
return
end
