function [data_set, dataset_L, test_data, test_L] = resample(data_set, dataset_L, test_data, test_L, index)
    temp_data = test_data;
    temp_L = test_L;
    for i = 0 : 9
        % swap the data and the label of the test and the data_set
        test_data(:,:,:,100*i+1:100*i+100) = data_set(:,:,:,5900*i+501+100*index:5900*i+600+100*index); 
        test_L(100*i+1:100*i+100) = dataset_L(5900*i+501+100*index:5900*i+600+100*index); 
        data_set(:,:,:,5900*i+501+100*index:5900*i+600+100*index) = temp_data(:,:,:,100*i+1:100*i+100);
        dataset_L(5900*i+501+100*index:5900*i+600+100*index) = temp_L(100*i+1:100*i+100);
    end
end
