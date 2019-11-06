
function  calcPara= decideMinMaxPosiont4X2(calcPara, calcMatri)
    defaultUseNumber = 4;
    calcMatriDecide = calcMatri';
    minIndex = find(calcMatriDecide==min(calcMatriDecide(:)));
    maxIndex = find(calcMatriDecide==max(calcMatriDecide(:)));
    if(calcPara.use_number ~= defaultUseNumber)
        upLeftMin = sum(ismember(minIndex,1));
        upRightMin = sum(ismember(minIndex,4));
        downLeftMin = sum(ismember(minIndex,5));
        downRightMin = sum(ismember(minIndex,8));
        upLeftMax = sum(ismember(maxIndex,1));
        upRightMax = sum(ismember(maxIndex,4));
        downLeftMax = sum(ismember(maxIndex,5));
        downRightMax = sum(ismember(maxIndex,8));
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
        downLeftMin = sum(ismember(minIndex,17)) + sum(ismember(minIndex,18)) + sum(ismember(minIndex,19)) + sum(ismember(minIndex,20));
        downRightMin = sum(ismember(minIndex,29)) + sum(ismember(minIndex,30)) + sum(ismember(minIndex,31)) + sum(ismember(minIndex,32));
        upLeftMax = sum(ismember(maxIndex,1)) + sum(ismember(maxIndex,2)) + sum(ismember(maxIndex,3)) + sum(ismember(maxIndex,4));
        upRightMax = sum(ismember(maxIndex,13)) + sum(ismember(maxIndex,14)) + sum(ismember(maxIndex,15)) + sum(ismember(maxIndex,16));
        downLeftMax = sum(ismember(maxIndex,17)) + sum(ismember(maxIndex,18)) + sum(ismember(maxIndex,19)) + sum(ismember(maxIndex,20));
        downRightMax = sum(ismember(maxIndex,29)) + sum(ismember(maxIndex,30)) + sum(ismember(maxIndex,31)) + sum(ismember(maxIndex,32));
        sumAllMin = upLeftMin + upRightMin + downLeftMin + downRightMin;
        sumAllMax = upLeftMax + upRightMax + downLeftMax + downRightMax;
        if((sumAllMin == 0) || (sumAllMax == 0))
            minIndex
            maxIndex
        end
    end
end
