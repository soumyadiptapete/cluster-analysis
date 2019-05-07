clc;close all;clear all;

Frame_number=1:1067;
Frames=length(Frame_number);

Time1=(1:200)*10;
Time2=Time1(end)+(1:100)*500;
Time3=Time2(end)+(1:767)*5000;
Time=[Time1 Time2 Time3];

cutoff=1.35;



for cnt=1:Frames

    filename=strcat('Frame_',num2str(Frame_number(cnt)),'_cutoff_',num2str(cutoff),'Clustercount.txt');
    fid=fopen(filename,'r');
    id=fgetl(fid); 
    clustercount(cnt)=str2num(id);
    fclose(fid);
    cnt
end

save('clustercount.mat','clustercount');
h=figure;
plot(Time,clustercount,'o--','LineWidth',3,'MarkerSize',10);
xlabel('Time');ylabel('Number of clusters');

savefig(h,'clustercount.fig');




