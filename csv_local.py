import csv


# -----------------------------------------------------------
# FIXME: NOW THIS FUNCTION REWRITES CSV FILE, NOT ADDS
# Writes data to the given csv file.
# Parameters:
#
# path_to_file: path to csv file
# data: numpy array
# -----------------------------------------------------------
def add_data_to_csv(path_to_file, data):
	with open(path_to_file, mode="w", encoding='utf-8') as csv_file:
		writer = csv.writer(csv_file, quoting=csv.QUOTE_ALL)
		for row in data:
			writer.writerow(row)

