
function  calcPara = writeDataToPid(fid,uiDirMode,iWidth, iHeight, tu_x,tu_y,iYnN1, iY, iYn,iYnP2,iDxy,iX,calcPara)
    if(iX == -1) 
        iYnN1 = -iYnN1;
        iY = -iY;
        iYn = -iYn;
        iYnP2 = -iYnP2;
    end

    computeIndex = mod(tu_x+tu_y+1,17);
    calcPara.computeMatri(computeIndex,1) = iYnN1;
    calcPara.computeMatri(computeIndex,2) = iY;
    calcPara.computeMatri(computeIndex,3) = iYn;
    calcPara.computeMatri(computeIndex,4) = iYnP2;
    
    if (((tu_x == 0) && (tu_y == 0))) 
        for stIndex = 1:256 
            calcPara.start_index(stIndex) = 0;
        end
        calcPara.clac_number = 1;
        calcPara.clac_index = 1;
        calcPara.modePrintAll = zeros(iHeight, iWidth);
    end
    
    % print all ix/iy
    if((uiDirMode == 23) &&(iWidth == 64) &&(iHeight == 64))
        calcPara.modePrintAll(tu_y+1,tu_x +1) =  iY;
    end
    
    % print first index and distance 
    if (((mod(tu_x,4) == 0) && (mod(tu_y,4)== 0))) 
        if (iDxy < 0) 
            calcPara.min_index = iYnN1;
        else 
            calcPara.min_index = iYnP2;
        end
        calcPara.start_index(calcPara.clac_number) = calcPara.min_index;
        calcPara.clac_number = calcPara.clac_number+1;
    end
		
    if (((mod(tu_x,4) == 3) && (mod(tu_y,4) == 3))) 
        if (iDxy < 0) 
            calcPara.max_index = iYnP2;
        else 
            calcPara.max_index = iYnN1;
        end
        end_pos = calcPara.max_index;
        start_pos = calcPara.start_index(calcPara.clac_index); 
        calcPara.clac_index = calcPara.clac_index + 1;
        distance = abs(end_pos - start_pos) +1;
        if (distance > calcPara.max_distance) 
            calcPara.max_distance = distance;
        end
        fprintf(fid, 'mode:%d  width:%d  height:%d  x:%d  y:%d  start_pos:%d  end_pos:%d distance:%d max_distance:%d \n',uiDirMode, iWidth, iHeight, tu_x, tu_y, start_pos, end_pos, distance, calcPara.max_distance);
    end
   
end
