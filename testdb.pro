
fn = '~/testidldb.sav'

db = idldb(file=fn)
db->create
db->print_metadata


db->store, 'a0001', 'att1', 1
db->store, 'a0002', 'att1', 4
db->store, 'a0003', 'att2', 1234

d = db->get([0, 1, 2], 'att1', get_index=idx)

end
