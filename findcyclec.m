function[cyclec,stradellinglink,aggragationcycle]=findcyclec(cycle,cycleweight,linkweight)
stradellinglink=[];
red2=inf;
if numel(cycle)>1
    
    temp=inf;
    for i= 1:length(cycle)
        x=[];
        x=cycleweight{i};
        x1(i,1)=min(x);
    end
    [r,c]=find(x1==min(x1));
    cyclec=r(1,1);
    aggragationcycle=[];
    stradellinglink=[];
    node=[];
    loopbreak=0;
    clc
    while loopbreak~=1
        tempstradellinglink=[];
        red1=redundancy(cyclec,stradellinglink,cycleweight,linkweight);
        [tempcyclec,tempstradellinglink,tempaggragationcycle]=aggrigate(cycle,cyclec,tempstradellinglink);
        if numel(tempcyclec)>0
            [r,c]=size(tempcyclec);
            for i=1:r
                redtemp(i,:)=redundancy(tempcyclec(i,:),stradellinglink,cycleweight,linkweight,tempstradellinglink(i,:));
            end
            [r,c]=find(redtemp==min(redtemp));
            usedcycle=r(length(r),1);
            red2=redtemp(usedcycle,:);
            if red2<=red1
                cyclec=tempcyclec(usedcycle,:);
                stradellinglink=cat(1,stradellinglink,tempstradellinglink(usedcycle,:));
                aggragationcycle=cat(2,aggragationcycle,tempaggragationcycle(usedcycle,:));
            end
        end
        if red2>red1
            break
        end



        if numel(tempstradellinglink)==0
            loopbreak=1;
            break
        end
    end
elseif numel(cycle)==1
    cyclec=cyclec(1,length(cyclec));
    stradellinglink=[];
    aggragationcycle=[];
end
%     stradellinglink=unique(stradellinglink,'rows');
end