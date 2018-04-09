function[cyclectemp,straddelinglink,aggragationcycle]=aggrigate(cycle,cyclec,straddelinglink)
num=1;
in=[];
node=[];
cyclectemp=[];
cyclectemp1=[];
aggragationcycle=[];
for i=length(cyclec):-1:1
%     node=union(node,cycle{cyclec(1,length(cyclec))});
    node=union(node,cycle{cyclec(1,i)});
% node=cycle{cyclec(1,i)};

end
for i=1:length(cycle)
    if sum(i==cyclec)==0
        temp0=intersect(node,cycle{i});
        temp1=[];
        if numel(temp0)==2
            temp1=intersect(intersect(temp0,tempfn(node),'rows'),tempfn(cycle{i}),'rows');
        end
        if numel(temp1)==2
            in{i}=temp1;
%             straddelinglink=cat(1,straddelinglink,temp1);
            straddelinglink=cat(1,straddelinglink,temp1);
            aggragationcycle(num,1)=i;
            num=num+1;
            cyclectemp1=cat(2,cyclec,i);
            cyclectemp=cat(1,cyclectemp,cyclectemp1);
%             node=union(node,cycle{i})
        end
    end
end
% end
% straddelinglink=unique(straddelinglink,'rows');
end

function[x]=tempfn(a)
[r,c]=size(a);
for i=1:c
    if i<c
        x(i,:)=sort([a(1,i),a(1,i+1)]);
    elseif i==c
        x(i,:)=sort([a(1,i),a(1,1)]);
    end
end
end
        
    