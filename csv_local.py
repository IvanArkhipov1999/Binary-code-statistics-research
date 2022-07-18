import csv
import pandas


# -----------------------------------------------------------
# Writes data to the given csv file. If there was data in csv,
# it rewrites data.
# Parameters:
#
# path_to_file: path to csv file
# data: numpy array
# -----------------------------------------------------------
def write_data_to_csv(path_to_file, data):
	with open(path_to_file, mode="w", encoding='utf-8') as csv_file:
		writer = csv.writer(csv_file, quoting=csv.QUOTE_ALL)
		for row in data:
			writer.writerow(row)


# -----------------------------------------------------------
# Writes data to the given csv file. Add new columns in csv file.
# Parameters:
#
# path_to_file: path to csv file
# data: numpy array
# -----------------------------------------------------------
def add_data_to_csv(path_to_file, data):
	dataframe = pandas.read_csv(path_to_file)
	for column in data.transpose():
		dataframe[column[0]] = column[1:]
	dataframe.to_csv(path_to_file, index=False)

