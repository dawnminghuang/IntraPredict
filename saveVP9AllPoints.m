
function  calcPara = saveVP9AllPoints(iYnN1, iY, iYn,iYnP2,calcPara,index)
    calcPara.vp9Matri{1,index}(1) = iYnN1;
    calcPara.vp9Matri{1,index}(2) = iY;
    calcPara.vp9Matri{1,index}(3) = iYn;
    calcPara.vp9Matri{1,index}(4) = iYnP2;
end
