;==========================================================+
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
;
self->check_connected


;
;*--------- check arguments are valid ----------*
;
if size(id, /type) ne 7 or n_elements(id) ne 1 then $
    message, 'ID must be 1-element string.'
;
if size(attribute, /type) ne 7 or n_elements(attribute) ne 1 then $
    message, 'Attribute must be 1-element string.'

;
if ~isa(data) then $
    message, 'Data is not set'



;
;*--------- if no data is stored yet  ----------*
;
idarr = self->get_id()
nd    = n_elements(idarr)
;
if nd eq 0 then begin
    ;
    ; default hash record
    record           = self->default_record()
    record['t_edit'] = systime(/seconds)
    ;
    ;
    record[attribute] = data
    
    *self.id          = id
    (*(self.data))[0] = ptr_new(record)
    return
endif




;
;*--------- when record does not exist  ----------*
;
idx   = self->conv_id2idx(id)

;
if self->record_exists(id) eq 0 then begin
    record            = self->default_record()
    record['t_edit']  = systime(/seconds)
    record[attribute] = data
    ;
    *(self.id)     = [*(self.id), id]
    *(self.data)   = [*(self.data), ptr_new(record)]
    return
endif



;
;*--------- store data ----------*
;
; check attribute exists
;
;
attr_exists = self->attribute_exists(id, attribute)
;
if ~attr_exists or (attr_exists and self.writing_mode eq 0) then begin
    (*((*self.data)[idx]))[attribute] = data
    (*((*self.data)[idx]))['t_edit']  = systime(/seconds)
endif



;
; not overwrite mode
if attr_exists and self.writing_mode ne 0 then begin
    print, '% ID: "' + id + '"'
    message, 'Attribute: "' + attribute + $
             '" is already exists.', /continue
    return
endif



end
