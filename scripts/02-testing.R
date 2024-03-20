library(bench)

# How long does it take to create the contact matrices
# for 3 countries?

test_create_mat <- bench::mark(
  create_contact_matrices_0to80(testdat_pop, test_countries)
)

test_create_mat

test_save_csv <- bench::mark(
  tmap = savemat_map(tdat_contact),
  tfor = savemat_for(tdat_contact)
)

