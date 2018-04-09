function[x2]=checkunprotectedlink(x,linkweight)
takeit=[];
[r,c]=size(x);
for i=1:r
    temp=0;
    for j=1:c
        if j<c
            if linkweight(x(i,j),x(i,j+1))==0
                temp=temp+1;
                break
            end
        elseif j==c
            if linkweight(x(i,j),x(i,1))==0
                temp=temp+1;
                break
            end            
        end
    end
    if temp==0
        takeit=cat(2,takeit,i);
    end
end
if numel(takeit)>0
    x2=x(takeit,:);
else
    x2=[]
end
        