;===========================================================+
; ++ NAME ++
pro idldb::save, close=close, _extra=ex
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

id       = *(self.id)
data     = *(self.data)
metadata = *(self.metadata)

;
; date of last update 
metadata['last_update'] = systime(/seconds)

if keyword_set(close) then begin
    self.is_connected = 0
    metadata['is_connecting'] = 0
endif



save, id, data, metadata, $
      description=self.identifier, filename=self.file, $
      _extra=ex

end
