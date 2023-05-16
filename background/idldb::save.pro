;===========================================================+
; ++ NAME ++
pro idldb::save, close=close
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

save, *(self.id), *(self.data), *(self.metadata), $
      description=self.identifier, filename=self.file

if keyword_set(close) then $
    self.is_connected = 0
end
