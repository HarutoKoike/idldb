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


if self.is_connected then begin
    print, '% Already connected'
    return
endif


restore, self.file, description=desc


;
;*--------- check valid  ----------*
;
;
if ~strmatch(desc, self.identifier) then $
    message, '"' + self.file + '" is not a databese created by "idldb" object.' 



;
;*--------- check whether other process is opening file  ----------*
;
is_connecting = metadata['is_connecting']
;
if is_connecting and self.connecting_mode eq 0 then begin
    print, '% Other process is connecting database'
    print, '% Please wait until the process ends'
    self.is_connected = 0
    return
endif



;
;*--------- connect  ----------*
;
self.is_connected = 1
self.t_connected  = systime(/seconds)

if isa(id)   then *(self.id)   = id
if isa(data) then *(self.data) = data
*self.metadata = metadata


;
;*---------- save  ----------*
;
metadata['is_connecting'] = 1
save, metadata, filename=self.file, description=self.identifier


if ~keyword_set(quiet) then $
    print, '% Connection to "' + self.file + '" is established.' 

end
