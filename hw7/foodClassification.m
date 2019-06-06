close all; clear; clc;
%% Import the data
load('nutritionTrain.mat');
load('nutritionTest.mat');

trainData = nutrition(:,[1,2,4,6,10,14,15,24]);
testData = nutritionTest(:,[1,2,4,6,10,14,15,24]);

% see the head of data
head(trainData);
head(testData);

% convert from table to array
A = table2array(trainData(:,2:7));
A_test = table2array(testData(:,2:7));

% make all NaNs 0
A(isnan(A))=0;
A_test(isnan(A_test)) = 0;

% groups of indexes
vegetables = 1:20; fruits = 21:40; seafood = 41:61;

% size of scatterplot dots
size = 20;


%% visualize the data
groups = table2array(trainData(:,8));
varNames = {'Calories','TotalFat','Sodium','TotalCarbohydrate','Sugars','Protein'};

figure();
parallelcoords(A, 'group', groups,'standardize','on','labels',varNames,'quantile',.25);
title('Parallel Coordinates Plot of Training Data');

% % % % % plot 3d scatter of every food group for visual clustering
A_vis = A(:,[2 4 6]);
figure();
scatter3(A_vis(fruits,1),A_vis(fruits,2),A_vis(fruits,3),size,'blue'); hold on;
scatter3(A_vis(vegetables,1),A_vis(vegetables,2),A_vis(vegetables,3),size,[0.9100    0.4100    0.1700]); hold on;
scatter3(A_vis(seafood,1),A_vis(seafood,2),A_vis(seafood,3),size,'red');
title('Scatter of macros from training data'); legend('Fruits','Veggies','Seafood');
xlabel('Total Fat'); ylabel('Total Carbs'); zlabel('Total Protein');

%% Take SVD and compute signatures
[U,S,V] = svd(A);

signatures = A*V;

% signatures represent projection of a particular data point on the basis V

%% visualize signatures of train data

groups = table2array(trainData(:,8));
varNames = {'1','2','3','4','5','6'};

figure();
parallelcoords(signatures, 'group', groups,'standardize','on','labels',varNames,'quantile',.25);
title('Parallel Coordinates Plot of Signatures');

% % plot scatter of every food group
signatures_vis = signatures(:,[1:3]);
figure();
scatter3(signatures_vis(fruits,1),signatures_vis(fruits,2),signatures_vis(fruits,3),size,'blue'); hold on;
scatter3(signatures_vis(vegetables,1),signatures_vis(vegetables,2),signatures_vis(vegetables,3),size,[0.9100    0.4100    0.1700]); hold on;
scatter3(signatures_vis(seafood,1),signatures_vis(seafood,2),signatures_vis(seafood,3),size,'red');
title('Signatures from training data'); legend('Fruits','Veggies','Seafood');
xlabel('1'); ylabel('2'); zlabel('3');


%% average signature for fruits, veggies, seafood
veg_sig = mean(signatures(1:20,:));
figure(); histogram(veg_sig,10); title('veggies average signature');
fruit_sig = mean(signatures(21:40,:));
figure(); histogram(fruit_sig,10); title('fruit average signature');
seafood_sig = mean(signatures(41:61,:));
figure(); histogram(seafood_sig,10); title('seafood average signature');

%% compute new signatures for test data
test_signatures = A_test*V;
for i = 1:6
    subplot(3,2,i);
    histogram(test_signatures(i,:),10);
    title(sprintf('signature of test data %d',i));
end

%% visualize test signatures against the train data

distances = zeros([6,6]);

for i = 1:6
    distances(i,1) = norm(test_signatures(i,:)-veg_sig);
    distances(i,2) = norm(test_signatures(i,:)-fruit_sig);
    distances(i,3) = norm(test_signatures(i,:)-seafood_sig); 
end

bar(distances); legend('veg','fruit','seafood'); 
title('L2 distances of training points from average signatures of each group');



