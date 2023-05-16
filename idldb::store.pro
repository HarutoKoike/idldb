;===========================================================+
; ++ NAME ++
pro idldb::store, id, attribute, data
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
;*--------- check arguments are valid ----------*
;
if size(id, /type) ne 7 then $
    message, 'ID must be string.'
if n_elements(id) ne 1 then $
    message, 'ID must be 1-element.'
;
if size(attribute, /type) ne 7 then $
    message, 'Attribute must be string.'
if n_elements(attribute) ne 1 then $
    message, 'Attribute must be 1-element.'

;
if ~isa(data) then $
    message, 'Data is not set'



;
;*--------- if no data is stored yet  ----------*
;
idarr = self->get_id()
;
if n_elements(idarr) ne 0 then goto, skip1
;
record       = hash(attribute, data)
*(self.id)   = id
*(self.data) = ptr_new(record)
return




skip1:
;
;*--------- check ID exists  ----------*
;
nd    = n_elements(idarr)
idx   = where(strmatch(idarr, id, /fold_case), count) 
;
if count eq 0 then begin
    *(self.id)   = [*(self.id), id]
    *(self.data) = [*(self.data), ptr_new(/allocate)]
    ;
    idx = nd
    ;
    ; add new data
    *((*(self.data))[idx]) = hash(attribute, 0)
endif




;
;*--------- store data ----------*
;
; check attribute exists
;
idx    = idx[0]
record = (*(self.data))[idx]
record = *record
;
attr_exists = record.haskey(attribute)
;
if ~attr_exists then $
    record[attribute] = data
;
; overwrite mode
if attr_exists and self.write_mode eq 0 then $
    record[attribute] = data

;
; not overwrite mode
if attr_exists and self.write_mode ne 0 then begin
    print, '% ID: "' + id + '"'
    message, 'Attribute: "' + attribute + $
             '" is already exists.', /continue
    return
endif


*((*(self.data))[idx]) = record
end
