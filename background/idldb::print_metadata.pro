;===========================================================+
; ++ NAME ++
pro idldb::print_metadata
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
;===========================================================+
compile_opt idl2
;
self->check_connected


meta = *(self.metadata)
keys = meta.keys()

print, ' '
print, '-----------------------------------'
print, '% metadata of "' + self.file + '"'
print, '-----------------------------------'

foreach key, keys do begin
    if key eq 'created' then begin
            print, key, ' : ', systime(elapsed=meta[key])
            continue
    endif
    if key eq 'last_update' then begin
            print, key, ' : ', systime(elapsed=meta[key])
            continue
    endif
    print, key + ' : ', meta[key]
endforeach


end
