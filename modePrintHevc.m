clc;
clear;
close all;
calcRow = 0;
calcCol = 0;
calcRepeat = 0;
calcAll  = 1;
calcMatri4X2  = 0;
calcMatri2X4  = 0;
calcMatri  = 1;
VER_IDX = 26; %index for intra VERTICAL   mode  
HOR_IDX = 10; % index for intra HORIZONTAL mode


calcWidth = 4;
calcHeight = 4;
pointNumber = 4;
mode = [2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20  21 22 23 24 25 26 27 28 29 30 31 32 33 34];
angTable  = [0 2 5 9 13 17 21 26 32];
offset = [32 26 21 17 13 9 5 2 0 -2 -5 -9 -13 -17 -21 -26 -32 -26 -21 -17 -13 -9 -5 -2 0 2 5 9 13 17 21 26 32];
invAngTable = [0  4096  1638  910  630  482  390  315  256]; % (256 * 32)/Angle
g_tu_x_y = {
    % width/height
    [4 4];
    [8 8];
    [16 16];
    [32 32]; 
    [64 64]; 
};
hevc_path = './modeHevc/';

for modeIndx = 1:length(mode)

    uiDirMode = mode(1,modeIndx);
    allFid = -1;
    if(calcRow)
       dir_path = 'modeOutRow/';
       rowFid = createFile(hevc_path,dir_path,uiDirMode);
    elseif(calcCol)
       dir_path = 'modeOutCol/';
       colFid = createFile(hevc_path,dir_path,uiDirMode);
    end
    if(calcRepeat)
       dir_path = 'modeOutRepeat/';
       repeatFid = createFile(hevc_path,dir_path,uiDirMode);
    end
    if(calcAll)
       dir_path = 'AllOut/';
       allFid = createFile(hevc_path,dir_path,uiDirMode);       
    end
    if(calcMatri)
       dir_path = 'modeOutMatri/';
       matriFid = createFile(hevc_path,dir_path,uiDirMode);     
    end
    if(calcMatri4X2)
        dir_path = 'modeOutMatri4X2/';
        matri4X2Fid = createFile(hevc_path,dir_path,uiDirMode);          
    end
    if(calcMatri2X4)
        dir_path = 'modeOutMatri2X4/';
        matri2X4Fid = createFile(hevc_path,dir_path,uiDirMode);     
    end
    bIsModVer = (uiDirMode >= 18);
    if(bIsModVer)
        intraPredAngleMode = uiDirMode - VER_IDX;
    else
        intraPredAngleMode = -(uiDirMode - HOR_IDX);
    end
    absAngMode = abs(intraPredAngleMode);
    if(intraPredAngleMode<0)
        signAng = -1;
    else
        signAng = 1;
    end
    invAngle = invAngTable(1,absAngMode+1);
    absAng = angTable(1,absAngMode+1);
    intraPredAngle = signAng*absAng;
    calcPara.clac_index = 0;
    calcPara.clac_number = 1;
    calcPara.max_index = 0;
    calcPara.min_index = 0;
    calcPara.use_number = 4;
    calcPara.start_index = zeros(1,256);
    calcPara.max_distance = 0;

 
    for tuIndex = 1:length(g_tu_x_y)
        iWidth = g_tu_x_y{tuIndex,1}(1);
        iHeight = g_tu_x_y{tuIndex,1}(2);
        deltaPos = 0;
        if(bIsModVer)
            for j = 0:iHeight-1
                deltaPos = deltaPos + intraPredAngle;
                deltaInt   = fix(deltaPos/(2^5));
                for i = 0:iWidth-1
                   refMainIndex = i+deltaInt; 
                   calcPara = saveAllPoints(allFid, uiDirMode, iWidth, iHeight, i, j, refMainIndex, refMainIndex, refMainIndex+1,refMainIndex+1,1, 1, calcPara, calcAll);
                end
            end   
        else
            for i = 0:iWidth-1
                deltaPos = deltaPos + intraPredAngle;
                deltaInt   = fix(deltaPos/2^5);
                for j = 0:iHeight-1
                   refMainIndex = deltaInt-j -1; 
                   calcPara = saveAllPoints(allFid, uiDirMode, iWidth, iHeight, i, j, refMainIndex, refMainIndex, refMainIndex+1,refMainIndex+1,0, 1, calcPara, calcAll);
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
    xlswrite(strcat(hevc_path, 'modeOutRow/mode_distance_row.xlsx'),vdOut);
elseif(calcCol)
    xlswrite(strcat(hevc_path, 'modeOutCol/mode_distance_col.xlsx'),vdOut);
end   
if(calcMatri)
    xlswrite(strcat(hevc_path, 'modeOutMatri/mode_distance_matri.xlsx'),vdOut);
end
if(calcMatri4X2)
    xlswrite(strcat(hevc_path, 'modeOutMatri4X2/mode_distance_Matri4X2.xlsx'),vdOut);
end
if(calcMatri2X4)
    xlswrite(strcat(hevc_path, 'modeOutMatri2X4/mode_distance_Matri2X4.xlsx'),vdOut);
end