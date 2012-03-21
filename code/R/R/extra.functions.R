rhrwap <- function(code=NULL,before=NULL,trap.errors=FALSE){
	#trick R CMD check Rhipe to not note rhcounter doesn't exist
	rhcounter = function(...) return(...)
	co <- substitute(code); before=substitute(before)
	err <- if(trap.errors) function(e) rhcounter("R_ERRORS",as.character(e),1) else function(e) rhcounter("R_UNTRAPPED_ERRORS",as.character(e),1)
	as.expression(bquote({
	.(BE)
	lapply(map.values,function(r){
	  tryCatch(
		       .(CO)             
		       ,error=.(TRAP))
	})
	},list(CO=co,BE=before,TRAP=err)))
}


rhextract <-  function(alist, what="keys",unlist=FALSE,lapply=lapply,...){
  what <- what[pmatch(what,c("keys","values"))]
  j <- if(what=="keys") lapply( alist,"[[",1) else lapply(alist, "[[",2)
  if(unlist) unlist(j, ...) else j
} # lapply could be mclapply




