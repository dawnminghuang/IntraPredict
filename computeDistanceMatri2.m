
function  calcPara = computeDistanceMatri2(fid,uiDirMode, iWidth, iHeight,calcPara)
    
    computeSize = 4;
    computeSizeHeight = 2;
    widthNumber = iWidth /computeSize;
    heightNumber = iHeight/computeSizeHeight;
    calcMatri = zeros(computeSize*computeSizeHeight,1);
    calcMatriIndex = 1;
    for j = 1:heightNumber
        for i = 1:widthNumber
            for m = ((j-1)*computeSizeHeight + 1):(computeSizeHeight*j)
                for n = ((i-1)*computeSize + 1):(computeSize*i)
                    calcMatri(calcMatriIndex,:) = calcPara.computeMatri{m,n}(1,2);
                    calcMatriIndex = calcMatriIndex +1;
                end  
            end
            calcPara.start = min(calcMatri(:));
            calcPara.end = max(calcMatri(:));
            distance = abs(calcPara.end - calcPara.start) +1;
            if (distance > calcPara.max_distance) 
                calcPara.max_distance = distance;
                save('calcMatri.mat','calcMatri');
            end
            calcMatriIndex = 1;
            startX = (i-1)*computeSize ;
            startY = (j-1)*computeSizeHeight; 
            fprintf(fid, 'mode:%d  width:%d  height:%d (%d,%d) distance:%d max_distance:%d \n',uiDirMode, iWidth, iHeight,startX, startY, distance, calcPara.max_distance);

        end
    end  

end


