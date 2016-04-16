function map = return_map(B_train, B_test, S)
    [~, orderH] = calcHammingRank (B_train, B_test) ;    
    map = calcMAP(orderH,S');
%     fprintf('map : %d', map);
%     bar(map);
%     title(['DPSH MAP@all codelens = ', num2str(32)]);
end