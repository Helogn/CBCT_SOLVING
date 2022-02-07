function ListPath = folder_search( path_target, extension_target )
list_dir = dir( path_target );
ListPath = {  };
for i = 1:1:length( list_dir )
    if isdir(fullfile( path_target, list_dir( i ).name ) ) && ~strcmp( list_dir( i ).name, '.' ) && ~strcmp( list_dir( i ).name, '..' )
        ListPathSub = folder_search( fullfile(path_target, list_dir( i ).name), extension_target );
        if ~isempty( ListPathSub )
            ListPath = [ ListPath;ListPathSub ];
        end
    else
        idx_dot = regexp( list_dir( i ).name, '\.' );
        file_extension = list_dir( i ).name( ( idx_dot( end  ) + 1 ):end  );
        if ~isempty( find( strcmp( file_extension, extension_target ) ) )
            ListPath = [ ListPath;fullfile( path_target, list_dir( i ).name ) ];
        end
    end
end
end
