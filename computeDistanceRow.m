
function  calcPara = computeDistanceRow(fid,uiDirMode, iWidth, iHeight,calcPara)
    
    computeSize = 4;
    widthNumber = iWidth /computeSize;
    heightNumber = iHeight;
    calcMatri = zeros(computeSize,computeSize);
    calcMatriIndex = 1;
    for j = 1:heightNumber
        for i = 1:widthNumber
            for n = ((i-1)*computeSize + 1):(computeSize*i)
                calcMatri(calcMatriIndex,:) = calcPara.computeMatri{j,n}(1,2);
                calcMatriIndex = calcMatriIndex +1;
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
            startY = j-1;
            fprintf(fid, 'mode:%d  width:%d  height:%d (%d,%d) distance:%d max_distance:%d \n',uiDirMode, iWidth, iHeight, startX, startY, distance, calcPara.max_distance);
             %compute index
%             [maxX,maxY]=find(calcMatri==max(calcMatri(:)));
%             maxX(1) = maxX(1) + (i-1)*computeSize -1;
%             maxY(1) = j -1;
%             [minX,minY]=find(calcMatri==min(calcMatri(:)));
%             minX(end) = minX(end) + (i-1)*computeSize -1;
%             minY(end) = j -1;
%             fprintf(fid, 'mode:%d  width:%d  height:%d (%d,%d) start:%d  (%d,%d) end:%d distance:%d max_distance:%d \n',uiDirMode, iWidth, iHeight, minX(end),minY(end),calcPara.start, maxX(1), maxY(1),calcPara.end, distance, calcPara.max_distance);

        end
    end  

end


