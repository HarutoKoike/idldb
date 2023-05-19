pro idldb::close
compile_opt idl2
self->check_connected
;
self.is_connected = 0
;
restore, self.file
metadata['is_connecting'] = 0
save, id, data, metadata, filename=self.file, description=self.identifier


obj_destroy, self
end
