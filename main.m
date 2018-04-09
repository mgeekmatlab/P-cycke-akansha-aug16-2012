clc
clear all
close all
tic;
minedgeonnode=0;
maxnoofcylclestoprotectonecycle=3;
index=0;
stopplot=0;% set it 0 to keep plotting and to stop plotting set it to 1
fromfile=2;
%% select aggrigrigation criteria
checkredundancy=1;% set it 1 to check for redundancy before aggrigation & to aggrigate without redundancy set it 2 % set it 3 to stop aggrigation after linklimit
linklimit=6;% set it 3 to stop aggrigation after linklimit

noofnodes=8;
networkno=2;%select network no
%% define network start
switch networkno
    case 1    
        fromfile=input(' to use graph from file press 1 else \n press 2 for example defined and \n press 3 for random network  ');
        demolinks={[2,8];[1 3 7];[2,4,6];[3,5];[4,6];[7,3,5];[8,2,6];[1,7]};
        demolinksweight=[3;3;4;7;2;6;2;2;4;3];
    case 2 %% ex1
        noofnodes=8
        demolinks={[2,8];[1 3 7];[2,4,6];[3,5];[4,6];[7,3,5];[8,2,6];[1,7]};
        demolinksweight=[3;3;4;7;2;6;2;2;4;3];
    case 3 %% NETWORK1(page no.94 ka diag.)
        noofnodes= 13
        demolinks={[2,9,10,13];[1,3,9,4];[2,4];[2,3,5,8];[4,6];[5,7,8];[6,8,12];[4,6,7,9,10,12];[1,2,8,10];[1,8,9,11];[10,12,13];[7,8,11,13];[1,9,11]};
        demolinksweight=[11;4;12;3;4;10;3;8;8;12;10;7;7;6;9;7;6;8;2;3;8;3;7];
    case 4 %% NETWORK2(page no. 92 ka dia.)
        noofnodes= 19
        demolinks={[2,17,19];[1,3,12,16];[2,4,5,11];[3,5];[3,4,6];[5,7];[6,8,11];[7,9];[8,10];[9,11,14];[3,7,10,12];[2,11,13,16];[12,14];[10,13,15];[14,16,18];[2,12,15,17];[1,16,18];[15,17,19];[1,18]};
        demolinksweight=[34;9;23;35;27;12;16;20;13;2;10;12;16;32;6;18;10;22;33;28;24;14;16;15;11;15;8;11];
    case 5 %% NETWORK1 to compare
        noofnodes= 8
        demolinks={[2,8];[1 3 7];[2,4];[3,5,7];[4,6];[5,7];[8,6,4];[1,7]};
        demolinksweight=[1;1;0;1;0;2;3;2;2;1];
    case 6 %% example 8aug
        noofnodes=6;
        demolinks={[2,6,4];[1 3 ];[1,2,4,6];[1,3,5];[4,6];[1,3,5]};
        demolinksweight=[20;50;19;30;17;20;20;19;19];
end

rpt=0;
num1=0;
while rpt~=1
    if index==0
        [net,noofnodes,matrix,links,noofedges,newname,linkweight,linkrowweight]=networkgeneration(noofnodes,minedgeonnode,demolinks,demolinksweight,fromfile);
            noofnodes1=noofnodes;
            matrix1=matrix;
            linkrowweight1=linkrowweight;
    elseif index>0
        [net,noofnodes,matrix,links,noofedges,newname,linkweight,linkrowweight]=networkgeneration(noofnodes,minedgeonnode,newdemolinks,newdemolinksweight,fromfile);
        
    if numel(cycle)==0
        break
    end
    end
    %% plot updated network
    if stopplot~=1
        figure
        plotfunction1(noofnodes1,matrix1,5,linkrowweight1);
        plotgraph(noofnodes,matrix,5,linkrowweight);
    end
    [sepratecycle,cycle]=findpcycle(net,noofnodes,linkweight);
%     if numel(cycle)==0
%         break
%     end
    if numel(cycle)>1
        [cycleweight,working,spare]=capacity(cycle,linkweight);
        if checkredundancy==1
%             index
            [cyclec,stradellinglink,aggragationcycle]=findcyclec(cycle,cycleweight,linkweight);
            
        elseif checkredundancy==2
            [cyclec,stradellinglink,aggragationcycle]=findcyclecnoredundancy(cycle,cycleweight,linkweight);
        elseif checkredundancy==3
%             index
            [cyclec,stradellinglink,aggragationcycle]=findcyclec2(cycle,cycleweight,linkweight,linklimit);
        end


        %% save results for one iteration start
%         if numel(stradellinglink)>0
            index=index+1;
            pcycle{index}.connectcycle=connectcycle(cycle,cyclec,stradellinglink);
            pcycle{index}.stradellinglink=stradellinglink;
            if index==1
                currpcyc=[];
            end
%             index
%             pcycle{index}.connectcycle
            if numel(currpcyc)==numel(pcycle{index}.connectcycle)
                if currpcyc==pcycle{index}.connectcycle
                    pcyclecopy(num1,:)=pcyclecopy(num1,:)+1;
                    finalpcycle(num1).copy=pcyclecopy(num1,:);
                elseif currpcyc~=pcycle{index}.connectcycle
                    num1=num1+1;
                    finalpcycle(num1).no=num1;
                    finalpcycle(num1).pcycle=pcycle{index}.connectcycle;
                    currpcyc=pcycle{index}.connectcycle;
                    pcyclecopy(num1,:)=1;
                    finalpcycle(num1).copy=pcyclecopy(num1,:);
                end
            elseif numel(currpcyc)~=numel(pcycle{index}.connectcycle)
%                 if currpcyc~=pcycle{index}.connectcycle
                    num1=num1+1;
                    finalpcycle(num1).no=num1;
                    finalpcycle(num1).pcycle=pcycle{index}.connectcycle;
                    currpcyc=pcycle{index}.connectcycle;
                    pcyclecopy(num1,:)=1;
                    finalpcycle(num1).copy=pcyclecopy(num1,:);
%                 end
            end
                

            %% save results for one iteration end

            %% updade network
            newdemolinksweight=[];
            [newdemolinks,newdemolinksweight]=updatenetwork(linkweight,pcycle{index}.connectcycle,pcycle{index}.stradellinglink);
%         end
    elseif numel(cycle)==1
        index=index+1;
        pcycle{index}.connectcycle=cycle{1};
        pcycle{index}.stradellinglink=[];
        newdemolinksweight=[];
        [newdemolinks,newdemolinksweight]=updatenetwork(linkweight,pcycle{index}.connectcycle,pcycle{index}.stradellinglink);   
        
            if index==1
                currpcyc=[];
            end
%             index
%             pcycle{index}.connectcycle
            if numel(currpcyc)==numel(pcycle{index}.connectcycle)
                if currpcyc==pcycle{index}.connectcycle
                    pcyclecopy(num1,:)=pcyclecopy(num1,:)+1;
                    finalpcycle(num1).copy=pcyclecopy(num1,:);
                elseif currpcyc~=pcycle{index}.connectcycle
                    num1=num1+1;
                    finalpcycle(num1).no=num1;
                    finalpcycle(num1).pcycle=pcycle{index}.connectcycle;
                    currpcyc=pcycle{index}.connectcycle;
                    pcyclecopy(num1,:)=1;
                    finalpcycle(num1).copy=pcyclecopy(num1,:);
                end
            elseif numel(currpcyc)~=numel(pcycle{index}.connectcycle)
%                 if currpcyc~=pcycle{index}.connectcycle
                    num1=num1+1;
                    finalpcycle(num1).no=num1;
                    finalpcycle(num1).pcycle=pcycle{index}.connectcycle;
                    currpcyc=pcycle{index}.connectcycle;
                    pcyclecopy(num1,:)=1;
                    finalpcycle(num1).copy=pcyclecopy(num1,:);
%                 end
            end
            
            
    end
   	
    if sum(newdemolinksweight)==0
        rpt=1;
        break
    end
end

%% plotting final pcycles formed
if stopplot~=1
    if index>5
    figure
    for i=1:index
        figure
        %     SUBPLOT(((index+mod(index,2))/2),2,i)
            x1=pcycle{i}.connectcycle;
            x2=pcycle{i}.stradellinglink;
            plotpcyclegraph(noofnodes,5,x1,x2,i);
        end
        if sum(newdemolinksweight)
            figure
        %     SUBPLOT(((index+mod(index,2))/2),2,i+1)
            plotpcyclegraph(noofnodes,5,links,[],i+1);
        end
    elseif index<=5
        figure
        for i=1:index
            SUBPLOT(((index+mod(index,2))/2),2,i);
            x1=pcycle{i}.connectcycle;
            x2=pcycle{i}.stradellinglink;
            plotpcyclegraph(noofnodes,5,x1,x2,i);
        end
        if sum(newdemolinksweight)
            SUBPLOT(((index+mod(index,2))/2),2,i+1);
            plotpcyclegraph(noofnodes,5,links,[],i+1);
        end
    end
end
time=toc;
if checkredundancy~=3
    sprintf('time taken by method %d  with linklimit= %d is %d seconds',checkredundancy,linklimit,time)
else
    sprintf('time taken by method %d is %d seconds',checkredundancy,time)
end
for i=1:num1
    finalpcycle(i)
end
% save(n ewname,'net','noofnodes','minedgeonnode','links','linkweight');