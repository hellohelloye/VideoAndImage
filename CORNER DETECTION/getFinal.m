function [ finalList ] = getFinal(sortList,wth)
s=size(sortList);
for m=1:s-1
    i=sortList(m,2);
    j=sortList(m,3);
    for n=m+1:s
       if( sortList(n,2)>=(i-2*wth-2) && sortList(n,2)<=(i+2*wth+2) && sortList(n,3)>=(j-2*wth-2) && sortList(n,3)<=(j+2*wth+2) )
           sortList(n,1)=0;
       end
    end
end

finalList=flipud(sortrows(sortList,1));
end

