%function [B_dataset,B_test,map] = DPSH(codelens)
function  DPSH(codelens)
    %% prepare the dataset
    %% data_prepare;
    %% load the pre-trained CNN
    net = load('imagenet-vgg-f.mat') ;
    %% load the Dataset
    load('cifar-10-a.mat') ;
    % save('cifar-10.mat','test_data','test_L','data_set','dataset_L','train_data','train_L');
    %[data_set, dataset_L, test_data, test_L] = resample(data_set, dataset_L, test_data, test_L, i);
    
    %% initialization
    maxIter = 200;
    lr = 1e-2 ;
    net = net_structure (net, codelens);
    U = zeros(size(train_data,4),codelens);

    for iter = 1: maxIter
        [net,U] = train(train_data,train_L,U,net,iter,lr, 128) ;
        %% learning rate changes
        if mod(iter,20)==0
            lr = lr*(2/3);
        end
        save(['net_',num2str(codelens),'.mat'], 'net')
    end
    %% testing
%     [map,B_dataset,B_test] = test(net, dataset_L, test_L,data_set, test_data );
%     fprintf('iter : %d  map : %f\n' , i, map);

end