function[dlinks,dweight]=updatenetwork(linkweight,connectcycle,std)
%[demolinks,demolinksweight]=updatenetwork(demolinks,demolinksweight,links,linkweight,pcycle{index}.connectcycle,pcycle{index}.stradellinglink)
for i=1:length(connectcycle)
    if i<length(connectcycle)
        x=sort([connectcycle(1,i),connectcycle(1,i+1)]);
        upd=linkweight(x(1,1),x(1,2))-1;
        linkweight(x(1,1),x(1,2))=upd;
        linkweight(x(1,2),x(1,1))=upd;
    elseif i==length(connectcycle)
        x=sort([connectcycle(1,i),connectcycle(1,1)]);
        upd=linkweight(x(1,1),x(1,2))-1;
        linkweight(x(1,1),x(1,2))=upd;
        linkweight(x(1,2),x(1,1))=upd;
    end
end

for i=1:numel(std)/2
    x=sort(std(i,:));
    upd=linkweight(x(1,1),x(1,2))-2;
    linkweight(x(1,1),x(1,2))=upd;
    linkweight(x(1,2),x(1,1))=upd;
end
lw=(linkweight);
ulw=triu(lw);
dlinks=[];
dweight=[];
for i=1:length(lw)
    dlinks=cat(1,dlinks,{find(lw(i,:)>0)});
    dweight=cat(1,dweight,ulw(i,find(ulw(i,:)>0))');
end
    
end

%[demolinks,demolinksweight]=updatenetwork(demolinks,demolinksweight,links,linkweight,pcycle{index}.connectcycle,pcycle{index}.stradellinglink)
% if numel(std)>0
%     
%     for i=1:length(connectcycle)
%         if i<length(connectcycle)
%             x=sort([connectcycle(1,i),connectcycle(1,i+1)]);
%             upd=linkweight(x(1,1),x(1,2))-1;
%             linkweight(x(1,1),x(1,2))=upd;
%             linkweight(x(1,2),x(1,1))=upd;
%         elseif i==length(connectcycle)
%             x=sort([connectcycle(1,i),connectcycle(1,1)]);
%             upd=linkweight(x(1,1),x(1,2))-1;
%             linkweight(x(1,1),x(1,2))=upd;
%             linkweight(x(1,2),x(1,1))=upd;
%         end
%     end
% 
%     for i=1:numel(std)/2
%         x=sort(std(i,:));
%         upd=linkweight(x(1,1),x(1,2))-2;
%         linkweight(x(1,1),x(1,2))=upd;
%         linkweight(x(1,2),x(1,1))=upd;
%     end
% elseif numel(std)==0
%     for i=1:length(connectcycle)
%         if i<length(connectcycle)
%             x=sort([connectcycle(1,i),connectcycle(1,i+1)]);
%             upd=linkweight(x(1,1),x(1,2))-1;
%             linkweight(x(1,1),x(1,2))=upd;
%             linkweight(x(1,2),x(1,1))=upd;
%         elseif i==length(connectcycle)
%             x=sort([connectcycle(1,i),connectcycle(1,1)]);
%             upd=linkweight(x(1,1),x(1,2))-1;
%             linkweight(x(1,1),x(1,2))=upd;
%             linkweight(x(1,2),x(1,1))=upd;
%         end
%     end 
% end
% 
% 
% for i=1:numel(std)/2
%     x=sort(std(i,:));
%     upd=linkweight(x(1,1),x(1,2))-2;
%     linkweight(x(1,1),x(1,2))=upd;
%     linkweight(x(1,2),x(1,1))=upd;
% end
% lw=(linkweight);
% ulw=triu(lw);
% dlinks=[];
% dweight=[];
% for i=1:length(lw)
%     if numel(find(lw(i,:)>0))>0
%         dlinks=cat(1,dlinks,{find(lw(i,:)>0)});
%     end
%     dweight=cat(1,dweight,ulw(i,find(ulw(i,:)>0))');
%     
% end
% 
% end