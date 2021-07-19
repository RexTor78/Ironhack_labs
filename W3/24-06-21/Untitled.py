# function that runs through the dataframe rowwise
def label_race(row):
	# defining column names
    types = ('Type 1', 'Type 2')

	# concatenating both type entries. the "if" makes sure that the 
	# entry is not NaN. If so, the entry isn't added in the join
    return "-".join(row[type_] for type_ in types if row[type_]==row[type_])

pokemon.apply(lambda row: label_race(row), axis=1)