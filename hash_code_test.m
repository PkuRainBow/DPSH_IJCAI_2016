function hash_code_test(codelens)
    load('cifar-10-a.mat');
    load(['net_',num2str(codelens),'.mat']);
    compute_B_save (data_set,test_data, dataset_L, test_L, net, codelens);
end
