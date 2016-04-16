function [net, U] = train (X1, L1, U, net, iter , lr, batchsize)
    N = size(X1,4) ;
    index = randperm(N) ;
    for j = 0:ceil(N/batchsize)-1
        batch_time=tic ;
        %% random select a minibatch
        ix = index((1+j*batchsize):min((j+1)*batchsize,N)) ;
        %% 128 * 5000 random similiar matrix
        S = calcNeighbor (L1, ix, 1:N) ;
        %% load and preprocess an image
        im = X1(:,:,:,ix) ;
        im_ = single(im) ; % note: 0-255 range
        im_ = imresize(im_, net.meta.normalization.imageSize(1:2)) ;
        im_ = im_ - repmat(net.meta.normalization.averageImage,1,1,1,size(im_,4)) ;
        im_ = gpuArray(im_) ;
        %% run the CNN
        res = vl_simplenn(net, im_) ;
        U0 = squeeze(gather(res(end).x))' ;
        U(ix,:) = U0 ;
        % T : theta
        T = U0 * U' / 2 ;
        A = 1 ./ (1 + exp(-T)) ;
        dJdU = (S - A) * U ;    
        dJdoutput = gpuArray(reshape(dJdU',[1,1,size(dJdU',1),size(dJdU',2)])) ;
        res = vl_simplenn( net, im_, dJdoutput) ;
        %% update the parameters of CNN
        net = update(net , res, lr, N, batchsize) ;
        batch_time = toc(batch_time) ;
        fprintf(' iter %d  batch %d/%d (%.1f images/s) ,lr is %d\n', iter, j+1,ceil(size(X1,4)/batchsize), batchsize/ batch_time,lr) ;
    end
end