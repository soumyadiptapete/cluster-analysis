clc;close all; clear all;
load clustercount.mat
load cluster_size.mat
Time1=(1:200)*10;
Time2=Time1(end)+(1:100)*500;
Time3=Time2(end)+(1:767)*5000;
Time=[Time1 Time2 Time3];

h1=figure;
hold on;
yyaxis left
plot(Time,avg_cl_size,'LineWidth',3);

yyaxis left
ylabel('Average Cluster Size');


yyaxis right
plot(Time,Number_mol,'LineWidth',3);

yyaxis right
ylabel('Number of Molecules');
xlabel('Time');

hold off;

load clustercount.mat

h2=figure;
hold on;
yyaxis left
plot(Time,clustercount,'LineWidth',3);

yyaxis left
ylabel('Number of Clusters');

yyaxis right
plot(Time,Number_mol,'LineWidth',3);

yyaxis right
ylabel('Number of Molecules');
xlabel('Time');

hold off;

