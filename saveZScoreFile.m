%  After running ZScorePlots.m ...
%
%
%  ... run this to create a .mat file

% CREATE A CELL ARRAY WITH THE FULL DATA FROM THE Z SCORE MATRIX AND
% HEADERS
participantIDHeader = {participantID,participantID,participantID,participantID,participantID,participantID,participantID,participantID};
identifierHeader = {"Z Score HbO Left PFC","Z Score HbR Left PFC","Z Score HbO Left M1","Z Score HbR Left M1","Z Score HbO Right PFC","Z Score HbR Right PFC","Z Score HbO Right M1","Z Score HbR Right M1"};

zScoresAll = [zOLPFC zRLPFC zOLM1 zRLM1 zORPFC zRRPFC zORM1 zRRM1];

zScoresMatrix = [participantIDHeader; identifierHeader; num2cell(zScoresAll)];


% set the z score array file name
filenameSpec = "zScores_%d_%s.mat";
filename = sprintf(filenameSpec,participantID,taskCode);

% set the file destination
folderpath = 'C:\Users\General Use\Desktop\Z SCORE FILES';
full_file_path = fullfile(folderpath,filename);

% Save the z scores to a .mat file
save(full_file_path,"zScoresMatrix");



% DO THE SAME BUT THIS TIME SAVE THE CELL ARRAY AS A .CSV FILE
zScoresTable = cell2table(zScoresMatrix);

tablefilenameSpec = "zScores_%d_%s.csv";
tablefilename = sprintf(tablefilenameSpec,participantID,taskCode);

tablepath = 'C:\Users\General Use\Desktop\Z SCORE FILES';
full_table_path = fullfile(tablepath,tablefilename);

writetable(zScoresTable,full_table_path)


