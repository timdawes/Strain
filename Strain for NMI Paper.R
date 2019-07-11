# Strain code


# Set base.dir as parent folder of interest
base.dir<- ""
setwd(base.dir)

l<- substr(list.dirs(recursive=F),3,11)
Strain<- matrix(0, nrow=length(l), ncol=3)
colnames(Strain)<- c("Long","Circ","Rad")
rownames(Strain)<- l

for (i in 1:length(l))
{
  cat(i)
  p<- paste(base.dir, l[i], sep="/")
  setwd(p)
  
  for (j in 1:3)
  {
  ED.data<- read.table(paste(base.dir, l[i], "rv_function_components.txt", sep="/"), header=T)[,j]
  ES.data<- read.table(paste(base.dir, l[i], "rv_function_components.txt", sep="/"), header=T)[,j+3]
  ED.dist<- sum(as.matrix(dist(ED.data))[,1])
  ES.dist<- sum(as.matrix(dist(ES.data))[,1])
  S<- 100*(ED.dist - ES.dist) / ED.dist
  sign<- c(-1,-1,1)[j]
  Strain[i,j]<- S*sign
  }
}

Strain
