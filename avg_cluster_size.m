clc;close all;clear all;

cutoff=1.35;

round_int=1;

Frame_number=1:1067;
Frames=length(Frame_number);
Time1=(1:200)*10;
Time2=Time1(end)+(1:100)*500;
Time3=Time2(end)+(1:767)*5000;
Time=[Time1 Time2 Time3];

    
for cnt=1:Frames
    cnt
    
    filename=strcat('Frame_',num2str(Frame_number(cnt)),'_cutoff_',num2str(cutoff),'.txt');
    fid=fopen(filename,'r');

    id=fgetl(fid); % ignore first line which is the total number of atoms not inside clusters
    j=0;
    
    while ~feof(fid)
        id=fgetl(fid);
        if str2num(id)==[]
         
            break;
        end
        j=j+1;
   
        Data(j)=str2num(id);
    end
    
    if j==0 % no molecules present
    Data(1)=0; 
    end

    fclose(fid);

    % round off biggest cluster to nearest number mentioned previously
    BC=Data(1);
    BC=round_int*(round(BC/round_int));
    Data(1)=BC;
    
    x=tabulate(Data);
    Frame(cnt).ClusterDistribution=x(1:end,1:2); 
    Frame(cnt).ClusterCount=sum(x(2:end,2)); % 2:end neglects clusters of size 1
    Frame(cnt).BiggestCluster=x(end,1);

    clear x; 
    clear Data;
    cnt
end



%preallocate cluster array for all frames
for t=1:Frames
y(t)=Frame(t).BiggestCluster; %number of rows will be equal to the biggest cluster in all frames
end

Cluster_Array=zeros(max(y),Frames);

%populate Cluster array

for i=1:Frames
    
    z=Frame(i).BiggestCluster;
    Cluster_Array(1:z,i)=Frame(i).ClusterDistribution(:,2);
end

Avg_Cluster_distribution=sum(Cluster_Array,2)/Frames;

for i=1:Frames
    
    cl_size=1:length(Cluster_Array(:,i));
    cl_size=cl_size';
    cl_freq=Cluster_Array(:,i);
    
    if sum(cl_freq)==0
    avg_cl_size(i)=0;
    else
    avg_cl_size(i)=sum(cl_size.*cl_freq)/sum(cl_freq);
    end
    Number_mol(i)=sum(cl_size.*cl_freq);
end

save('cluster_size.mat','avg_cl_size','Number_mol');
set(0,'defaultAxesFontSize',20);
set(0, 'DefaultLineLineWidth',3);
set(gca,'FontSize',20);










