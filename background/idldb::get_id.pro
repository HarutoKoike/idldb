;===========================================================+
; ++ NAME ++
function idldb::get_id, index=idx
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
;
id = *(self.id)

if keyword_set(idx) then begin
    if size(idx, /type) ne 2 then $
        message, 'index must be integer'
    id = id[idx]
endif

return, id
end
