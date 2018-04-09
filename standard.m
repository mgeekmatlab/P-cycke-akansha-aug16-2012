function[out]=standard(x,std)
    len=length(std);
    loop=len;
    
    while sum(x(:,1:len)==std)~=len || sum(x(:,1:len)==fliplr(std))~=len
        x=circshift(x',1)';
%         if sum(x(:,1:len)==std)==len
%             break
%         end
        if sum(x(:,1:len)==fliplr(std))==len
            
            break
        end
        if sum(x(:,1:len)==std)==len
            break
        end
%         if loop==0
%             break
%         end
%         loop=loop-1;
    end

    out=x;
end