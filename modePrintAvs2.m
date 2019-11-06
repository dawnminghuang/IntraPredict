clc;
clear;
close all;
calcRow = 0;
calcCol = 0;
calcRepeat = 0;
calcAll  = 0;
calcMatri  = 1;
calcMatri4X2  = 0;
calcMatri2X4  = 0;
mode = [3 4 5 6 7 8 9 10 11 13 14 15 16 17 18 19 20  21 22 23 25 26 27 28 29 30 31 32];
g_aucXYflg = [0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 1 1 1 1 1 1 1 ];
g_aucSign = [0 0 -1 -1 -1 -1 -1 -1 -1 -1 -1 0 1 1 1 1 1 1 1 1 1 1 1 0 -1 -1 -1 -1 -1 -1 -1 -1];
g_aucDirDx = [0 0 11 2 11 1 8 1 4 1 1 0 1 1 4 1 8 1 11 2 11 4 8 0 8 4 11 2 11 1 8 1];
g_aucDirDy = [0 0 -4 -1 -8 -1 -11 -2 -11 -4 -8 0 8 4 11 2 11 1 8 1 4 1 1 0 -1 -1 -4 -1 -8 -1 -11 -2];
calcWidth = 4;
calcHeight = 4;
pointNumber = 4;
g_tu_x_y = {
        % width/height
        [4 16]; [4 4];
        [8 32]; [8 8];
        [16 16];[16 4];
        [32 32];[32 8]; 
        [64 64]; 
};
avs2_path = './modeAvs2/';

for modeIndx = 1:length(mode)

    uiDirMode = mode(1,modeIndx);
    allFid = -1;
        if(calcRow)
       dir_path = 'modeOutRow/';
       rowFid = createFile(avs2_path,dir_path,uiDirMode);
    elseif(calcCol)
       dir_path = 'modeOutCol/';
       colFid = createFile(avs2_path,dir_path,uiDirMode);
    end
    if(calcRepeat)
       dir_path = 'modeOutRepeat/';
       repeatFid = createFile(avs2_path,dir_path,uiDirMode);
    end
    if(calcAll)
       dir_path = 'AllOut/';
       allFid = createFile(avs2_path,dir_path,uiDirMode);       
    end
    if(calcMatri)
       dir_path = 'modeOutMatri/';
       matriFid = createFile(avs2_path,dir_path,uiDirMode);     
    end
    if(calcMatri4X2)
        dir_path = 'modeOutMatri4X2/';
        matri4X2Fid = createFile(avs2_path,dir_path,uiDirMode);          
    end
    if(calcMatri2X4)
        dir_path = 'modeOutMatri2X4/';
        matri2X4Fid = createFile(avs2_path,dir_path,uiDirMode);     
    end
    calcPara.clac_index = 1;
    calcPara.clac_number = 1;
    calcPara.max_index = 0;
    calcPara.min_index = 0;
    calcPara.use_number = 4;
    calcPara.start_index = zeros(1,256);
    calcPara.max_distance = 0;
    iDx = g_aucDirDx(1,uiDirMode);
    iDy = g_aucDirDy(1,uiDirMode);
    uixyflag = g_aucXYflg(1,uiDirMode);
    iDxy     = g_aucSign(1,uiDirMode);
    calcPara.mode = uiDirMode;
    for tuIndex = 1:length(g_tu_x_y)
        iWidth = g_tu_x_y{tuIndex,1}(1);
        iHeight = g_tu_x_y{tuIndex,1}(2);
        iWidth2 = bitshift(iWidth, 1);
        iHeight2 = bitshift(iHeight, 1);
        for j = 0:iHeight-1
            for i = 0:iWidth-1
                if(iDxy < 0)
                    if(uixyflag == 0)
                        iTempDy = j - (-1);
                        iTempDx = getContextPixel(uiDirMode, 0, iTempDy);
                        iX      = i + iTempDx;
                        iY      = -1;
                    else
                        iTempDx = i - (-1);
                        iTempDy = getContextPixel(uiDirMode, 1, iTempDx);
                        iX      = -1;
                        iY      = j + iTempDy;
                    end
                else
                    iTempDy = j - (-1);
                    iTempDx = getContextPixel(uiDirMode, 0, iTempDy);
                    iTempDx = -iTempDx;
                    iXx     = i + iTempDx;
                    iYx     = -1;

                    iTempDx = i - (-1);
                    iTempDy = getContextPixel(uiDirMode, 1, iTempDx);
                    iTempDy = -iTempDy;
                    iXy     = -1;
                    iYy     = j + iTempDy;

                    if (iYy <= -1)
                        iX = iXx;
                        iY = iYx;
                    else 
                        iX = iXy;
                        iY = iYy;
                    end
                end
                if (iY == -1) 
                    if (iDxy < 0) 
                        iXnN1 = iX - 1;
                        iXn   = iX + 1;
                        iXnP2 = iX + 2;
                    else 
                        iXnN1 = iX + 1;
                        iXn   = iX - 1;
                        iXnP2 = iX - 2;
                    end

                    iXnN1 = min(iWidth2 - 1, iXnN1);
                    iX    = min(iWidth2 - 1, iX);
                    iXn   = min(iWidth2 - 1, iXn);
                    iXnP2 = min(iWidth2 - 1, iXnP2);
                    calcPara = saveAllPoints(allFid, uiDirMode, iWidth, iHeight, i, j, iXnN1, iX, iXn, iXnP2,iDxy, 1, calcPara, calcAll);
                elseif (iX == -1) 
                    if (iDxy < 0) 
                        iYnN1 = iY - 1;
                        iYn   = iY + 1;
                        iYnP2 = iY + 2;
                    else 
                        iYnN1 = iY + 1;
                        iYn   = iY - 1;
                        iYnP2 = iY - 2;
                    end
                    iYnN1 = min(iHeight2 - 1, iYnN1);
                    iY    = min(iHeight2 - 1, iY);
                    iYn   = min(iHeight2 - 1, iYn);
                    iYnP2 = min(iHeight2 - 1, iYnP2);
                    calcPara = saveAllPoints(allFid, uiDirMode, iWidth, iHeight, i, j, iYnN1, iY, iYn, iYnP2,iDxy, 0, calcPara, calcAll);
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
plot(result.mode, result.distance +25);
hold on;
scatter(result.mode, result.distance +25);
vdOut = vd';
if(calcRow)
    xlswrite('./modeAvs2/modeOutRow/mode_distance_row.xlsx',vdOut);
elseif(calcCol)
    xlswrite('./modeAvs2/modeOutCol/mode_distance_col.xlsx',vdOut);
end   
if(calcMatri)
    xlswrite('./modeAvs2/modeOutMatri/mode_distance_Matri.xlsx',vdOut);
end
if(calcMatri4X2)
    xlswrite('./modeAvs2/modeOutMatri4X2/mode_distance_Matri4X2.xlsx',vdOut);
end
if(calcMatri2X4)
    xlswrite('./modeAvs2/modeOutMatri2X4/mode_distance_Matri2X4.xlsx',vdOut);
end