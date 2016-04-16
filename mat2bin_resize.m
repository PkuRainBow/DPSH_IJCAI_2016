function mat2bin_resize
X = [] ;
L = [] ;
for i=1:5
    clear data labels batch_label;
    load(['cifar-10-batches-mat/data_batch_' num2str(i) '.mat']);
    data = reshape(data',[32,32,3,10000]);
    data = permute(data,[2,1,3,4]);
    data = imresize(data, [224,224]) ;
    data = reshape(data,[150528,10000]);
    data = data';
    X = cat(1,X,data) ;
    L = cat(1,L,labels) ;
end
clear data labels;
load('cifar-10-batches-mat/test_batch.mat');
data=reshape(data',[32,32,3,10000]);
data = permute(data,[2,1,3,4]);
data = imresize(data, [224,224]) ;
data = reshape(data,[150528,10000]);
data = data';
X = cat(1,X,data) ;
L = cat(1,L,labels) ;


test_data = [];
test_L = [];
data_set = [];
dataset_L = [];
train_data = [];
train_L = [];
for label=0:9
    index = find(L==label);
    N = size(index,1) ;
    perm = randperm(N) ;
    index = index(perm);

    data = X(index(1:100),:);    
    labels = L(index(1:100));
    test_L = cat(1,test_L,labels) ;
    test_data = cat(1,test_data,data) ;  

    data = X(index(101:6000),:);    
    labels = L(index(101:6000));
    dataset_L = cat(1,dataset_L,labels) ;
    data_set = cat(1,data_set,data) ;
    
    data = X(index(101:600),:);    
    labels = L(index(101:600));
    train_L = cat(1,train_L,labels) ;
    train_data = cat(1,train_data,data) ;    
end

% random shuffle the training data and test data 
index_rand = randperm(5000) ;
train_data_rand = train_data(index_rand, :);
train_L_rand = train_L(index_rand);

index_rand = randperm(1000) ;
test_data_rand = test_data(index_rand, :);
test_L_rand = test_L(index_rand);

% write the train bin file 
train_bin = 'cifar-train-resize.bin';
train_data_L = [train_L_rand, train_data_rand]';
trainFile = fopen(train_bin,'w');
fwrite(trainFile,train_data_L,'uint8');
fclose(trainFile);

% write the test bin file 
test_bin = 'cifar-test-resize.bin';
test_data_L = [test_L_rand, test_data_rand]';
testFile = fopen(test_bin,'w');
fwrite(testFile,test_data_L,'uint8');
fclose(testFile);

% write the dataset bin file 
data_bin = 'cifar-data-resize.bin';
data_L = [dataset_L, data_set]';
dataFile = fopen(data_bin,'w');
fwrite(dataFile,data_L,'uint8');
fclose(dataFile);

end

