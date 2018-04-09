function[out]=connectcycle(cycle,cyclec,stradellinglink)
if numel(cycle)>1
    if numel(stradellinglink)>0
        a=standard(cycle{cyclec(1,1)},stradellinglink(1,:));
        for i=1:numel(stradellinglink)/2
%             i
%             a=standard(a,stradellinglink(i,:));
            stradellinglink(i,:);
           b=standard(cycle{cyclec(1,i+1)},stradellinglink(i,:));
%            if sum(a(1,1:2)==b(1,1:2))==2
%                b=standard(fliplr(b),stradellinglink(i,:));
%                a=cat(2,a(1,2:length(a)),b(1,2:length(b)));
%            elseif sum(a(1,1:2)==fliplr(b(1,1:2)))==2
%                a=cat(2,a(1,2:length(a)),b(1,2:length(b))) ;    
%            end
           a=standard(a,stradellinglink(i,:));
           if sum(a(1,1:2)==b(1,1:2))==2
               b=standard(fliplr(b),stradellinglink(i,:));
               a=cat(2,a(1,2:length(a)),b(1,2:length(b)));
           elseif sum(a(1,1:2)==fliplr(b(1,1:2)))==2
               a=cat(2,a(1,2:length(a)),b(1,2:length(b))) ;    
           end
           
           
        out=standard(a,min(a));
        end
    elseif numel(stradellinglink)==0
        out=cycle{cyclec};
    end
elseif numel(cycle)==1
   out=cyclec;
%     stradellinglink=[],
%     aggragationcycle=[];
end
end

