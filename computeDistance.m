
function  calcPara = computeDistance(fid,uiDirMode, iWidth, iHeight,calcPara)
    
    computeSize = 4;
    widthNumber = iWidth /computeSize;
    heightNumber = iHeight/computeSize;
    if(calcPara.use_number == computeSize)
       calcMatri = zeros(computeSize^2,computeSize); 
    else
       calcMatri = zeros(computeSize^2,1);
    end
    calcMatriIndex = 1;
    for j = 1:heightNumber
        for i = 1:widthNumber
            for m = ((j-1)*computeSize + 1):(computeSize*j)
                for n = ((i-1)*computeSize + 1):(computeSize*i)
                    if(calcPara.use_number == computeSize)
                        calcMatri(calcMatriIndex,:) = calcPara.computeMatri{m,n};
                    else
                        calcMatri(calcMatriIndex,:) = calcPara.computeMatri{m,n}(1,2);
                    end
                    calcMatriIndex = calcMatriIndex +1;
                end  
            end
            calcPara.start = min(calcMatri(:));
            calcPara.end = max(calcMatri(:));
            distance = abs(calcPara.end - calcPara.start) +1;
            if (distance > calcPara.max_distance) 
                calcPara.max_distance = distance;
                if(uiDirMode == 6)
                    save('calcMatri.mat','calcMatri');
                end
            end
            calcMatriIndex = 1;
            startX = (i-1)*computeSize ;
            startY = (j-1)*computeSize; 
            fprintf(fid, 'mode:%d  width:%d  height:%d (%d,%d) distance:%d max_distance:%d \n',uiDirMode, iWidth, iHeight,startX, startY, distance, calcPara.max_distance);

        end
    end  

end


