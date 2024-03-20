library(bench)
library(microbenchmark)

# How long does it take to create the contact matrices
# for 3 countries?

test_create_mat <- bench::mark(
  create_contact_matrices_0to80(testdat_pop, test_countries)
)

test_create_mat
plot(test_create_mat)

# Which is quicker: for loops or map function for writing csv?
test_save_csv <- microbenchmark(
  tmap = savemat_map(testdat_contact),
  tfor = savemat_for(testdat_contact)
)

test_save_csv
