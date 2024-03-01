filer <- list.files("./files/")

for (i in filer) {
  infiler <- list.files(paste0("./files/", i), pattern = "_all.csv")
  print(i)
  for (j in infiler) {
    print(j)
    file.remove(paste0("./files/",i,"/",j))
  }
}
