;===========================================================+
; ++ NAME ++
function idldb::get, id0, attribute, get_index=get_index, pointer=pointer
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
;*---------  check argument valid ----------*
;
if size(id0, /type) ne 2 and size(id0, /type) ne 7 then $
    message, 'input of id must be integer or string.'
if size(attribute, /type) ne 7 or n_elements(attribute) ne 1 then $
    message, 'attribute must be 1-element string.'


idarr = self->get_id()
;
;*--------- if no data ----------*
;
if n_elements(idarr) eq 0 then begin
    message, 'No data has been stored yet!', /continue
    return, self.return_value
endif



;
;*--------- get index  ----------*
;
if size(id0, /type) eq 2 then begin
    idx = id0
endif else begin
    idx = self->idl
endelse

stop
;
if n_elements(idx) eq 0 then return, self.return_value




;
;*---------  check attribute exists ----------*
;
records = (*(self.data))[idx]
;
; expression of lambda function
lam = 'rec:*rec.haskey("' + attribute + '")'
;
idx_attrexists = records.map(lambda(lam))
idx_attrexists = where(idx_attrexists eq 1, count)
if count eq 0 then return, self.return_value
;
; index
if arg_present(get_index) then get_index = idx[idx_attrexists]



;
;*--------- return ----------*
;
records = records[idx_attrexists]
;
lam = 'rec:ptr_new( *(rec)["' + attribute + '"])'
data    = records.map(lambda(lam))
;
if keyword_set(pointer) then begin 
    return, data
endif

if n_elements(data) eq 1 then return, *data



lam1 = 'd:size(*d["' + attribute + '"], /type)' 
lam2 = 'd:n_elements(*d["' + attribute + '"])' 
print, lam1, lam2
stop
check_type     = data.map( lambda(lam1) )
check_1element = data.map( lambda(lam2) )

dum1 = where(check_type eq check_type[0], count1)
dum2 = where(check_1element eq 1, count2)

nd   = n_elements(data)
disc = (count1 eq nd) and (count2 eq nd)

if ~disc then return, data

d0  = (*(data[0]))[attribute]
arr = make_array(nd, type=size(d0, /type))
;
for i = 0, nd - 1 do begin
    help, *(data[i])
    arr[i] = (*(data[i]))[attribute]    
endfor


return, arr

end
