
fn = '~/testidldb.sav'
;file_delete, fn

db = idldb(file=fn)
if ~file_test(fn) then db->create

db.writing_mode=0
db.connecting_mode=1

db->connect

db->store, 'a0001', 'att1', 1
db->store, 'a0001', 'att11', 1
db->store, 'a0002', 'att2', 2
db->store, 'a0003', 'att3', 3
;db->store, 'a0003', 3, 4

db->store, 'a0001', 'att1', 2
;
;
db->print_metadata
;

;db->save, /close


end
