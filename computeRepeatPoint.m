
function  calcPara = computeRepeatPoint(fid,~,iWidth, iHeight,calcPara)
    
    computeSize = 4;
    widthNumber = iWidth /computeSize;
    heightNumber = iHeight;
    calcMatri = zeros(computeSize,1);
    calcMatriIndex = 1;
    for j = 1:heightNumber
        for i = 1:widthNumber
            for n = ((i-1)*computeSize + 1):(computeSize*i)
                calcMatri(calcMatriIndex,:) = calcPara.computeMatri{j,n}(1,2);
                calcMatriIndex = calcMatriIndex +1;
            end  
            calcMatriIndex = 1;
            calcPara.start = min(calcMatri(:));
            calcPara.end = max(calcMatri(:));
            distance = abs(calcPara.end - calcPara.start) +1;
            if (distance < computeSize) 
                for k = 1:length(calcMatri)
                    fprintf(fid, '%d ',calcMatri(k));
                end
                fprintf(fid, '\n');
            end

        end
    end  

end


