%assign limit 15
%assign n 3
%assign current 00000100b
%rep limit
	%assign i 1
	%assign isprime 1
	%rep n/2
		%assign i i+1
		%if n % i == 0
			%assign isprime 0
			%exitrep
		%endif
	%endrep
	%if isprime==1
		%assign current (current+(1b<<(n)))
	%endif
	%assign n n+1
%endrep
%assign table current

%macro isprimetest 1
	%assign current table>>%1
	%assign i 2
	%if current % 2==0
		%1 nao e primo
	%else
		%1 e primo
	%endif
%endmacro
_start:
isprimetest 0
isprimetest 1
isprimetest 2
isprimetest 3
isprimetest 4
isprimetest 5
isprimetest 6
isprimetest 7
isprimetest 8
isprimetest 9
isprimetest 10
isprimetest 11
isprimetest 12
isprimetest 13
isprimetest 14
isprimetest 15
isprimetest 16
isprimetest 17
