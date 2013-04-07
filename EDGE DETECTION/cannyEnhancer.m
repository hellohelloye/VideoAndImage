function [ es,eo ] = cannyEnhancer( aftSmoothingImg )
[x_size,y_size]=size(aftSmoothingImg);
w=[-1,0,1];
for i=1:x_size
    holdmatrix=conv2(aftSmoothingImg(i,:),w,'same');
    jx(i,:)=holdmatrix;
end 
for j=1:y_size
    midmatrix=conv2(aftSmoothingImg(:,j),transpose(w),'same');
    jy(:,j)=midmatrix;
end
es=zeros(x_size,y_size);
eo=zeros(x_size,y_size);
for row=1:x_size
    for colum=1:y_size
        es(row,colum)=sqrt(jx(row,colum).^2 + jy(row,colum).^2);
        eo(row,colum)=(180/pi)*atan(jy(row,colum)/jx(row,colum));
    end
end
end

