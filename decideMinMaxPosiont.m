
function  calcPara= decideMinMaxPosiont(calcPara, calcMatri)
    computeSize = 4;
    calcMatriDecide = calcMatri';
    minIndex = find(calcMatriDecide==min(calcMatriDecide(:)));
    maxIndex = find(calcMatriDecide==max(calcMatriDecide(:)));
    if(calcPara.use_number ~= computeSize)
        upLeftMin = sum(ismember(minIndex,1));
        upRightMin = sum(ismember(minIndex,4));
        downLeftMin = sum(ismember(minIndex,13));
        downRightMin = sum(ismember(minIndex,16));
        upLeftMax = sum(ismember(maxIndex,1));
        upRightMax = sum(ismember(maxIndex,4));
        downLeftMax = sum(ismember(maxIndex,13));
        downRightMax = sum(ismember(maxIndex,16));
        sumAllMin = upLeftMin + upRightMin + downLeftMin + downRightMin;
        sumAllMax = upLeftMax + upRightMax + downLeftMax + downRightMax;
        isMatch1 = upLeftMin + downRightMax;
        isMatch2 = upRightMin + downLeftMax;
        isMatch3 = downLeftMin + upRightMax;
        isMatch4 = downRightMin + upLeftMax;
        if((sumAllMin == 0) || (sumAllMax == 0))
            minIndex
            maxIndex
        end
         if((isMatch1 ~= 2) && (isMatch2 ~= 2) && (isMatch3 ~= 2) && (isMatch4 ~= 2))
            minIndex
            maxIndex
        end
    else
        upLeftMin = sum(ismember(minIndex,1)) + sum(ismember(minIndex,2)) + sum(ismember(minIndex,3)) + sum(ismember(minIndex,4));
        upRightMin = sum(ismember(minIndex,13)) + sum(ismember(minIndex,14)) + sum(ismember(minIndex,15)) + sum(ismember(minIndex,16));
        downLeftMin = sum(ismember(minIndex,49)) + sum(ismember(minIndex,50)) + sum(ismember(minIndex,51)) + sum(ismember(minIndex,52));
        downRightMin = sum(ismember(minIndex,61)) + sum(ismember(minIndex,62)) + sum(ismember(minIndex,63)) + sum(ismember(minIndex,64));
        upLeftMax = sum(ismember(maxIndex,1)) + sum(ismember(maxIndex,2)) + sum(ismember(maxIndex,3)) + sum(ismember(maxIndex,4));
        upRightMax = sum(ismember(maxIndex,13)) + sum(ismember(maxIndex,14)) + sum(ismember(maxIndex,15)) + sum(ismember(maxIndex,16));
        downLeftMax = sum(ismember(maxIndex,49)) + sum(ismember(maxIndex,50)) + sum(ismember(maxIndex,51)) + sum(ismember(maxIndex,52));
        downRightMax = sum(ismember(maxIndex,61)) + sum(ismember(maxIndex,62)) + sum(ismember(maxIndex,63)) + sum(ismember(maxIndex,64));
        sumAllMin = upLeftMin + upRightMin + downLeftMin + downRightMin;
        sumAllMax = upLeftMax + upRightMax + downLeftMax + downRightMax;
        if((sumAllMin == 0) || (sumAllMax == 0))
            minIndex
            maxIndex
        end
    end
end
