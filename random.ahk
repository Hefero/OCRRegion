RandomString(number)
{
	s := "0,1,2,3,4,5,6,7,8,9,a,b,c,d,e,f,g,h,i,j,k,l,m,n,o,p,q,r,s,t,u,v,w,x,y,z"

	Loop, 3
	   i .= s . ","

	i := RTrim(i, ",")
	Sort, i, Random D,
	i := StrReplace(i, ",")
	i := SubStr(i, 1, number)
	return i
}