%create z score vectors from fnirs data
%
%       !!!! NOTE
%
%
%       !!!! make sure you run AllROIPlots.m first because this uses those variables

folderPath = 'C:\Users\General Use\Desktop\FINISHED FIGS\Z score figs';


titleSpec = "Z Normalized Hemodynamics for %s - %s - %d";

zOLPFC = zscore(trendlineOLPFC - baselineTrendOLPFC);
zRLPFC = zscore(trendlineRLPFC - baselineTrendRLPFC);

zOLM1 = zscore(trendlineOLM1 - baselineTrendOLM1);
zRLM1 = zscore(trendlineRLM1 - baselineTrendRLM1);

zORPFC = zscore(trendlineORPFC - baselineTrendORPFC);
zRRPFC = zscore(trendlineRRPFC - baselineTrendRRPFC);

zORM1 = zscore(trendlineORM1 - baselineTrendORM1);
zRRM1 = zscore(trendlineRRM1 - baselineTrendRRM1);


% CREATE AND SAVE LEFT PFC FIGURE
ROI = "Left PFC";
titleString = sprintf(titleSpec,taskID,ROI,participantID);

figure
hold on
plot(correctedTime(103:end,1), zOLPFC, 'Color', 'r')
plot(correctedTime(103:end,1), zRLPFC, 'Color', 'b')
title(titleString)
xlabel("Time (s)")
ylabel("Z score")
legend("HbO","HbR",'Location','southeastoutside')
hold off

filenameSpec = "zScore %d %s %s.jpg";
filename = sprintf(filenameSpec,participantID,taskCode,ROI);
full_file_path = fullfile(folderPath,filename);

saveas(gcf, full_file_path, 'jpg');
disp(['Figure saved to ' full_file_path]);

clear ROI
clear titleString
clear filenameSpec
clear filename
clear full_file_path


% CREATE AND SAVE LEFT M1 FIGURE
ROI = "Left M1";
titleString = sprintf(titleSpec,taskID,ROI,participantID);

figure
hold on
plot(correctedTime(103:end,1), zOLM1, 'Color', 'r')
plot(correctedTime(103:end,1), zRLM1, 'Color', 'b')
title(titleString)
xlabel("Time (s)")
ylabel("Z score")
legend("HbO","HbR",'Location','southeastoutside')
hold off

filenameSpec = "zScore %d %s %s.jpg";
filename = sprintf(filenameSpec,participantID,taskCode,ROI);
full_file_path = fullfile(folderPath,filename);

saveas(gcf, full_file_path, 'jpg');
disp(['Figure saved to ' full_file_path]);

clear ROI
clear titleString
clear filenameSpec
clear filename
clear full_file_path




% CREATE AND SAVE RIGHT PFC FIGURE
ROI = "Right PFC";
titleString = sprintf(titleSpec,taskID,ROI,participantID);

figure
hold on
plot(correctedTime(103:end,1), zORPFC, 'Color', 'r')
plot(correctedTime(103:end,1), zRRPFC, 'Color', 'b')
title(titleString)
xlabel("Time (s)")
ylabel("Z score")
legend("HbO","HbR",'Location','southeastoutside')
hold off

filenameSpec = "zScore %d %s %s.jpg";
filename = sprintf(filenameSpec,participantID,taskCode,ROI);
full_file_path = fullfile(folderPath,filename);

saveas(gcf, full_file_path, 'jpg');
disp(['Figure saved to ' full_file_path]);

clear ROI
clear titleString
clear filenameSpec
clear filename
clear full_file_path





% CREATE AND SAVE RIGHT M1 FIGURE
ROI = "Right M1";
titleString = sprintf(titleSpec,taskID,ROI,participantID);

figure
hold on
plot(correctedTime(103:end,1), zORM1, 'Color', 'r')
plot(correctedTime(103:end,1), zRRM1, 'Color', 'b')
title(titleString)
xlabel("Time (s)")
ylabel("Z score")
legend("HbO","HbR",'Location','southeastoutside')
hold off

filenameSpec = "zScore %d %s %s.jpg";
filename = sprintf(filenameSpec,participantID,taskCode,ROI);
full_file_path = fullfile(folderPath,filename);

saveas(gcf, full_file_path, 'jpg');
disp(['Figure saved to ' full_file_path]);

clear ROI
clear titleString
clear filenameSpec
clear filename
clear full_file_path





