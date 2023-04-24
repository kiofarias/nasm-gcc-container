%assign a 0
%assign x 1
%rep 10
%assign a x+a
%assign x x+1
%endrep

result: dq a
