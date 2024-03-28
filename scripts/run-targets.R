tar_manifest(fields = all_of("command"))

tar_visnetwork()

# Initially took 13m that led to error
# Made targets for 1:3   (3)  - pipeline took 15.75s (5.25s each)
# Made targets for 4:10  (7)  - pipeline took 33.05s (4.7s each)
# Made targets for 11:20 (10) - pipeline took 46.75s (4.675s each)
# Made targets for 21:50 (30) - pipeline took 2.625m (5.25s each)
# Made targets for 51:80 (30) - pipeline took 2.264m (4.53s each)
# Made targets for 81:130 (50) - pipeline took 4.01m (4.81s each)
# Made targets for 131:183 (50) - pipeline took 3.98m (4.77s each)