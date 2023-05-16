
fn = '~/testidldb.sav'

db = idldb(file=fn)
if ~file_test(fn) then db->create
db->connect, /force
db->print_metadata


db->store, 'a0001', 'att1', 1
db->store, 'a0002', 'att1', 4
db->store, 'a0003', 'att2', 1234
db->store, 'a0004', 'att1', 'fafa'
db->store, 'a0002', 'att4', 'test'
db->store, 'a0002', 'att4', 'test'

d = db->get(2, 'att1', get_index=idx)
d = db->get('a0002', 'att4', get_index=idx)
db->show


end
