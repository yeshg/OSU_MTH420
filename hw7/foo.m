load('nutritionTrain.mat');
load('nutritionTest.mat');

trainData = nutrition(:,[1,2,4,6,10,14,15,24]);

% see the head of data
head(trainData);

% convert from table to array
A = table2array(trainData(:,2:7));

% make all NaNs 0
A(isnan(A))=0;

% idk
groups = table2array(trainData(:,8));
varNames = {'Calories','TotalFat','Sodium','TotalCarbohydrate','Sugars','Protein'};

figure();
parallelcoords(A, 'group', groups,'standardize','on','labels',varNames);