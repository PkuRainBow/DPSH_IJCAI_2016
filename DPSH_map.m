function [map] = DPSH_map(codelens)
    load('cifar-10-a.mat');
    load(['net_',num2str(codelens),'.mat']);
    [map,~,~] = test_map(net, dataset_L, test_L,data_set, test_data, codelens);
    fprintf('code-length : %d  map : %f\n' , codelens, map);
end
