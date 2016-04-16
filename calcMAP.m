% compute mean average precision (MAP)
function [MAP, succRate] = calcMAP (orderH, neighbor)

  [Q, N] = size(neighbor);
  pos = 1: N;
  MAP = zeros(10,1);
  numSucc = 0;
  for i = 1: Q
    ngb = neighbor(i, orderH(i, :));
    nRel = sum(ngb);
    if nRel > 0
      prec = cumsum(ngb) ./ pos;
      ap = mean(prec(ngb));
      index = floor((i-1)/100);
      MAP(index+1) = ap + MAP(index+1);
      numSucc = numSucc + 1;
    end
	% ngb = neighbor(i, orderH(i, :));
	% nRel = sum(ngb);
	% ngb= ngb(1:10000);
    
    % if nRel > 0
      % prec = cumsum(ngb) ./ pos;
      % ap = mean(prec(ngb));
      % MAP = MAP + ap;
      % numSucc = numSucc + 1;
    % end
  end
  MAP = MAP / 100;
  succRate = numSucc / Q;
  for i = 1 : 10
      fprintf('map of class %d : %d\n', i, MAP(i));
  end
end
