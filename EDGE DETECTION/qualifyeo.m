function[ eo ] = qualifyeo( eo,originalImage )
[x_size,y_size]=size(originalImage);
eo=uint8(eo);
for row=1:x_size
    for colum=1:y_size
        if((0<eo(row,colum) && eo(row,colum)< 22.5 )|| (157.5 <eo(row,colum) && eo(row,colum)< 180))
            eo(row,colum)=0;
        elseif( 22.5< eo(row,colum) && eo(row,colum) < 67.5)
            eo(row,colum)=45;
        elseif( 67.5 <eo(row,colum) && eo(row,colum) < 112.5)
            eo(row,colum)=90;
        elseif(112.5 <eo(row,colum) && eo(row,colum) < 157.5)
            eo(row,colum)=135;
        end
    end
end

