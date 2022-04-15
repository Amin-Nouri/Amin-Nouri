function AA = imp_file(sstring)
[filename , pathname]=uigetfile('*.GRDECL',sstring);
if isequal(filename,0)
    disp('user selected cancel')
else
    disp(['user selected',fullfile(pathname, filename)])
end
fid = fopen(filename)';
% tline=fgetl(fid);

% AA = textscan(fid,'%%f');
AA = fscanf(fid,'%f',[1 inf])';
fclose(fid);
end

    