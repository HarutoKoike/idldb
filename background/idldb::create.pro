;===========================================================+
; ++ NAME ++
pro idldb::create
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
;*--------- create ----------*
;
now  = systime(/seconds)
;
metadata = hash('created', now, 'last_update', now, $
                'is_connecting', 0, 'description', '')
        


save, metadata, filename=self.file, description=self.identifier
end
