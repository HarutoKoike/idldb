;===========================================================+
; ++ NAME ++
pro idldb::show, idx
;
; ++ PURPOSE ++
;  -->
;
; ++ POSITIONAL ARGUMENTS ++
;  -->
;
; ++ KEYWORDS ++
; -->
;
; ++ CALLING SEQUENCE ++
;  -->
;
; ++ HISTORY ++
;  H.Koike 1/9,2021
;===========================================================+
compile_opt idl2

idarr = self->get_id()
data  = *(self.data)
;
if isa(idx) then begin
    idarr = idarr[idx]
    data  = data[idx]
endif
;

tab = '      '
for i = 0, n_elements(idarr) - 1 do begin
    print, ''
    print, ''
    print, '+-----------------------------------------------------+'
    print, ' ID:  ' + idarr[i]
    print, '+-----------------------------------------------------+'
    ;
    d    = *(data[i])
    keys = d.keys()
    ;
    print, tab, 'attribute', '        |        value'
    print, '+-----------------------------------------------------+'
    for j = 0, n_elements(keys) - 1 do begin
        print, tab, '"', keys[j], '"  ', d[keys[j]]
    endfor
endfor


end
