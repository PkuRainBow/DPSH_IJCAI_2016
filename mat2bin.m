function mat2bin
X = [] ;
L = [] ;
for i=1:5
    clear data labels batch_label;
    load(['cifar-10-batches-mat/data_batch_' num2str(i) '.mat']);
    X = cat(1,X,data) ;
    L = cat(1,L,labels) ;
end
clear data labels;
load('cifar-10-batches-mat/test_batch.mat');
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

% write the train bin file 
train_bin = 'cifar-train.bin';
train_data_L = [train_L, train_data]';
trainFile = fopen(train_bin,'w');
fwrite(trainFile,train_data_L,'uint8');
fclose(trainFile);

% write the test bin file 
test_bin = 'cifar-test.bin';
test_data_L = [test_L, test_data]';
testFile = fopen(test_bin,'w');
fwrite(testFile,test_data_L,'uint8');
fclose(testFile);

% write the dataset bin file 
data_bin = 'cifar-data.bin';
data_L = [dataset_L, data_set]';
dataFile = fopen(data_bin,'w');
fwrite(dataFile,data_L,'uint8');
fclose(dataFile);
end

