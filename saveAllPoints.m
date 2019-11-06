
function  calcPara = saveAllPoints(allFid, uiDirMode, iWidth, iHeight, tu_x,tu_y,iYnN1, iY, iYn,iYnP2,~,iX,calcPara,calcAll)
    if(iX == 0) 
        iYnN1 = -iYnN1;
        iY = -iY;
        iYn = -iYn;
        iYnP2 = -iYnP2;
    end
    maxIndex = 64;
    if (((tu_x == 0) && (tu_y == 0))) 
        for i = 1:maxIndex
            for j = 1:maxIndex
                calcPara.computeMatri{i,j} = zeros(1,4);
            end
        end
    end

    calcPara.computeMatri{tu_y+1,tu_x+1} = zeros(1,4);
    calcPara.computeMatri{tu_y+1,tu_x+1}(1,1) = iYnN1;
    calcPara.computeMatri{tu_y+1,tu_x+1}(1,2) = iY;
    calcPara.computeMatri{tu_y+1,tu_x+1}(1,3) = iYn;
    calcPara.computeMatri{tu_y+1,tu_x+1}(1,4) = iYnP2;

    if(calcAll)
        fprintf(allFid, '%4d',iYn);
        calcPara.clac_index = calcPara.clac_index +1;
        if(mod(calcPara.clac_index,iWidth) == 0)
            fprintf(allFid, '\n');
        end
    end
end
