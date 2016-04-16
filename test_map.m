function [map,B_dataset,B_test] = test_map(net, dataset_L, test_L,data_set, test_data, codelens )
    S = compute_S(dataset_L,test_L) ;
    file = ['hash_code_',num2str(codelens),'.mat'];
    load(file);
    map = return_map (B_dataset, B_test, S) ;
end