function s=eul(T,str)


s=struct;

% convert from xyz to 123
con=double(str)-119;

% get gamma
sign2=round(((con(1)==con(3))*(-2*((~(~(con(3)-con(2)+1)))*...
	(~(~(con(3)-con(2)-2))))+1))+~(con(1)==con(3)));

sign1=round(~(isequal(con(1),con(3)))*-2*(any(diff(con)==1))+1);

s.g=atan2(sign1*T(con(1),con(2)),sign2*T(con(1),6-sum([con(3),con(2)])));

% get alpha
sign2=sign2-(~(con(3)-con(1)))*2*sign2;

s.a=atan2(sign1*T(con(2),con(3)),sign2*T(6-sum([con(1),con(2)]),con(3)));

% get beta
T1=eval(['T/rot',str(3),'(',num2str(s.g),')']);

sign1=~(con(2)-1)*2-1;

s.b=atan2(sign1*T1((~(con(2)-3)-1)*-2+1,1-(~(con(2)-2)-1)),...
	T1((~(con(2)-3)-1)*-2+1,(~(con(2)-3)-1)*-2+1));

end