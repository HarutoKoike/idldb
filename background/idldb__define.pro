
;
; background
@idldb::create.pro
@idldb::connect.pro
@idldb::save.pro
@idldb::print_metadata.pro
@idldb::store.pro
@idldb::get.pro
@idldb::get_id.pro
@idldb::show.pro
@idldb::remove_attr.pro
;
;



;-------------------------------------------------+
; 
;-------------------------------------------------+
function idldb::init, _extra=ex
compile_opt idl2
self->setproperty, _extra=ex

identifier = 'This is a data base created by "idldb" object.'
;
;*---------- initiate  ----------*
;
self.id           = ptr_new(/allocate)
self.data         = ptr_new(/allocate)
self.is_connected = 0b
self.metadata     = ptr_new(/allocate)
self.write_mode   = 0  ; 0:overwrite, 1:not overwrite
self.return_value = 0  ; return value for no data being stored
self.identifier   = identifier
;
; warning 
self.warning_statement['opening'] = '% Other process is opening' 



return, 1
end




;----------------------------------------------------------+
; 
;----------------------------------------------------------+
pro idldb::setproperty, file=file, description=description, $
                        is_connected=is_connected, $
                        t_connected=t_connected, return_value=return_value

compile_opt idl2
;
if keyword_set(file)         then self.file         = file
if keyword_set(description)  then self.description  = description
if keyword_set(is_connected) then self.is_connected = is_connected
if keyword_set(t_connected)  then self.t_connected  = t_connected
if keyword_set(return_value) then self.return_value = return_value
end





;----------------------------------------------------------+
; 
;----------------------------------------------------------+
pro idldb::getproperty, file=file, description=description, $
                        is_connected=is_connected, $
                        t_connected=t_connected, $
                        return_value=return_value, $
                        identifier=identifier, worning_statment=worning_statment
compile_opt idl2
;
if arg_present(file)         then file         = self.file         
if arg_present(description)  then description  = self.description  
if arg_present(is_connected) then is_connected = self.is_connected 
if arg_present(t_connected)  then t_connected  = self.t_connected 
if arg_present(return_value) then return_value = self.return_value 
if arg_present(identifier)   then identifier   = self.identifier 
;
if arg_present(warning_statement) then warning_statement = self.warning_statement 
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

return, idx
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
        idldb,                       $
        identifier:''               ,$
        file: ''                    ,$
        description: ''             ,$
        warning_statement:hash()    ,$
        opening, ''                 ,$
        is_connected: 0b            ,$
        t_connected: 0d             ,$
        write_mode:''               ,$
        return_value:0              ,$
        id: ptr_new(),               $  
        data: ptr_new(),             $
        metadata: ptr_new(),         $
        inherits idl_object          $
       }

end
