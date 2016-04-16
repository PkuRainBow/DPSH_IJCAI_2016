function [B_dataset,B_test,map] = DPSH_finetune(codelens, batch_size)
    %% prepare the dataset
    data_prepare;
    %% load the pre-trained CNN
    net = load('imagenet-vgg-f.mat') ;
    %% load the Dataset
    load('cifar-10-a.mat') ;
    %% initialization
    maxIter = 200;
    lr = 1e-2 ;
    net = softmax_net (net, codelens);
    U = zeros(size(train_data,4),codelens);

    %% training
    for iter = 1: maxIter
        [net,U] = finetune(train_data,train_L,U,net,iter,lr, batch_size) ;
        %% learning rate changes
        if mod(iter,20)==0
            lr = lr*(2/3);
        end
        save(['net_',num2str(codelens),'.mat'], 'net')
    end
    %load('net_48.mat');
    %% testing
    [map,B_dataset,B_test] = test(net, dataset_L, test_L,data_set, test_data );
    
end