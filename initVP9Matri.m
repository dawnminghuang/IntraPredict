
function  calcPara = initVP9Matri(calcPara)
    maxIndex = 64;
    vp9MatriIndex = 1;
    for i = 1:maxIndex
        for j = 1:maxIndex
            calcPara.vp9Matri{vp9MatriIndex} = zeros(1,4);
            vp9MatriIndex  = vp9MatriIndex +1;
        end
    end
    for i = 1:maxIndex
        for j = 1:maxIndex
            calcPara.dstCell{i,j} = zeros(1,4);
        end
    end

end


