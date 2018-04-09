function[out]=redundancy(cycleno,stradellinglink,cycleweight,linkweight,tempstradellinglink)
if nargin==5
%     tempstradellinglink=[];
    stradellinglink=cat(1,stradellinglink,tempstradellinglink);
end
std=0;
den=0;
for i=1:length(cycleno)
    den=den+sum(numel(cycleweight{cycleno(1,i)}));
end
[r,c]=size(stradellinglink);
% for i=1:r
%     std=std+linkweight(stradellinglink(i,1),stradellinglink(i,2));
std=std+r;
% end
std=std*2;
num=den-std;
out=num/den;
if den==0
    out=inf;
end
end