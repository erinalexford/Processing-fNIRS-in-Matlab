%CODE THAT HOPEFULLY WILL INDEX THE FULL SNIRF FILES AT THE RIGHT SPOTS
%WITHOUT HAVING TO SEGMENT
%WRITTEN BY ERIN ON APRIL 9


clear all
load('1875b_UNCUT.mat', 'output')

participantID = 1875;


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%       SET TIME VARIABLES
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

startVGR_L = 420.053;
startVGR_R = 740.7206;
startRVGR_L = 1064.0425;
startRVGR_R = 1410.9573;
startOH = 1719.4353;
startOHA = 2038.4317;

endVGR_L = startVGR_L + 109;
endVGR_R = startVGR_R + 106;
endRVGR_L = startRVGR_L + 147;
endRVGR_R = startRVGR_R + 152;
endOH = startOH + 139;
endOHA = startOHA + 138;

indexVGR_L = find(output.dc.time>=startVGR_L,1,'first');
indexVGR_R = find(output.dc.time>=startVGR_R,1,'first');
indexRVGR_L = find(output.dc.time>=startRVGR_L,1,'first');
indexRVGR_R = find(output.dc.time>=startRVGR_R,1,'first');
indexOH = find(output.dc.time>=startOH,1,'first');
indexOHA = find(output.dc.time>=startOHA,1,'first');

indexEndVGR_L = find(output.dc.time>=endVGR_L,1,'first');
indexEndVGR_R = find(output.dc.time>=endVGR_R,1,'first');
indexEndRVGR_L = find(output.dc.time>=endRVGR_L,1,'first');
indexEndRVGR_R = find(output.dc.time>=endRVGR_R,1,'first');
indexEndOH = find(output.dc.time>=endOH,1,'first');
indexEndOHA = find(output.dc.time>=endOHA,1,'first');


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%       OBJECT HIT TASK
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%       OXYGENATED
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% left pfc
HbO11 = output.dc.dataTimeSeries(indexOH:indexEndOH,1);
HbO12 = output.dc.dataTimeSeries(indexOH:indexEndOH,4);
HbO21 = output.dc.dataTimeSeries(indexOH:indexEndOH,7);
HbO22 = output.dc.dataTimeSeries(indexOH:indexEndOH,10);

baselineHbO11 = mean(output.dc.dataTimeSeries(indexOH-103:indexOH-1,1));
baselineHbO12 = mean(output.dc.dataTimeSeries(indexOH-103:indexOH-1,4));
baselineHbO21 = mean(output.dc.dataTimeSeries(indexOH-103:indexOH-1,7));
baselineHbO22 = mean(output.dc.dataTimeSeries(indexOH-103:indexOH-1,10));

titleSpec = "[HbO] for Object Hit - Left PFC 0 %d";
titleString = sprintf(titleSpec,participantID);

figure
hold on
plot(HbO11 - baselineHbO11)
plot(HbO12 - baselineHbO12)
plot(HbO21 - baselineHbO21)
plot(HbO22 - baselineHbO22)
title(titleString)
xlabel('Time')
ylabel('Concentration')
legend("1-1","1-2","2-1","2-2",'Location','southeastoutside')
hold off

























