
function  calcPara = writeDataToPid(fid,uiDirMode,iWidth, iHeight, tu_x,tu_y,iYnN1, iY, iYn,iYnP2,iDxy,iX,calcPara)
    if(iX == -1) 
        iYnN1 = -iYnN1;
        iY = -iY;
        iYn = -iYn;
        iYnP2 = -iYnP2;
    end

    % print first index and  distance 
    if (((tu_x == 0) && (tu_y == 0))) 
        for stIndex = 1:256 
            calcPara.start_index(stIndex) = 0;
        end
        calcPara.clac_number = 1;
        calcPara.clac_index = 1;
    end

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
        distance = abs(end_pos - start_pos);
        if (distance > calcPara.max_distance) 
            calcPara.max_distance = distance;
        end
        fprintf(fid, '%d  %d  %d  %d  %d  %d %d %d %d \n',uiDirMode, iWidth, iHeight, tu_x, tu_y, start_pos, end_pos, distance, calcPara.max_distance);
    end

end
