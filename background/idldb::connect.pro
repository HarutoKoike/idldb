;===========================================================+
; ++ NAME ++
pro idldb::connect, quiet=quiet
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
; file test
if ~file_test(self.file) then $
    message, 'No file was found: "' + self.file + '"'


restore, self.file, description=desc


;
;*--------- check valid  ----------*
;
;
if ~strmatch(desc, self.identifier) then $
    message, '"' + self.file + '" is not a databese created by "idldb" object.' 



;
;*--------- check other process is opening file  ----------*
;
is_connecting = metadata['is_connecting']
if is_connecting then begin
    print, '% Other process is connecting database'
    print, '% Please wait until the process ends'
    self.is_conneted = 0
endif



;
;*---------   ----------*
;
self.is_connected = 1
self.t_connected  = systime(/julday)

if isa(id)   then *(self.id)   = id
if isa(data) then *(self.data) = data
;
*(self.metadata) = metadata

save, metadata, filename=self.filename


if ~keyword_set(quiet) then $
    print, '% Connection to "' + self.file + '" is established.' 

end
