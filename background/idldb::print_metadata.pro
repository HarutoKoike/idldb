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
for i = 0, n_elements(keys) - 1 do begin
    print, string(i, '(i5)') + ': ' + keys[i] + '  ', $
           meta[keys[i]]
endfor


end
