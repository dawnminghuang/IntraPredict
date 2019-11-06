
function  fid = createVP9File(root_path,dir_path,uiDirMode, modePath)
    
    path =  strcat(root_path, dir_path);
    if ((exist(path,'dir'))==0)
       mkdir(path);
    end
   modeNamePath = modePath{1,uiDirMode};
   modePathRow = strcat(path,strcat(modeNamePath,'.txt'));
   fid = fopen(modePathRow,'w+');

end


