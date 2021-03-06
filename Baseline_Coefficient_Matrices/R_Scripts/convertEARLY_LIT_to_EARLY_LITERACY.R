#####################################################################
###
### Convert EARLY_LIT to EARLY_LITERACY
###
#####################################################################

require(SGP)

for (name.iter in list.files("..", pattern="RLI")) {

	load(paste("../", name.iter, sep=""))
	tmp.file.name <- paste(head(unlist(strsplit(name.iter, "[.]")), -1), collapse=".")
	tmp.file <- get(tmp.file.name)

	### Change EARLY_LIT in names of list

	if (length(grep("EARLY_LIT", names(tmp.file))) > 0) {
		names(tmp.file) <- gsub("EARLY_LIT", "EARLY_LITERACY", names(tmp.file))

		for (j in grep("EARLY_LITERACY", names(tmp.file))) {
			names(tmp.file[[j]]) <- gsub("EARLY_LIT", "EARLY_LITERACY", names(tmp.file[["EARLY_LITERACY.BASELINE"]]))

			### Change slot @Content_Areas EARLY_LIT to EARLY_LITERACY

			for (k in seq(length(tmp.file[[j]]))) {
				tmp.file[[j]][[k]]@Content_Areas[[1]] <- gsub("EARLY_LIT", "EARLY_LITERACY", tmp.file[[j]][[k]]@Content_Areas[[1]])
			}
		}
		assign(tmp.file.name, tmp.file)
		save(list=tmp.file.name, file=name.iter, compress="xz")
	}
}
