function[]=plotpcyclegraph(noofnodes,r,x11,x2,index)
[rx,c]=size(x11);
for loop=1:rx
    x1=x11(loop,:);
    matrix=zeros(noofnodes);
    for i =1:length(x1)
        if i<length(x1)
            matrix(x1(1,i),x1(1,i+1))=1;
        else
            matrix(x1(1,i),x1(1,1))=1;
        end
    end
    matrix=or(matrix,matrix');
    %[]=plotgraph(noofnodes,net,matrix,axissize)
    theta=[0:2*pi/noofnodes:2*pi];
    xx=r*sin(theta);
    yy=r*cos(theta)/2;
    xy=cat(2,xx',yy');
    hold on
    % subplot(2,1,1);
    axis([-r-2,r+2,-r-2,r+2])
    num=1;
    % gplot(matrix,xy,'.-');

    for i=1:noofnodes
        text(1.2*xy(i,1),1.2*xy(i,2),['*' num2str(i)]);
        for j=i+1:noofnodes
            if matrix(i,j)==1
                plot([xx(1,i),xx(1,j)],[yy(1,i),yy(1,j)],'-r','linewidth',2)
                text(1.1*(xx(1,i)+xx(1,j))/2, 1.1*(yy(1,i)+yy(1,j))/2 ,'1')
                num=num+1;
            end
        end

    end
    hold on
    for i=1:numel(x2)/2
    %     for j=1:2
                plot([xx(1,x2(i,1)),xx(1,x2(i,2))],[yy(1,x2(i,1)),yy(1,x2(i,2))],'-.g','linewidth',2)
                text(1.1*(xx(1,x2(i,1))+xx(1,x2(i,2)))/2, 1.1*(yy(1,x2(i,1))+yy(1,x2(i,2)))/2 ,'2')
    %             line([xx(1,x2(i,1)),xx(1,x2(i,2))],[yy(1,x2(i,1)),yy(1,x2(i,2))])
    %     end 
    end
    axis([-r-3,r+3,-r-3,r+3])
end
if rx==1
    title(['pcycle ' num2str(index) ' ( ' num2str(x1) ' )'])
elseif rx>1
    title(['unprotected links left'])
end
    hold off
% saveas(gcf,newname,'jpg')