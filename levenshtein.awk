#Take output of logme.awk and find components of logme messages

#Modifications:
#WBL 28 Feb 2026 Start https://github.com/jamfromouterspace/levenshtein
#    max not implemented. Comment out debug prints

#Usage:
#gawk -f levenshtein.awk -v A="one" -v B="ones"

BEGIN{
  if(max=="") max=2;
  printf("#Created by levenshtein.awk.awk %s ",
		     substr("$Revision: 1.3 $",2));
  printf("max=%s A=%s B=%s %s\n",max,A,B,strftime());
  print levenshtein(max,A,B);
}

function levenshtein(max,A,B,  n,m,i,j,i_,a,b,d,ii_,iii_){
  ;
  n = length(A);
  m = length(B);
  if(n==0) return m;
  if(m==0) return n;
  #Fill the zeroth row with numbers 0 to m
  for(j=0;j<=m;j++) lev[0,j] = j;
  #Fill the zeroth column with numbers 0 to n
  for(i=0;i<=n;i++) lev[i,0] = i;
  #print_lev(A,B,n,m,lev);
  #return 99;
  #Fill the rest of the matrix by taking the minimum of :
  for(i=1;i<=n;i++){ 
  for(j=1;j<=m;j++){
    ;
    if(!((i-1,j)   in lev)) error();
    if(!((i,j-1)   in lev)) error();
    if(!((i-1,j-1) in lev)) error();
    #in gawk strings start at 1 not 0
    a = substr(A,i,1);
    b = substr(B,j,1);
    d = (a!=b)? 1 : 0;
    i_   = lev[i-1,j] + 1;
    ii_  = lev[i,j-1] + 1;
    iii_ = lev[i-1,j-1] + d;
    lev[i,j] = min3(i,j,a,b,  i_,ii_,iii_);
  }}
  #print_lev(A,B,n,m,lev);
  return lev[n,m];
}

function min3(i,j,a,b, x,y,z,  ans){
  ans = (x<y && x<z)? x : ((y<x && y<z)? y : z);
  #printf("min3(%s %s '%s' '%s' %s,%s,%s) %s\n",i,j,a,b,x,y,z,ans);
  return ans;
}

function print_lev(A,B,n,m,lev,  i,j){
  ;
  printf("    ");
  for(j=1;j<=m;j++) printf("%s ",substr(B,j,1)); printf("\n");
  for(i=0;i<=n;i++) {
    ;
    printf("%s ",i? substr(A,i,1) : " ");
    for(j=0;j<=m;j++) printf("%d ",lev[i,j]); printf("\n");
  }
}
