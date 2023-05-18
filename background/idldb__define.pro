


;
; background
@idldb::create.pro
@idldb::connect.pro
@idldb::save.pro
@idldb::print_metadata.pro
@idldb::store.pro
@idldb::get.pro
@idldb::show.pro
@idldb::remove_attr.pro
@idldb::add_metadata.pro
;
;



;-------------------------------------------------+
; 
;-------------------------------------------------+
function idldb::init, _extra=ex
compile_opt idl2




self->setproperty, _extra=ex
;
identifier = 'This is a data base created by "idldb" object.'
;
;*---------- initiate  ----------*
;
self.id              = ptr_new(/allocate)
self.data            = ptr_new(ptrarr(1), /allocate)
self.metadata        = ptr_new(/allocate)
self.is_connected    = 0b
self.writing_mode    = 0  ; 0:overwrite, 1:not overwrite
self.connecting_mode = 0  ; 0:overwrite, 1:not overwrite
self.return_value    = 0  ; return value for no data being stored
self.identifier      = identifier
;

return, 1
end




;----------------------------------------------------------+
; 
;----------------------------------------------------------+
pro idldb::setproperty, file=file, description=description, $
                        is_connected=is_connected, $
                        t_connected=t_connected, return_value=return_value, $
                        writing_mode=writing_mode, $
                        connecting_mode=connecting_mode

compile_opt idl2
;
if keyword_set(file)         then self.file         = file
if keyword_set(description)  then self.description  = description
if keyword_set(is_connected) then self.is_connected = is_connected
if keyword_set(t_connected)  then self.t_connected  = t_connected
if keyword_set(return_value) then self.return_value = return_value
if keyword_set(writing_mode) then self.writing_mode = writing_mode
if keyword_set(connecting_mode) then self.connecting_mode = connecting_mode
end





;----------------------------------------------------------+
; 
;----------------------------------------------------------+
pro idldb::getproperty, file=file, description=description, $
                        is_connected=is_connected, $
                        t_connected=t_connected, $
                        return_value=return_value, $
                        identifier=identifier, $
                        writing_mode=writing_mode, $
                        connecting_mode=connecting_mode
compile_opt idl2
;
if arg_present(file)         then file         = self.file         
if arg_present(description)  then description  = self.description  
if arg_present(is_connected) then is_connected = self.is_connected 
if arg_present(t_connected)  then t_connected  = self.t_connected 
if arg_present(return_value) then return_value = self.return_value 
;
; get only
if arg_present(identifier)     then identifier     = self.identifier 
if arg_present(connecting_mode) then connecting_mode = self.connecting_mode
if arg_present(writing_mode) then writing_mode = self.writing_mode
                                                     

;
end




;----------------------------------------------------------+
; 
;----------------------------------------------------------+
function idldb::conv_id2idx, id
compile_opt idl2
;
idx   = []
idarr = *(self.id)
;
for i = 0, n_elements(id) - 1 do begin
    idx0 = where(idarr eq id[i], /null)
    idx  = [idx, idx0]
endfor
;
if n_elements(idx) eq 0 then idx = -1
if n_elements(idx) eq 1 then idx = idx[0]

return, idx
end
 



;----------------------------------------------------------+
; 
;----------------------------------------------------------+
pro idldb::check_connected, _extra=ex
;
compile_opt idl2

if ~self.is_connected then $
    message, 'connection to database is not established.', _extra=ex

end





;----------------------------------------------------------+
; 
;----------------------------------------------------------+
function idldb::get_id, index=idx
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

if n_elements(id) eq 1 then id = id[0]
;
return, id  
end



;----------------------------------------------------------+
; 
;----------------------------------------------------------+
function idldb::record_exists, id
compile_opt idl2
;
self->check_connected
;
if n_elements(id) ne 1 or size(id, /type) ne 7 then $
    message, 'ID must be 1-element string'
;
idarr = *(self.id)
dum   = where(strmatch(idarr, id), count)
;
return, count eq 1
end



;----------------------------------------------------------+
; 
;----------------------------------------------------------+
function idldb::attribute_exists, id, attribute
compile_opt idl2
self->check_connected
;
if n_elements(id) ne 1 or size(id, /type) ne 7 then $
    message, 'ID must be 1-element string'
if n_elements(attribute) ne 1 or size(attribute, /type) ne 7 then $
    message, 'Attribute must be 1-element string'
;
idx = self->conv_id2idx(id)
idx = idx[0]
if idx eq -1 then return, 0
;
return, (*((*self.data)[idx])).haskey(attribute)
end




;----------------------------------------------------------+
; 
;----------------------------------------------------------+
function idldb::default_record
compile_opt idl2
return, hash('t_edit', 0d)
end




;===========================================================+
; ++ NAME ++
pro idldb__define 
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



void = {                             $
        idldb                       ,$
        file: ''                    ,$
        identifier:''               ,$
        description: ''             ,$
        is_connected: 0b            ,$
        t_connected: 0d             ,$
        ;
        ; settings
        writing_mode:0              ,$
        connecting_mode:0           ,$
        return_value:0              ,$
        ;
        id: ptr_new()               ,$  
        data: ptr_new()             ,$
        metadata: ptr_new()         ,$
        inherits idl_object          $
       }

end
