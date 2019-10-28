
function  fid = createFile(root_path,dir_path,uiDirMode)
    
    path =  strcat(root_path, dir_path);
    if ((exist(path,'dir'))==0)
       mkdir(path);
    end
   modePathRow = sprintf(strcat(path, 'mode_%d.txt'),uiDirMode);
   fid = fopen(modePathRow,'w+');

end


