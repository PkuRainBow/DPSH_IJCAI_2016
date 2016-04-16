function gpu_net = update (gpu_net, res_back, lr, N, batch_size)
    weight_decay = 5*1e-4 ;
    n_layers = 20 ;
    for ii = 1:n_layers
            if isfield(gpu_net.layers{ii},'weights')
                    gpu_net.layers{ii}.weights{1} = gpu_net.layers{ii}.weights{1}+...
                        lr*(res_back(ii).dzdw{1}/(batch_size*N) - weight_decay*gpu_net.layers{ii}.weights{1});
                    gpu_net.layers{ii}.weights{2} = gpu_net.layers{ii}.weights{2}+...
                        lr*(res_back(ii).dzdw{2}/(batch_size*N) - weight_decay*gpu_net.layers{ii}.weights{2});
            end
    end
end
