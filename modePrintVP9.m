clc;
clear;
close all;
calcRow = 0;
calcCol = 0;
calcRepeat = 0;
calcAll  = 0;
calcMatri  = 0;
calcMatri4X2  = 0;
calcMatri2X4  = 1;
calcWidth = 4;
calcHeight = 4;
pointNumber = 4;
mode = [1 2 3 4 5 6];
%mode = [4];
modeName = {'d207', 'd63' ,'d45' ,'d117','d135' ,'d153'};
g_tu_x_y = {
    % width/height
    [4 4];
    [8 8];
    [16 16];
    [32 32];
    %[64 64];
};
vp9_path = './modeVP9/';

for modeIndx = 1:length(mode)

    uiDirMode = mode(1,modeIndx);
    allFid = -1;
    if(calcRow)
       dir_path = 'modeOutRow/';
       rowFid = createVP9File(vp9_path,dir_path,uiDirMode, modeName);
    elseif(calcCol)
       dir_path = 'modeOutCol/';
       colFid = createVP9File(vp9_path,dir_path,uiDirMode, modeName);
    end
    if(calcRepeat)
       dir_path = 'modeOutRepeat/';
       repeatFid = createVP9File(vp9_path,dir_path,uiDirMode, modeName);
    end
    if(calcAll)
       dir_path = 'AllOut/';
       allFid = createVP9File(vp9_path,dir_path,uiDirMode,modeName);       
    end
    if(calcMatri)
       dir_path = 'modeOutMatri/';
       matriFid = createVP9File(vp9_path,dir_path,uiDirMode,modeName);     
    end
    if(calcMatri4X2)
        dir_path = 'modeOutMatri4X2/';
        matri4X2Fid = createFile(vp9_path,dir_path,uiDirMode);          
    end
    if(calcMatri2X4)
        dir_path = 'modeOutMatri2X4/';
        matri2X4Fid = createFile(vp9_path,dir_path,uiDirMode);     
    end
    calcPara.clac_index = 1;
    calcPara.use_number = 4;
    calcPara.clac_number = 1;
    calcPara.max_index = 0;
    calcPara.min_index = 0;
    calcPara.start_index = zeros(1,256);
    calcPara.max_distance = 0;
    Down_left_limit = 0;
    for tuIndex = 1:length(g_tu_x_y)
        iWidth = g_tu_x_y{tuIndex,1}(1);
        iHeight = g_tu_x_y{tuIndex,1}(2);
        bs  = iWidth;
        calcPara = initVP9Matri(calcPara);
        if(uiDirMode == 1)
            for j  =0:iHeight-1
                for i= 0:iWidth-1
                    if((i == 0) && (j~= iHeight-1))
                       iXnN1 = j;
                       iX = j+1;
                       iXn = j+1;
                       iXnP2 = j+1;
                       calcPara = saveVP9AllPoints(iXnN1,iX,iXn,iXnP2,calcPara,j*bs+1);
                    elseif((i == 1) &&(j~=iHeight-1) &&(j~=iHeight-2))
                       iXnN1 = j;
                       iX = j+1;
                       iXn = j+2;
                       iXnP2 = j+2;
                       calcPara = saveVP9AllPoints(iXnN1,iX,iXn,iXnP2,calcPara,j*bs+2);
                    elseif((i == 1) &&(j==iHeight-2))
                       iXnN1 = iHeight -1;
                       iX = iHeight - 2;
                       iXn = iHeight -2;
                       iXnP2 = iHeight -2;
                       calcPara = saveVP9AllPoints(iXnN1,iX,iXn,iXnP2,calcPara,j*bs+2);
                    elseif(j == iHeight-1)
                       iXnN1 = iHeight -1;
                       iX = iHeight -1;
                       iXn = iHeight -1;
                       iXnP2 = iHeight -1;
                       calcPara = saveVP9AllPoints(iXnN1,iX,iXn,iXnP2,calcPara,(bs-1)*bs+i+1);
                    end
                    calcPara = saveAllPoints(allFid, uiDirMode, iWidth, iHeight, i, j, iXnN1, iX, iXn, iXnP2,1, 1, calcPara, calcAll);
                end
            end  
            calcPara.dstCell = convertCellToMatri(calcPara.vp9Matri,calcPara.dstCell, iWidth, iHeight);
            for i  =2:iWidth-1
                for j= 0:iHeight-2
                   iXnN1 = calcPara.vp9Matri{1,(j+1)*bs + i+1 -2}(1);
                   iX = calcPara.vp9Matri{1,(j+1)*bs + i+1 -2}(2);
                   iXn = calcPara.vp9Matri{1,(j+1)*bs + i+1 -2}(3);
                   iXnP2 = calcPara.vp9Matri{1,(j+1)*bs + i+1 -2}(4);
                   calcPara = saveVP9AllPoints(iXnN1,iX,iXn,iXnP2,calcPara,j*bs + i +1);
                   calcPara = saveAllPoints(allFid, uiDirMode, iWidth, iHeight, i, j, iXnN1, iX, iXn, iXnP2,1, 1, calcPara, calcAll);
                end
            end  
        end
        calcPara.dstCell = convertCellToMatri(calcPara.vp9Matri,calcPara.dstCell, iWidth, iHeight);

        if(uiDirMode == 2)
            for j  =0:iHeight-1
                for i= 0:iWidth-1
                    if(mod(j,2) == 1)
                       iXnN1 = floor(j/2) + i;
                       iX =  floor(j/2) + i +1;
                       iXn = floor(j/2) + i +2;
                       iXnP2 = floor(j/2) + i +2;        
                    else
                       iXnN1 = floor(j/2)+i;
                       iX = floor(j/2)+i +1;
                       iXn = floor(j/2)+i +1;
                       iXnP2 = floor(j/2)+i +1;
                    end
                    calcPara = saveAllPoints(allFid, uiDirMode, iWidth, iHeight, i, j, iXnN1, iX, iXn, iXnP2,1, 1, calcPara, calcAll);
                end
            end  
        end

        if(uiDirMode == 3)
            for j  =0:iHeight-1
                for i= 0:iWidth-1
                    if((i+j+2) < (2*bs))
                       iXnN1 = j + i;
                       iX =  j + i +1;
                       iXn = j + i + 2;
                       iXnP2 = j + i + 2;        
                    else
                       iXnN1 = bs*2-1;
                       iX = bs*2-1;
                       iXn = bs*2-1;
                       iXnP2 = bs*2-1;
                    end
                    calcPara = saveAllPoints(allFid, uiDirMode, iWidth, iHeight, i, j, iXnN1, iX, iXn, iXnP2,1, 1, calcPara, calcAll);
                end
            end  
        end
       if(uiDirMode == 4)
            for j  =0:iHeight-1
                for i= 0:iWidth-1
                    if((j == 0))
                       iXnN1 = i-1;
                       iX = i;
                       iXn =  i;
                       iXnP2 =  i;
                       calcPara = saveVP9AllPoints(iXnN1,iX,iXn,iXnP2,calcPara,i+1);
                       calcPara = saveAllPoints(allFid, uiDirMode, iWidth, iHeight, i, j, iXnN1, iX, iXn, iXnP2,1, 1, calcPara, calcAll);
                    elseif((j == 1) &&(i~=0))
                       iXnN1 = i -2 ;
                       iX = i-1;
                       iXn = i;
                       iXnP2 = i;
                       calcPara = saveVP9AllPoints(iXnN1,iX,iXn,iXnP2,calcPara,bs+i+1);
                       calcPara = saveAllPoints(allFid, uiDirMode, iWidth, iHeight, i, j, iXnN1, iX, iXn, iXnP2,1, 1, calcPara, calcAll);
                    elseif((j == 1) &&(i==0))
                       iXnN1 = -2;
                       iX = -1;
                       iXn = 0;
                       iXnP2 = 0;
                       calcPara = saveVP9AllPoints(iXnN1,iX,iXn,iXnP2,calcPara,bs+1);
                       calcPara = saveAllPoints(allFid, uiDirMode, iWidth, iHeight, i, j, iXnN1, iX, iXn, iXnP2,1, 1, calcPara, calcAll);
                    elseif((j == 2) &&(i==0))
                       iXnN1 = -1;
                       iX = - 2;
                       iXn = -3;
                       iXnP2 = -3;
                       calcPara = saveVP9AllPoints(iXnN1,iX,iXn,iXnP2,calcPara,2*bs+1);
                       calcPara = saveAllPoints(allFid, uiDirMode, iWidth, iHeight, i, j, iXnN1, iX, iXn, iXnP2,1, 1, calcPara, calcAll);
                    elseif(i == 0)
                       iXnN1 = j -3;
                       iX = j -2;
                       iXn = j -1;
                       iXnP2 = j -1;
                       [iXnN1,iX,iXn, iXnP2] = convertXPoints(iXnN1,iX,iXn, iXnP2);
                       calcPara = saveVP9AllPoints(iXnN1,iX,iXn,iXnP2,calcPara,j*bs+1);
                       calcPara = saveAllPoints(allFid, uiDirMode, iWidth, iHeight, i, j, iXnN1, iX, iXn, iXnP2,1, 1, calcPara, calcAll);
                    end
                end
            end  
            calcPara.dstCell = convertCellToMatri(calcPara.vp9Matri,calcPara.dstCell, iWidth, iHeight);
            for j  =2:iHeight-1
                for i= 1:iWidth-1
                   iXnN1 = calcPara.vp9Matri{1,(j-2)*bs + i}(1);
                   iX = calcPara.vp9Matri{1,(j-2)*bs + i}(2);
                   iXn = calcPara.vp9Matri{1,(j-2)*bs + i}(3);
                   iXnP2 = calcPara.vp9Matri{1,(j-2)*bs + i}(4);
                   calcPara = saveVP9AllPoints(iXnN1,iX,iXn,iXnP2,calcPara,j*bs + i +1);
                   calcPara = saveAllPoints(allFid, uiDirMode, iWidth, iHeight, i, j, iXnN1, iX, iXn, iXnP2,1, 1, calcPara, calcAll);
                end
            end  
        calcPara.dstCell = convertCellToMatri(calcPara.vp9Matri,calcPara.dstCell, iWidth, iHeight);
        end

       if(uiDirMode == 5)
            for j  =0:iHeight-1
                for i= 0:iWidth-1
                    if((j == 0) &&(i==0))
                       iXnN1 = -2;
                       iX = -1;
                       iXn =  0;
                       iXnP2 =  0;
                       calcPara = saveVP9AllPoints(iXnN1,iX,iXn,iXnP2,calcPara,1);
                    elseif((j == 0) &&(i~=0))
                       iXnN1 =i -2 ;
                       iX = i-1;
                       iXn = i;
                       iXnP2 = i;
                       calcPara = saveVP9AllPoints(iXnN1,iX,iXn,iXnP2,calcPara,i+1);
                    elseif((j == 1) &&(i==0))
                       iXnN1 =  -1;
                       iX = - 2;
                       iXn = -3;
                       iXnP2 = -3;
                       calcPara = saveVP9AllPoints(iXnN1,iX,iXn,iXnP2,calcPara,bs+1);
                    elseif((j >= 2) &&(i==0))
                       iXnN1 = j-2;
                       iX = j-1;
                       iXn = j;
                       iXnP2 = j;
                       [iXnN1,iX,iXn, iXnP2] = convertXPoints(iXnN1,iX,iXn, iXnP2);
                       calcPara = saveVP9AllPoints(iXnN1,iX,iXn,iXnP2,calcPara,j*bs+1);
                    end
                    calcPara = saveAllPoints(allFid, uiDirMode, iWidth, iHeight, i, j, iXnN1, iX, iXn, iXnP2,1, 1, calcPara, calcAll);
                end
            end  
            calcPara.dstCell = convertCellToMatri(calcPara.vp9Matri,calcPara.dstCell, iWidth, iHeight);
            for j  =1:iHeight-1
                for i= 1:iWidth-1
                   iXnN1 = calcPara.vp9Matri{1,(j-1)*bs + i}(1);
                   iX = calcPara.vp9Matri{1,(j-1)*bs + i}(2);
                   iXn = calcPara.vp9Matri{1,(j-1)*bs + i}(3);
                   iXnP2 = calcPara.vp9Matri{1,(j-1)*bs + i}(4);
                   calcPara = saveVP9AllPoints(iXnN1,iX,iXn,iXnP2,calcPara,j*bs + i +1);
                   calcPara = saveAllPoints(allFid, uiDirMode, iWidth, iHeight, i, j, iXnN1, iX, iXn, iXnP2,1, 1, calcPara, calcAll);
                end
            end  
        end
       calcPara.dstCell = convertCellToMatri(calcPara.vp9Matri,calcPara.dstCell, iWidth, iHeight);
       if(uiDirMode == 6)
            for j  =0:iHeight-1
                for i= 0:iWidth-1
                    if((j == 0) &&(i==0))
                       iXnN1 = -1;
                       iX = -2;
                       iXn =  -2;
                       iXnP2 = -2;
                       calcPara = saveVP9AllPoints(iXnN1,iX,iXn,iXnP2,calcPara,1);
                    elseif((j~= 0) &&(i==0))
                       iXnN1 =j -1 ;
                       iX = j;
                       iXn = j;
                       iXnP2 = j;
                       [iXnN1,iX,iXn, iXnP2] = convertXPoints(iXnN1,iX,iXn, iXnP2);
                       calcPara = saveVP9AllPoints(iXnN1,iX,iXn,iXnP2,calcPara,j*bs+1);
                    elseif((j == 0) &&(i==1))
                       iXnN1 =  -2;
                       iX = - 1;
                       iXn = 0;
                       iXnP2 = 0;
                       calcPara = saveVP9AllPoints(iXnN1,iX,iXn,iXnP2,calcPara,2);
                    elseif((j == 1) &&(i==1))
                       iXnN1 =-1;
                       iX = -2;
                       iXn = -3;
                       iXnP2 = -3;
                       calcPara = saveVP9AllPoints(iXnN1,iX,iXn,iXnP2,calcPara,bs+2);
                    elseif((j >= 2) &&(i==1))
                       iXnN1 = j -2;
                       iX = j -1;
                       iXn = j;
                       iXnP2 =j;
                       [iXnN1,iX,iXn, iXnP2] = convertXPoints(iXnN1,iX,iXn, iXnP2);
                       calcPara = saveVP9AllPoints(iXnN1,iX,iXn,iXnP2,calcPara,j*bs+2);
                    elseif((i >= 2) &&(j==0))
                       iXnN1 = i -3;
                       iX = i -2;
                       iXn = i-1;
                       iXnP2 = i-1;
                       calcPara = saveVP9AllPoints(iXnN1,iX,iXn,iXnP2,calcPara,i+1);
                    end
                    calcPara = saveAllPoints(allFid, uiDirMode, iWidth, iHeight, i, j, iXnN1, iX, iXn, iXnP2,1, 1, calcPara, calcAll);
                end
            end  
            calcPara.dstCell = convertCellToMatri(calcPara.vp9Matri,calcPara.dstCell, iWidth, iHeight);
            for j  =1:iHeight-1
                for i= 2:iWidth-1
                   iXnN1 = calcPara.vp9Matri{1,(j-1)*bs + i +1 -2}(1);
                   iX = calcPara.vp9Matri{1,(j-1)*bs + i +1 -2}(2);
                   iXn = calcPara.vp9Matri{1,(j-1)*bs + i +1 -2}(3);
                   iXnP2 = calcPara.vp9Matri{1,(j-1)*bs + i +1 -2}(4);
                   calcPara = saveVP9AllPoints(iXnN1,iX,iXn,iXnP2,calcPara,j*bs + i +1);
                   calcPara = saveAllPoints(allFid, uiDirMode, iWidth, iHeight, i, j, iXnN1, iX, iXn, iXnP2,1, 1, calcPara, calcAll);
                end
            end  
        end
        calcPara.dstCell = convertCellToMatri(calcPara.vp9Matri,calcPara.dstCell, iWidth, iHeight);
        if(calcRow)
            %compute row
            calcPara = computeDistanceRow(rowFid, uiDirMode, iWidth, iHeight,calcPara);
        elseif(calcCol)
            %compute col
            calcPara = computeDistanceCol(colFid, uiDirMode, iWidth, iHeight,calcPara);
        end       
        if(calcRepeat)
            calcPara = computeRepeatPoint(repeatFid, uiDirMode, iWidth, iHeight,calcPara);
        end
        if(calcMatri)
            calcPara = computeDistance(matriFid,uiDirMode, iWidth, iHeight,calcPara);
        end
        if(calcMatri4X2)
            calcPara = computeDistanceMatri4X2(matri4X2Fid,uiDirMode, iWidth, iHeight,calcPara);
        end
        if(calcMatri2X4)
            calcPara = computeDistanceMatri2X4(matri2X4Fid,uiDirMode, iWidth, iHeight,calcPara);
        end
    end

    result.mode(modeIndx) = uiDirMode
    result.distance(modeIndx) = calcPara.max_distance
end

vd = [result.mode; result.distance];
hold on;
plot(result.mode, result.distance);
hold on;
scatter(result.mode, result.distance);
vdOut = vd';
if(calcRow)
    xlswrite(strcat(vp9_path, 'modeOutRow/mode_distance_row.xlsx'),vdOut);
elseif(calcCol)
    xlswrite(strcat(vp9_path, 'modeOutCol/mode_distance_col.xlsx'),vdOut);
end   
if(calcMatri)
    xlswrite(strcat(vp9_path, 'modeOutMatri/mode_distance_matri.xlsx'),vdOut);
end
if(calcMatri4X2)
    xlswrite(strcat(vp9_path, 'modeOutMatri4X2/mode_distance_Matri4X2.xlsx'),vdOut);
end
if(calcMatri2X4)
    xlswrite(strcat(vp9_path, 'modeOutMatri2X4/mode_distance_Matri2X4.xlsx'),vdOut);
end
