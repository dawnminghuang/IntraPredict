clc;
clear;
close all;
calcRow = 0;
calcCol = 0;
calcRepeat = 0;
calcAll  = 0;
calcMatri  = 1;
calcWidth = 4;
calcHeight = 4;
pointNumber = 4;
mode = [3 4 5 6 7 8 9];
g_tu_x_y = {
    % width/height
    [4 4];
    [8 8];
};
h264_path = './modeH264/';

for modeIndx = 1:length(mode)

    uiDirMode = mode(1,modeIndx);
    allFid = -1;
    if(calcRow)
       dir_path = 'modeOutRow/';
       rowFid = createFile(h264_path,dir_path,uiDirMode);
    elseif(calcCol)
       dir_path = 'modeOutCol/';
       colFid = createFile(h264_path,dir_path,uiDirMode);
    end
    if(calcRepeat)
       dir_path = 'modeOutRepeat/';
       repeatFid = createFile(h264_path,dir_path,uiDirMode);
    end
    if(calcAll)
       dir_path = 'AllOut/';
       allFid = createFile(h264_path,dir_path,uiDirMode);       
    end
    if(calcMatri)
       dir_path = 'modeOutMatri/';
       matriFid = createFile(h264_path,dir_path,uiDirMode);     
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
        if(iWidth == 4)
            Down_left_limit  = 3;
        else
            Down_left_limit = 7;
        end
        deltaPos = 0;
        if((iWidth == 4) && (iHeight == 4))
            if(uiDirMode == 3)
                for j  =0:iHeight-1
                    for i= 0:iWidth-1
                        if((i==Down_left_limit)&&(j==Down_left_limit))
                           iXnN1 = Down_left_limit*2;
                           iX = Down_left_limit*2;
                           iXn = Down_left_limit*2 + 1;
                           iXnP2 = Down_left_limit*2 + 1;
                        else
                           iXnN1 = i+j;
                           iX = i+j+1;
                           iXn = i+j+2;
                           iXnP2 =  i+j+2;
                        end
                        [iXnN1,iX,iXn, iXnP2] = convertXPoints(iXnN1,iX,iXn, iXnP2);
                        calcPara = saveAllPoints(allFid, uiDirMode, iWidth, iHeight, i, j, iXnN1, iX, iXn, iXnP2,1, 1, calcPara, calcAll);
                    end
                end  
            end

            if(uiDirMode == 4)
                for j  =0:iHeight-1
                    for i= 0:iWidth-1
                        if(i > j)
                           iXnN1 = i-j-2;
                           iX = i-j-1;
                           iXn = i-j;
                           iXnP2 = i-j;
                           [iXnN1,iX,iXn, iXnP2] = convertXPoints(iXnN1,iX,iXn, iXnP2);
                        elseif(i < j)
                           iXnN1 = j-i-2;
                           iX = j-i-1;
                           iXn = j-i;
                           iXnP2 = j-i;
                        else
                            iXnN1 = 0;
                            iX = -1;
                            iXn = -2;
                            iXnP2 = -2;
                        end
                        calcPara = saveAllPoints(allFid, uiDirMode, iWidth, iHeight, i, j, iXnN1, iX, iXn, iXnP2,1, 1, calcPara, calcAll);
                    end
                end  
            end
             if(uiDirMode == 5)
                for j  =0:iHeight-1
                    for i= 0:iWidth-1
                        zVR = 2*i - j;
                        if((zVR == 0)||(zVR == 2)||(zVR == 4) ||(zVR == 6))
                           iXnN1 = i-floor(j/2)-1;
                           iX = i-floor(j/2);
                           iXn = i-floor(j/2);
                           iXnP2 = i-floor(j/2);
                           [iXnN1,iX,iXn, iXnP2] = convertXPoints(iXnN1,iX,iXn, iXnP2);
                        elseif((zVR == 1)||(zVR == 3)||(zVR == 5))
                           iXnN1 = i-floor(j/2)-2;
                           iX = i-floor(j/2)-1 ;
                           iXn = i-floor(j/2);
                           iXnP2 = i-floor(j/2);
                           [iXnN1,iX,iXn, iXnP2] = convertXPoints(iXnN1,iX,iXn, iXnP2);
                        elseif(zVR == -1)
                            iXnN1 = 0;
                            iX = -1;
                            iXn = -2;
                            iXnP2 = -2;
                        else
                            iXnN1 = j -1;
                            iX = j -2;
                            iXn = j -3;
                            iXnP2 = j -3;
                        end
                        calcPara = saveAllPoints(allFid, uiDirMode, iWidth, iHeight, i, j, iXnN1, iX, iXn, iXnP2,1, 1, calcPara, calcAll);
                    end
                end  
            end       
            if(uiDirMode == 6)
                for j  =0:iHeight-1
                    for i= 0:iWidth-1
                        zHD = 2*j - i;
                        if((zHD == 0)||(zHD == 2)||(zHD == 4) ||(zHD == 6))
                           iXnN1 = j-floor(i/2)-1;
                           iX = j-floor(i/2);
                           iXn = j-floor(i/2);
                           iXnP2 = j-floor(i/2);
                        elseif((zHD == 1)||(zHD == 3)||(zHD == 5))
                           iXnN1 = j-floor(i/2)-2;
                           iX = j-floor(i/2)-1 ;
                           iXn = j -floor(i/2);
                           iXnP2 = j-floor(i/2);
                        elseif(zVR == -1)
                            iXnN1 = 0;
                            iX = -1;
                            iXn = -2;
                            iXnP2 = -2;
                        else
                            iXnN1 = i -1;
                            iX = i -2;
                            iXn = i -3;
                            iXnP2 = i -3;
                            [iXnN1,iX,iXn, iXnP2] = convertXPoints(iXnN1,iX,iXn, iXnP2);
                        end
                        calcPara = saveAllPoints(allFid, uiDirMode, iWidth, iHeight, i, j, iXnN1, iX, iXn, iXnP2,1, 1, calcPara, calcAll);
                    end
                end  
            end     

            if(uiDirMode == 7)
                for j  =0:iHeight-1
                    for i= 0:iWidth-1
                        if((j == 0)||(j == 2))
                           iXnN1 = i + floor(j/2);
                           iX = i + floor(j/2)+1;
                           iXn = i + floor(j/2)+1;
                           iXnP2 = i + floor(j/2)+1;
                           [iXnN1,iX,iXn, iXnP2] = convertXPoints(iXnN1,iX,iXn, iXnP2);
                        elseif((j == 1)||(j == 3))
                           iXnN1 = i + floor(j/2);
                           iX = i + floor(j/2)+1;
                           iXn = i + floor(j/2)+2;
                           iXnP2 = i + floor(j/2)+2;
                           [iXnN1,iX,iXn, iXnP2] = convertXPoints(iXnN1,iX,iXn, iXnP2);
                        end
                        calcPara = saveAllPoints(allFid, uiDirMode, iWidth, iHeight, i, j, iXnN1, iX, iXn, iXnP2,1, 1, calcPara, calcAll);
                    end
                end  
            end  

            if(uiDirMode == 8)
                for j  =0:iHeight-1
                    for i= 0:iWidth-1
                        zHU = 2*j + i;
                        if((zHU == 0)||(zHU == 2)||(zHU == 4))
                           iXnN1 = j + floor(i/2);
                           iX = j+floor(i/2) +1;
                           iXn = j+floor(i/2) +1;
                           iXnP2 = j+floor(i/2) +1;
                        elseif((zHU == 1)||(zHU == 3))
                           iXnN1 = j + floor(i/2);
                           iX = j + floor(i/2)+1 ;
                           iXn = j +floor(i/2)+2;
                           iXnP2 = j +floor(i/2)+2;
                        elseif(zHU == 5)
                            iXnN1 = 2;
                            iX = 3;
                            iXn = 3;
                            iXnP2 = 3;
                        else
                            iXnN1 = 3;
                            iX = 3;
                            iXn = 3;
                            iXnP2 = 3;
                        end
                        calcPara = saveAllPoints(allFid, uiDirMode, iWidth, iHeight, i, j, iXnN1, iX, iXn, iXnP2,1, 1, calcPara, calcAll);
                    end
                end  
            end  
        end
        if(iHeight == 8 && iWidth == 8)
            if(uiDirMode == 3)
                for j  =0:iHeight-1
                    for i= 0:iWidth-1
                        if((i==7)&&(j==7))
                           iXnN1 = 14;
                           iX = 14;
                           iXn = 15;
                           iXnP2 = 15;
                        else
                           iXnN1 = i+j;
                           iX = i+j+1;
                           iXn = i+j+2;
                           iXnP2 =  i+j+2;
                        end
                        [iXnN1,iX,iXn, iXnP2] = convertXPoints(iXnN1,iX,iXn, iXnP2);
                        calcPara = saveAllPoints(allFid, uiDirMode, iWidth, iHeight, i, j, iXnN1, iX, iXn, iXnP2,1, 1, calcPara, calcAll);
                    end
                end  
            end

            if(uiDirMode == 4)
                for j  =0:iHeight-1
                    for i= 0:iWidth-1
                        if(i > j)
                           iXnN1 = i-j-2;
                           iX = i-j-1;
                           iXn = i-j;
                           iXnP2 = i-j;
                           [iXnN1,iX,iXn, iXnP2] = convertXPoints(iXnN1,iX,iXn, iXnP2);
                        elseif(i < j)
                           iXnN1 = j-i-2;
                           iX = j-i-1 ;
                           iXn = j -i;
                           iXnP2 = j-i;
                        else
                            iXnN1 = 0;
                            iX = -1;
                            iXn = -2;
                            iXnP2 = -2;
                        end
                        calcPara = saveAllPoints(allFid, uiDirMode, iWidth, iHeight, i, j, iXnN1, iX, iXn, iXnP2,1, 1, calcPara, calcAll);
                    end
                end  
            end
             if(uiDirMode == 5)
                for j  =0:iHeight-1
                    for i= 0:iWidth-1
                        zVR = 2*i - j;
                        if((zVR == 0)||(zVR == 2)||(zVR == 4) ||(zVR == 6) || (zVR == 8)||(zVR == 10)||(zVR == 12) ||(zVR == 14))
                           iXnN1 = i-floor(j/2)-1;
                           iX = i-floor(j/2);
                           iXn = i-floor(j/2);
                           iXnP2 = i-floor(j/2);
                           [iXnN1,iX,iXn, iXnP2] = convertXPoints(iXnN1,iX,iXn, iXnP2);
                        elseif((zVR == 1)||(zVR == 3)||(zVR == 5) || (zVR == 7)||(zVR == 9)||(zVR == 11) ||(zVR == 13))
                           iXnN1 = i-floor(j/2)-2;
                           iX = i-floor(j/2)-1 ;
                           iXn = i-floor(j/2);
                           iXnP2 = i-floor(j/2);
                           [iXnN1,iX,iXn, iXnP2] = convertXPoints(iXnN1,iX,iXn, iXnP2);
                        elseif(zVR == -1)
                            iXnN1 = 0;
                            iX = -1;
                            iXn = -2;
                            iXnP2 = -2;
                        else
                            iXnN1 = j -2*i-1;
                            iX = j -2*i -2;
                            iXn = j -2*i -3;
                            iXnP2 = j -2*i -3;
                        end
                        calcPara = saveAllPoints(allFid, uiDirMode, iWidth, iHeight, i, j, iXnN1, iX, iXn, iXnP2,1, 1, calcPara, calcAll);
                    end
                end  
            end       
            if(uiDirMode == 6)
                for j  =0:iHeight-1
                    for i= 0:iWidth-1
                        zHD = 2*j - i;
                        if((zHD == 0)||(zHD == 2)||(zHD == 4) ||(zHD == 6) || (zHD == 8)||(zHD == 10)||(zHD == 12) ||(zHD == 14))
                           iXnN1 = j-floor(i/2)-1;
                           iX = j-floor(i/2);
                           iXn = j-floor(i/2);
                           iXnP2 = j-floor(i/2);
                        elseif((zHD == 1)||(zHD == 3)||(zHD == 5) || (zHD == 7)||(zHD == 9)||(zHD == 11) ||(zHD == 13))
                           iXnN1 = j-floor(i/2)-2;
                           iX = j-floor(i/2)-1 ;
                           iXn = j -floor(i/2);
                           iXnP2 = j-floor(i/2);
                        elseif(zVR == -1)
                            iXnN1 = 0;
                            iX = -1;
                            iXn = -2;
                            iXnP2 = -2;
                        else
                            iXnN1 = i - 2*j -1;
                            iX = i - 2*j -2;
                            iXn = i - 2*j -3;
                            iXnP2 = i - 2*j -3;
                            [iXnN1,iX,iXn, iXnP2] = convertXPoints(iXnN1,iX,iXn, iXnP2);
                        end
                        calcPara = saveAllPoints(allFid, uiDirMode, iWidth, iHeight, i, j, iXnN1, iX, iXn, iXnP2,1, 1, calcPara, calcAll);
                    end
                end  
            end     

            if(uiDirMode == 7)
                for j  =0:iHeight-1
                    for i= 0:iWidth-1
                        if((j == 0)||(j == 2) || (j == 4)||(j == 6))
                           iXnN1 = i + floor(j/2);
                           iX = i + floor(j/2)+1;
                           iXn = i + floor(j/2)+1;
                           iXnP2 = i + floor(j/2)+1;
                        elseif((j == 1)||(j == 3) || (j== 5)||(j == 7))
                           iXnN1 = i + floor(j/2);
                           iX = i + floor(j/2)+1;
                           iXn = i + floor(j/2)+2;
                           iXnP2 = i + floor(j/2)+2;
                        end
                        [iXnN1,iX,iXn, iXnP2] = convertXPoints(iXnN1,iX,iXn, iXnP2);
                        calcPara = saveAllPoints(allFid, uiDirMode, iWidth, iHeight, i, j, iXnN1, iX, iXn, iXnP2,1, 1, calcPara, calcAll);
                    end
                end  
            end  

            if(uiDirMode == 8)
                for j  =0:iHeight-1
                    for i= 0:iWidth-1
                        zHU = 2*j + i;
                        if((zHU == 0)||(zHU == 2)||(zHU == 4) || (zHU == 6)||(zHU == 8)||(zHU == 10) || (zHU == 12))
                           iXnN1 = j + floor(i/2);
                           iX = j+floor(i/2) +1;
                           iXn = j+floor(i/2) +1;
                           iXnP2 = j+floor(i/2) +1;
                        elseif((zHU == 1)||(zHU == 3) || (zHU == 5)||(zHU == 7) || (zHU == 9)||(zHU == 11))
                           iXnN1 = j + floor(i/2);
                           iX = j + floor(i/2)+1 ;
                           iXn = j +floor(i/2)+2;
                           iXnP2 = j +floor(i/2)+2;
                        elseif(zHU == 13)
                            iXnN1 = 6;
                            iX = 7;
                            iXn = 7;
                            iXnP2 = 7;
                        else
                            iXnN1 = 7;
                            iX = 7;
                            iXn = 7;
                            iXnP2 = 7;
                        end
                        calcPara = saveAllPoints(allFid, uiDirMode, iWidth, iHeight, i, j, iXnN1, iX, iXn, iXnP2,1, 1, calcPara, calcAll);
                    end
                end  
            end  
        end
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
    xlswrite(strcat(h264_path, 'modeOutRow/mode_distance_row.xlsx'),vdOut);
elseif(calcCol)
    xlswrite(strcat(h264_path, 'modeOutCol/mode_distance_col.xlsx'),vdOut);
end   
if(calcMatri)
    xlswrite(strcat(h264_path, 'modeOutMatri/mode_distance_matri.xlsx'),vdOut);
end
