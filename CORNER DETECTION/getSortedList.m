function [ sortList ] = getSortedList( aftSmoothImg,threshold )
[x_size,y_size]=size(aftSmoothImg);
w=[-1,0,1];
for i=1:x_size
    holdmatrix=conv2(aftSmoothImg(i,:),w,'same');
    jx(i,:)=holdmatrix;
end 
for j=1:y_size
    midmatrix=conv2(aftSmoothImg(:,j),transpose(w),'same');
    jy(:,j)=midmatrix;
end
n=x_size*y_size
list=zeros(n,3);
cnt=0;

for i=2:(x_size-1)
    for j=2:(y_size-1)
       ex(1:3,1:3)=jx(i-1:i+1,j-1:j+1);
       ey(1:3,1:3)=jy(i-1:i+1,j-1:j+1);
       ex2=ex^2;
       Ex2=sum(sum(ex2));
       exy=ex*ey;
       Exy=sum(sum(exy));
       eyx=ey*ex;
       Eyx=sum(sum(eyx));
       ey2=ey^2;
       Ey2=sum(sum(ey2)); 
       minValue=abs(min(eig([Ex2 Exy; Eyx Ey2])));
       if(minValue>threshold)
           cnt=cnt+1;
           list(cnt,1)=minValue;
           list(cnt,2)=i;
           list(cnt,3)=j;
       end
    end
end

sortList=flipud(sortrows(list,1));
     
end

