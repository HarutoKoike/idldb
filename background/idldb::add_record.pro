;===========================================================+
; ++ NAME ++
pro idldb::add_record, id
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

if size(id, /type) ne 7 then $
    message, 'ID must be string'

*(self.id)   = [*(self.id), id]
*(self.data) = [*(self.data), ptr_new(/allocate)]
end
