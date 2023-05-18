;===========================================================+
; ++ NAME ++
pro idldb::add_metadata, tag, metadata
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
self->check_connected
;
;
(*(self.metadata))[tag] = metadata
end
