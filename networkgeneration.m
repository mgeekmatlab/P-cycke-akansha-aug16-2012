function[net,noofnodes,matrix,links,noofedges,newname,linkweight,linkrowweight]=networkgeneration(noofnodes,minedgeonnode,demolinks,demolinksweight,fromfile)
net.node=[];
net.edge=[];
num=0;
if fromfile==1
    name=input('enter file name   ','s');
    load(name);
else
    %%new graph
    if exist('demolinks','var')==1
        x1=demolinks;
    end
    if exist('demolinksweight','var')==1
        l1=demolinksweight;
    end
    for i=1:noofnodes
%         i
        net(i).node=1;
        if exist('x1','var')==1
            net(i).edge=x1{i};
        end
        if exist('x1','var')==0
            repeat=2;
            while repeat==2
                while length(net(i).edge)<=minedgeonnode
                    a=[];
                    a=unique(randi(randi(noofnodes),1,randi(noofnodes)));
                    if sum(a==i)==0
                        net(i).edge=a;
                        repeat=1;
                    else
                        net(i).edge=[];
                        repeat=2;
                    end
                end
            end
        end
    end
end
% temp=zeros(noofnodes);
for i=1:noofnodes
%     i
%     net(i).edge
    for j=1:length(net(i).edge)
        num=num+1;
        row(num,:)=sort([i,net(i).edge(1,j)]);
%         temp(i,net(i).edge(1,j))=temp(i,net(i).edge(1,j))+1;
        if i==net(i).edge(1,j)
            error;
        end
    end
end
row=sortrows(row,1);
newname=['noofnodes_' num2str(noofnodes)];
for i=1:noofnodes
    for j=1:length(net(i).edge)
        net(net(i).edge(1,j)).edge=unique(cat(2,net(net(i).edge(1,j)).edge,i));
    end
end
for i=1:noofnodes
    matrix(i,:)=zeros(1,noofnodes);
    for j=1:length(net(i).edge)
        matrix(i,net(i).edge(1,j))=1;
    end
end
links=unique(row,'rows');
noofnodes;
[r1,c1]=size(links);
noofedges=r1;
if fromfile~=1
    
    if exist('l1','var')==0
        l1=randint(length(links),1,[1,length(links)])*2;
    end
    linkweight=zeros(noofnodes,noofnodes);
    for k=1:noofedges
        linkweight(links(k,1),links(k,2))=l1(k,:);
        linkweight(links(k,2),links(k,1))=l1(k,:);
    end
    linkrowweight=l1;
end
save(newname)
end