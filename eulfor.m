function s = eulfor(a,b,g,con)
	
	
	s = eval(['rot',con(1),'(',num2str(a),')*','rot',con(2),'(',num2str(b),')*','rot',con(3),'(',num2str(g),')']);
	
end