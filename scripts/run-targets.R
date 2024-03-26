tar_manifest(fields = all_of("command"))

tar_visnetwork()

# Initially took 12m that led to error
# Made targets for 1:3   (3)  - pipeline took 15.75s (5.25s each)
# Made targets for 4:10  (7)  - pipeline took 33.05s (4.7s each)
# Made targets for 11:20 (10) - pipeline took 46.75s (4.675s each)
# Made targets for 21:50 (30) - pipeline took 2.625m (5.25s each)