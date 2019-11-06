
function  dstCell = convertCellToMatri(srccell,dstCell,width, height)
    srccellIndex =1;
    for j = 1:height
        for i = 1:width
            dstCell{j,i} = srccell{1,srccellIndex};
            srccellIndex = srccellIndex +1;
        end     
    end

end


