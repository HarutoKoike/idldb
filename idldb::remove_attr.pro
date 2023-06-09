;===========================================================+
; ++ NAME ++
pro idldb::remove_attr, id, attribute
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

;
;*---------  check valid ----------*
;
idarr = self.get_id()
if n_elements(idarr) eq 0 then return
;
att = (self->default_record()).keys()
att = att[0]
dum = where(strmatch(attribute, att), count) 
if count ne 0 then $
    message, 'Attribute "' + att + '" cannot be removed.'


;
;*---------- search index  ----------*
;
idx = []
;
;
if size(id, /type) eq 2 then begin
    idx = id
endif 

if size(id, /type) eq 7 then begin
    for i = 0, n_elements(id) - 1 do $
        idx = [idx, where( strmatch(idarr, id[i]), /null )]
endif

;
if n_elements(idx) eq 0 then return


;
;*---------- remove  ----------*
;
foreach i, idx do $
    (*((*(self.data))[i])).remove, attribute



end
