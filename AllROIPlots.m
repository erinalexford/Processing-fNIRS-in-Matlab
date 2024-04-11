
% Script to analyze and plot SNIRF files
% lskdjflskjd

%load C:\Users\General_Use\Desktop\neurodiscovery_lab\raw_pilot_data\2024-03-11_1875b\1875b_snirf\derivatives\homer\1875_OH.mat

clear all

participantID = input("Enter 4 digit participant ID number:  ");
taskCode = input("Enter task code (I.e., VGR-L, VGR-R, RVGR-L, RVGR-R, OH, or OHA):  ","s");

fileIDSpec = "%d_%s.mat";
fileID = sprintf(fileIDSpec,participantID,taskCode);
load(fileID,"output")


%loop to set variable taskID based on taskCode
taskID = "";

if taskCode == "OH"
    taskID = "Object Hit";
elseif taskCode == "OHA"
    taskID = "Object Hit & Avoid";
elseif taskCode == "VGR-L"
    taskID = "Left Hand Reaching";
elseif taskCode == "VGR-R"
    taskID = "Right Hand Reaching";
elseif taskCode == "RVGR-L"
    taskID = "Left Hand Reverse Reaching";
elseif taskCode == "RVGR-R"
    taskID = "Right Hand Reverse Reaching";
else
    error("Task code invalid. Please run again using valid task code.");
end



%Set time variables
baseTime = output.dc.time(1,1);
correctedTime = output.dc.time(:,1) - baseTime - 10;

%This is an algorithm to find the last non blank cell in a column\
%{
lastNonBlank = 0;

for i = numel(output.dc.dataTimeSeries(:,1))
    if ~isempty(output.dc.dataTimeSeries(i,1))
        lastNonBlank = i;
        break;
    end    
end
%}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%     LEFT PFC 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%     OXYGENATED - LEFT PFC 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
ROI = "Left PFC";

%Define each column based on the channel ID
HbO11 = output.dc.dataTimeSeries(103:end,1);
HbO12 = output.dc.dataTimeSeries(103:end,4);
HbO21 = output.dc.dataTimeSeries(103:end,7);
HbO22 = output.dc.dataTimeSeries(103:end,10);

%Define baselines for each channel 
baselineO11 = mean(output.dc.dataTimeSeries(103,1));
baselineO12 = mean(output.dc.dataTimeSeries(103,4));
baselineO21 = mean(output.dc.dataTimeSeries(103,7));
baselineO22 = mean(output.dc.dataTimeSeries(103,10));

%Create a vector to represent a trendline
rowIndex = 1;
averageOLPFC = [;];
numRows = numel(output.dc.dataTimeSeries(1:end,1));

for rowIndex = 1:numRows
    newRowVal = (output.dc.dataTimeSeries(rowIndex,1) + output.dc.dataTimeSeries(rowIndex,4) + output.dc.dataTimeSeries(rowIndex,7) + output.dc.dataTimeSeries(rowIndex,10)) /4;
    averageOLPFC = [averageOLPFC; newRowVal];
    rowIndex = rowIndex + 1;

end

clear newRowVal
clear rowIndex

%Define baseline for trendline
baselineTrendOLPFC = mean(averageOLPFC(101:102));
trendlineOLPFC = averageOLPFC(103:end);

%Write the title for the figure based on ID
titleSpec = "[HbO] for %s - %s - %d";
titleString = sprintf(titleSpec,taskID,ROI,participantID);


%Create plot of the 3 channels
figure
hold on
plot(correctedTime(103:end,1), HbO11 - baselineO11, "LineStyle", ":",'Color',"g")
plot(correctedTime(103:end,1), HbO12 - baselineO12, "LineStyle", ":",'Color',"c")
plot(correctedTime(103:end,1), HbO21 - baselineO21, "LineStyle", ":",'Color',"m")
plot(correctedTime(103:end,1), HbO22 - baselineO22, "LineStyle", ":",'Color',"y")
plot(correctedTime(103:end,1), trendlineOLPFC - baselineTrendOLPFC,'Color','r')
title(titleString)
xlabel('Time (s)')
ylabel('Concentration (µM)')
legend("S1-D1","S1-D2","S2-D1","S2-D2","HbO",'Location','southeastoutside')
hold off


clear titleSpec
clear titleString
%End of creation of left PFC graph

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%     DEOXYGENATED - LEFT PFC 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Define each column based on the type & source-detector
HbR11 = output.dc.dataTimeSeries(103:end,2);
HbR12 = output.dc.dataTimeSeries(103:end,5);
HbR21 = output.dc.dataTimeSeries(103:end,8);
HbR22 = output.dc.dataTimeSeries(103:end,11);

%Define baselines for each channel
baselineR11 = mean(output.dc.dataTimeSeries(80:103,2));
baselineR12 = mean(output.dc.dataTimeSeries(80:103,5));
baselineR21 = mean(output.dc.dataTimeSeries(80:103,8));
baselineR22 = mean(output.dc.dataTimeSeries(80:103,11));


%Create a vector to represent a trendline
rowIndex = 1;
averageRLPFC = [;];
numRows = numel(output.dc.dataTimeSeries(1:end,2));

for rowIndex = 1:numRows
    newRowVal = (output.dc.dataTimeSeries(rowIndex,2) + output.dc.dataTimeSeries(rowIndex,5) + output.dc.dataTimeSeries(rowIndex,8) + output.dc.dataTimeSeries(rowIndex,11)) /4;
    averageRLPFC = [averageRLPFC; newRowVal];
    rowIndex = rowIndex + 1;

end

clear newRowVal
clear rowIndex

%Define baseline for trendline
baselineTrendRLPFC = mean(averageRLPFC(1:102));
trendlineRLPFC = averageRLPFC(103:end);

%Write the title for the figure based on ID
titleSpec = "[HbR] for %s - %s - %d";
titleString = sprintf(titleSpec,taskID,ROI,participantID);

%Create plot of the 3 channels
figure
hold on
plot(correctedTime(103:end,1), HbR11-baselineR11, "LineStyle", ":",'Color',"g")
plot(correctedTime(103:end,1), HbR12-baselineR12, "LineStyle", ":",'Color',"c")
plot(correctedTime(103:end,1), HbR21-baselineR21, "LineStyle", ":",'Color',"m")
plot(correctedTime(103:end,1), HbR22-baselineR22, "LineStyle", ":",'Color',"y")
plot(correctedTime(103:end,1), trendlineRLPFC-baselineTrendRLPFC,'Color',"b")
title(titleString)
xlabel('Time (s)')
ylabel('Concentration (µM)')
legend("S1-D1","S1-D2","S2-D1","S2-D2","HbR",'Location','southeastoutside')
hold off

clear titleSpec
clear titleString

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%     TOTAL HEMODYNAMICS - LEFT PFC 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Write the title for the figure based on ID
titleSpec = "Total Hemodynamics for %s - %s - %d";
titleString = sprintf(titleSpec,taskID,ROI,participantID);


fig = figure;
left_color = [1 0 0];
right_color = [0 0 1];
set(fig,'defaultAxesColorOrder',[left_color; right_color]);
hold on
yyaxis left
plot(correctedTime(103:end,1), trendlineOLPFC - baselineTrendOLPFC,'Color','r')
yyaxis right
plot(correctedTime(103:end,1), trendlineRLPFC-baselineTrendRLPFC,'Color',"b")
title(titleString)
xlabel('Time (s)')
ylabel('Concentration (µM)')
legend("HbO","HbR",'Location','southeastoutside')
hold off

clear titleSpec
clear titleString






%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%     LEFT M1
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%     OXYGENATED - LEFT M1
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Define each column based on the type & source-detector
HbO33 = output.dc.dataTimeSeries(103:end,13);
HbO34 = output.dc.dataTimeSeries(103:end,16);
HbO43 = output.dc.dataTimeSeries(103:end,19);
HbO44 = output.dc.dataTimeSeries(103:end,22);

%Define baselines for each channel
baselineO33 = mean(output.dc.dataTimeSeries(1:103,13));
baselineO34 = mean(output.dc.dataTimeSeries(1:103,16));
baselineO43 = mean(output.dc.dataTimeSeries(1:103,19));
baselineO44 = mean(output.dc.dataTimeSeries(1:103,22));


%Create a vector to represent a trendline
rowIndex = 1;
averageOLM1 = [;];
numRows = numel(output.dc.dataTimeSeries(:,13));

for rowIndex = 1:numRows
    newRowVal = (output.dc.dataTimeSeries(rowIndex,13) + output.dc.dataTimeSeries(rowIndex,16) + output.dc.dataTimeSeries(rowIndex,19) + output.dc.dataTimeSeries(rowIndex,22)) /4;
    averageOLM1 = [averageOLM1; newRowVal];
    rowIndex = rowIndex + 1;

end

clear newRowVal
clear rowIndex

%Define baseline for trendline
baselineTrendOLM1 = mean(averageOLM1(1:102));
trendlineOLM1 = averageOLM1(103:end);

%Write the title for the figure based on ID
titleSpec = "[HbO] for %s - Left M1 - %d";
titleString = sprintf(titleSpec,taskID,participantID);


%Create plot of the 3 channels
figure
hold on
plot(correctedTime(103:end,1), HbO33-baselineO33, "LineStyle", ":",'Color',"g")
plot(correctedTime(103:end,1), HbO34-baselineO34, "LineStyle", ":",'Color',"c")
plot(correctedTime(103:end,1), HbO43-baselineO43, "LineStyle", ":",'Color',"m")
plot(correctedTime(103:end,1), HbO44-baselineO44, "LineStyle", ":",'Color',"y")
plot(correctedTime(103:end,1), trendlineOLM1-baselineTrendOLM1,'Color',"r")
title(titleString)
xlabel('Time (s)')
ylabel('Concentration (µM)')
legend("S3-D3","S3-D4","S4-D3","S4-D4","HbO",'Location','southeastoutside')
hold off


clear titleSpec
clear titleString


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%     DEOXYGENATED - LEFT M1
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Define each column based on the type & source-detector
HbR33 = output.dc.dataTimeSeries(103:end,14);
HbR34 = output.dc.dataTimeSeries(103:end,17);
HbR43 = output.dc.dataTimeSeries(103:end,20);
HbR44 = output.dc.dataTimeSeries(103:end,23);

%Define baselines for each channel
baselineR33 = mean(output.dc.dataTimeSeries(1:103,14));
baselineR34 = mean(output.dc.dataTimeSeries(1:103,17));
baselineR43 = mean(output.dc.dataTimeSeries(1:103,20));
baselineR44 = mean(output.dc.dataTimeSeries(1:103,23));


%Create a vector to represent a trendline
rowIndex = 1;
averageRLM1 = [;];
numRows = numel(output.dc.dataTimeSeries(:,14));

for rowIndex = 1:numRows
    newRowVal = (output.dc.dataTimeSeries(rowIndex,14) + output.dc.dataTimeSeries(rowIndex,17) + output.dc.dataTimeSeries(rowIndex,20) + output.dc.dataTimeSeries(rowIndex,23)) /4;
    averageRLM1 = [averageRLM1; newRowVal];
    rowIndex = rowIndex + 1;

end

clear newRowVal
clear rowIndex

%Define baseline for trendline
baselineTrendRLM1 = mean(averageRLM1(1:102));
trendlineRLM1 = averageRLM1(103:end);

%Write the title for the figure based on ID
titleSpec = "[HbR] for %s - Left M1 - %d";
titleString = sprintf(titleSpec,taskID,participantID);


%Create plot of the 3 channels
figure
hold on
plot(correctedTime(103:end,1), HbR33-baselineR33, "LineStyle", ":",'Color',"g")
plot(correctedTime(103:end,1), HbR34-baselineR34, "LineStyle", ":",'Color',"c")
plot(correctedTime(103:end,1), HbR43-baselineR43, "LineStyle", ":",'Color',"m")
plot(correctedTime(103:end,1), HbR44-baselineR44, "LineStyle", ":",'Color',"y")
plot(correctedTime(103:end,1), trendlineRLM1-baselineTrendRLM1,'Color',"b")
title(titleString)
xlabel('Time (s)')
ylabel('Concentration (µM)')
legend("S3-D3","S3-D4","S4-D3","S4-D4","HbR",'Location','southeastoutside')
hold off

clear titleSpec
clear titleString


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%     TOTAL HEMODYNAMICS - LEFT M1
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Write the title for the figure based on ID
titleSpec = "Total Hemodynamics for %s - Left M1 - %d";
titleString = sprintf(titleSpec,taskID,participantID);


fig = figure;
left_color = [1 0 0];
right_color = [0 0 1];
set(fig,'defaultAxesColorOrder',[left_color; right_color]);
hold on
yyaxis left
plot(correctedTime(103:end,1), trendlineOLM1 - baselineTrendOLM1,'Color','r')
yyaxis right
plot(correctedTime(103:end,1), trendlineRLM1 - baselineTrendRLM1,'Color',"b")
title(titleString)
xlabel('Time (s)')
ylabel('Concentration (µM)')
legend("HbO","HbR",'Location','southeastoutside')
hold off

clear titleSpec
clear titleString










%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%     RIGHT PFC
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%     OXYGENATED - RIGHT PFC
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Define each column based on the type & source-detector
HbO55 = output.dc.dataTimeSeries(103:end,25);
HbO56 = output.dc.dataTimeSeries(103:end,28);
HbO65 = output.dc.dataTimeSeries(103:end,31);
HbO66 = output.dc.dataTimeSeries(103:end,34);

%Define baselines for each channel
baselineO55 = mean(output.dc.dataTimeSeries(101:103,25));
baselineO56 = mean(output.dc.dataTimeSeries(101:103,28));
baselineO65 = mean(output.dc.dataTimeSeries(101:103,31));
baselineO66 = mean(output.dc.dataTimeSeries(101:103,34));

%Create a vector to represent a trendline
rowIndex = 1;
averageORPFC = [;];
numRows = numel(output.dc.dataTimeSeries(:,25));

for rowIndex = 1:numRows
    newRowVal = (output.dc.dataTimeSeries(rowIndex,25) + output.dc.dataTimeSeries(rowIndex,28) + output.dc.dataTimeSeries(rowIndex,31) + output.dc.dataTimeSeries(rowIndex,34)) /4;
    averageORPFC = [averageORPFC; newRowVal];
    rowIndex = rowIndex + 1;

end

clear newRowVal
clear rowIndex

%Define baseline for trendline
baselineTrendORPFC = mean(averageORPFC(101:103));
trendlineORPFC = averageORPFC(103:end);

%Write the title for the figure based on ID
titleSpec = "[HbO] for %s - Right PFC - %d";
titleString = sprintf(titleSpec,taskID,participantID);

%Create plot of the 3 channels
figure
hold on
plot(correctedTime(103:end,1), HbO55-baselineO55, "LineStyle", ":",'Color',"g")
plot(correctedTime(103:end,1), HbO56-baselineO56, "LineStyle", ":",'Color',"c")
plot(correctedTime(103:end,1), HbO65-baselineO65, "LineStyle", ":",'Color',"m")
plot(correctedTime(103:end,1), HbO66-baselineO66, "LineStyle", ":",'Color',"y")
plot(correctedTime(103:end,1), trendlineORPFC-baselineTrendORPFC,'Color','r')
title(titleString)
xlabel('Time (s)')
ylabel('Concentration (µM)')
legend("S5-D5","S5-D6","S6-D5","S6-D6","HbO",'Location','southeastoutside')
hold off

clear titleSpec
clear titleString

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%     DEOXYGENATED - RIGHT PFC
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Define each column based on the type & source-detector
HbR55 = output.dc.dataTimeSeries(103:end,26);
HbR56 = output.dc.dataTimeSeries(103:end,29);
HbR65 = output.dc.dataTimeSeries(103:end,32);
HbR66 = output.dc.dataTimeSeries(103:end,35);

%Define baselines for each channel
baselineR55 = mean(output.dc.dataTimeSeries(1:103,26));
baselineR56 = mean(output.dc.dataTimeSeries(1:103,29));
baselineR65 = mean(output.dc.dataTimeSeries(1:103,32));
baselineR66 = mean(output.dc.dataTimeSeries(1:103,35));

%Create a vector to represent a trendline
rowIndex = 1;
averageRRPFC = [;];
numRows = numel(output.dc.dataTimeSeries(:,26));

for rowIndex = 1:numRows
    newRowVal = (output.dc.dataTimeSeries(rowIndex,26) + output.dc.dataTimeSeries(rowIndex,29) + output.dc.dataTimeSeries(rowIndex,32) + output.dc.dataTimeSeries(rowIndex,35)) /4;
    averageRRPFC = [averageRRPFC; newRowVal];
    rowIndex = rowIndex + 1;

end

clear newRowVal
clear rowIndex

%Define baseline for trendline
baselineTrendRRPFC = mean(averageRRPFC(1:103));
trendlineRRPFC = averageRRPFC(103:end);

%Write the title for the figure based on ID
titleSpec = "[HbR] for %s - Right PFC - %d";
titleString = sprintf(titleSpec,taskID,participantID);

%Create plot of the 3 channels
figure
hold on
plot(correctedTime(103:end,1), HbR55-baselineR55, "LineStyle", ":",'Color',"g")
plot(correctedTime(103:end,1), HbR56-baselineR56, "LineStyle", ":",'Color',"c")
plot(correctedTime(103:end,1), HbR65-baselineR65, "LineStyle", ":",'Color',"m")
plot(correctedTime(103:end,1), HbR66-baselineR66, "LineStyle", ":",'Color',"y")
plot(correctedTime(103:end,1), trendlineRRPFC-baselineTrendRRPFC,'Color','b')
title(titleString)
xlabel('Time (s)')
ylabel('Concentration (µM)')
legend("S5-D5","S5-D6","S6-D5","S6-D6","HbR",'Location','southeastoutside')
hold off

clear titleSpec
clear titleString


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%     TOTAL HEMODYNAMICS - RIGHT PFC
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Write the title for the figure based on ID
titleSpec = "Total Hemodynamics for %s - Right PFC - %d";
titleString = sprintf(titleSpec,taskID,participantID);


fig = figure;
left_color = [1 0 0];
right_color = [0 0 1];
set(fig,'defaultAxesColorOrder',[left_color; right_color]);
hold on
yyaxis left
plot(correctedTime(103:end,1), trendlineORPFC - baselineTrendORPFC,'Color','r')
yyaxis right
plot(correctedTime(103:end,1), trendlineRRPFC - baselineTrendRRPFC,'Color',"b")
title(titleString)
xlabel('Time (s)')
ylabel('Concentration (µM)')
legend("HbO","HbR",'Location','southeastoutside')
hold off

clear titleSpec
clear titleString








%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%     RIGHT M1
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%     OXYGENATED - RIGHT M1
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Define each column based on the type & source-detector
HbO77 = output.dc.dataTimeSeries(103:end,37);
HbO78 = output.dc.dataTimeSeries(103:end,40);
HbO87 = output.dc.dataTimeSeries(103:end,43);
HbO88 = output.dc.dataTimeSeries(103:end,46);

%Define baselines for each channel
baselineO77 = mean(output.dc.dataTimeSeries(1:103,37));
baselineO78 = mean(output.dc.dataTimeSeries(1:103,40));
baselineO87 = mean(output.dc.dataTimeSeries(1:103,43));
baselineO88 = mean(output.dc.dataTimeSeries(1:103,46));

%Create a vector to represent a trendline
rowIndex = 1;
averageORM1 = [;];
numRows = numel(output.dc.dataTimeSeries(:,37));

for rowIndex = 1:numRows
    newRowVal = (output.dc.dataTimeSeries(rowIndex,37) + output.dc.dataTimeSeries(rowIndex,40) + output.dc.dataTimeSeries(rowIndex,43) + output.dc.dataTimeSeries(rowIndex,46)) /4;
    averageORM1 = [averageORM1; newRowVal];
    rowIndex = rowIndex + 1;

end

clear newRowVal
clear rowIndex

%Define baseline for trendline
baselineTrendORM1 = mean(averageORM1(1:103));
trendlineORM1 = averageORM1(103:end);

%Write the title for the figure based on ID
titleSpec = "[HbO] for %s - Right M1 - %d";
titleString = sprintf(titleSpec,taskID,participantID);

%Create plot of the 3 channels
figure
hold on
plot(correctedTime(103:end,1), HbO77-baselineO77, "LineStyle", ":",'Color',"g")
plot(correctedTime(103:end,1), HbO78-baselineO78, "LineStyle", ":",'Color',"c")
plot(correctedTime(103:end,1), HbO87-baselineO87, "LineStyle", ":",'Color',"m")
plot(correctedTime(103:end,1), HbO88-baselineO88, "LineStyle", ":",'Color',"y")
plot(correctedTime(103:end,1), trendlineORM1-baselineTrendORM1,'Color','r')
title(titleString)
xlabel('Time (s)')
ylabel('Concentration (µM)')
legend("S7-D7","S7-D8","S8-D7","S8-D8","HbO",'Location','southeastoutside')
hold off

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%     DEOXYGENATED - RIGHT M1
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Define each column based on the type & source-detector
HbR77 = output.dc.dataTimeSeries(103:end,38);
HbR78 = output.dc.dataTimeSeries(103:end,41);
HbR87 = output.dc.dataTimeSeries(103:end,44);
HbR88 = output.dc.dataTimeSeries(103:end,47);

%Define baselines for each channel
baselineR77 = mean(output.dc.dataTimeSeries(1:103,38));
baselineR78 = mean(output.dc.dataTimeSeries(1:103,41));
baselineR87 = mean(output.dc.dataTimeSeries(1:103,44));
baselineR88 = mean(output.dc.dataTimeSeries(1:103,47));

%Create a vector to represent a trendline
rowIndex = 1;
averageRRM1 = [;];
numRows = numel(output.dc.dataTimeSeries(:,38));

for rowIndex = 1:numRows
    newRowVal = (output.dc.dataTimeSeries(rowIndex,38) + output.dc.dataTimeSeries(rowIndex,41) + output.dc.dataTimeSeries(rowIndex,44) + output.dc.dataTimeSeries(rowIndex,47)) /4;
    averageRRM1 = [averageRRM1; newRowVal];
    rowIndex = rowIndex + 1;

end

clear newRowVal
clear rowIndex

%Define baseline for trendline
baselineTrendRRM1 = mean(averageRRM1(1:103));
trendlineRRM1 = averageRRM1(103:end);

%Write the title for the figure based on ID
titleSpec = "[HbR] for %s - Right M1 - %d";
titleString = sprintf(titleSpec,taskID,participantID);

%Create plot of the 3 channels
figure
hold on
plot(correctedTime(103:end,1), HbR77-baselineR77, "LineStyle", ":",'Color',"g")
plot(correctedTime(103:end,1), HbR78-baselineR78, "LineStyle", ":",'Color',"c")
plot(correctedTime(103:end,1), HbR87-baselineR87, "LineStyle", ":",'Color',"m")
plot(correctedTime(103:end,1), HbR88-baselineR88, "LineStyle", ":",'Color',"y")
plot(correctedTime(103:end,1), trendlineRRM1-baselineTrendRRM1,'Color','b')
title(titleString)
xlabel('Time (s)')
ylabel('Concentration (µM)')
legend("S7-D7","S7-D8","S8-D7","S8-D8","HbR",'Location','southeastoutside')
hold off


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%     TOTAL HEMODYNAMICS - RIGHT M1
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Write the title for the figure based on ID
titleSpec = "Total Hemodynamics for %s - Right M1 - %d";
titleString = sprintf(titleSpec,taskID,participantID);

fig = figure;
left_color = [1 0 0];
right_color = [0 0 1];
set(fig,'defaultAxesColorOrder',[left_color; right_color]);
hold on
yyaxis left
plot(correctedTime(103:end,1), trendlineORM1 - baselineTrendORM1,'Color','r')
yyaxis right
plot(correctedTime(103:end,1), trendlineRRM1 - baselineTrendRRM1,'Color',"b")
title(titleString)
xlabel('Time (s)')
ylabel('Concentration (µM)')
legend("HbO","HbR",'Location','southeastoutside')
hold off

clear titleSpec
clear titleString








