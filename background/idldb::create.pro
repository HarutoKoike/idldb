;===========================================================+
; ++ NAME ++
pro idldb::create, only_create=only_create
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
;*--------- file  ----------*
;
if strlen(self.file) eq 0 then $
    message, 'file name for database must be set to "file" property.'
;
if file_test(self.file) then $
    message, '"' + self.file + '" already exists.'
 


;
;*---------   ----------*
;

meta = self.metadata 
desc = self.identifier
now  = systime(/julian)

metadata = hash('creaded', now, 'last_update', now, $
                'is_connecting', 1)


        
;
;*---------   ----------*
;
save, metadata, filename=filename, description=self.identifier

if ~keyword_set(only_create) then begin
    self.is_connected = 1
    self.t_connected  = now
    *(self.metadata)  = metadata
endif
end
